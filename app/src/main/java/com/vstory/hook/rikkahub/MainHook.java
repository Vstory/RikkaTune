package com.vstory.hook.rikkahub;

import static android.util.Log.DEBUG;
import static android.util.Log.INFO;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.widget.Toast;

import java.lang.ref.WeakReference;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import io.github.libxposed.api.XposedInterface;
import io.github.libxposed.api.XposedModule;
import io.github.libxposed.api.XposedModuleInterface;

/**
 * api102 模块入口（java_init.list 声明）。
 * <p>
 * 生命周期：onModuleLoaded → onPackageReady → installHooks
 * 热重载：  onHotReloading(返回true) → unhook 旧 handle → installHooks 重装 + restoreModuleState
 */
public class MainHook extends XposedModule implements HookLogger {

    public static final String TAG = "RikkaTune";

    private ClassLoader mAppClassLoader;

    /** 压缩对话进行中标志（CompressFeedbackHooker 跨类读写，必须 public） */
    public static boolean sCompressInProgress;

    private static int sHookOk;
    private static int sHookFail;
    private static StringBuilder sHookDetail;

    public MainHook() { super(); }

    // ===== 生命周期 =====

    @Override
    public void onModuleLoaded(XposedModuleInterface.ModuleLoadedParam param) {
        Debug.sLogger = this;
        log(INFO, TAG, "api102 module loaded");
        SharedPreferences remotePrefs = getRemotePreferences(Prefs.PREFS_GROUP);
        Prefs.init(remotePrefs);
        // #ifdef DEBUG
        // 监听开关变化 → 实时打印到 LSPosed 框架日志 (INFO 级)
        if (BuildConfig.DEBUG) {
            remotePrefs.registerOnSharedPreferenceChangeListener((prefs, key) -> {
                boolean val = prefs.getBoolean(key, false);
                log(INFO, TAG, "[switch] " + key + " = " + val);
            });
        }
        // #endif
    }

    @Override
    public void onPackageReady(XposedModuleInterface.PackageReadyParam param) {
        ClassLoader cl = param.getClassLoader();
        mAppClassLoader = cl;
        log(INFO, TAG, "[pkg] onPackageReady, classLoader=" + (cl != null ? "non-null" : "NULL!"));
        installHooks(cl);
    }

    @Override
    public boolean onHotReloading(XposedModuleInterface.HotReloadingParam param) {
        return true;
    }

    @Override
    public void onHotReloaded(XposedModuleInterface.HotReloadedParam param) {
        // 宿主 app classloader（onPackageReady 时保存；热重载进程未重启，它仍有效）
        // ⚠️ 旧 handle 兜底取 classloader 必须跳过平台类（android.*/java.* 等由 boot/platform loader
        //    加载，如 Resources；其 getClassLoader() 在 ART 上非 null → 误当宿主 cl → 宿主类全
        //    ClassNotFound = 1 OK/7 FAIL）。2026-09-05 实锤：ColorOS/ART 的 Resources loader 非 null，
        //    只判 null 挡不住（v71 修法失效），须按类名前缀硬判。宿主类（me.rerere.*/androidx.* 打进 APK）
        //    的 loader 才是宿主 cl，可兜底。
        ClassLoader cl = mAppClassLoader;
        if (param.getOldHookHandles() != null) {
            for (XposedInterface.HookHandle h : param.getOldHookHandles()) {
                try {
                    if (cl == null && !isPlatformClass(h.getExecutable().getDeclaringClass().getName())) {
                        ClassLoader dcl = h.getExecutable().getDeclaringClass().getClassLoader();
                        if (dcl != null) cl = dcl;
                    }
                } catch (Throwable ignored) {}
                try { h.unhook(); } catch (Throwable ignored) {}
            }
        }
        if (cl == null) return;
        installHooks(cl);
        restoreModuleState();
        log(INFO, TAG, "hot reloaded, hooks reinstalled");
    }

    // ===== installHooks =====

    // 平台/框架类（boot/platform loader 加载，如 android.*/java.*/com.android.*）→ 不是宿主类。
    // androidx.* 不打进系统、随宿主 APK 分发（loader=宿主），故不在此列。
    private static boolean isPlatformClass(String className) {
        return className.startsWith("android.") || className.startsWith("java.")
            || className.startsWith("javax.") || className.startsWith("sun.")
            || className.startsWith("dalvik.") || className.startsWith("jdk.")
            || className.startsWith("com.android.");
    }

    private void installHooks(ClassLoader cl) {
        sHookDetail = new StringBuilder();
        sHookOk = sHookFail = 0;

        // ① ASR 声音：SoundEffectPlayer#play$default(SoundEffectPlayer, int)
        hookMethodObjIntExact(cl,
            "me.rerere.rikkahub.utils.SoundEffectPlayer",
            "play$default",
            "me.rerere.rikkahub.utils.SoundEffectPlayer",
            new AsrSoundHooker());

        // ② 振动增强：PlatformHapticFeedback#performHapticFeedback-CdsT49E(int)
        hookMethodInt(cl,
            "androidx.compose.ui.hapticfeedback.PlatformHapticFeedback",
            "performHapticFeedback-CdsT49E",
            new HapticVibrateHooker());

        // ③ 压缩开始：ChatService#compressConversation-hUnOzRk
        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "compressConversation-hUnOzRk", new CompressFeedbackHooker(1));

        // ④ 压缩失败：ChatService#addError
        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "addError", new CompressFeedbackHooker(2));

        // ⑤ 压缩成功：ChatService#saveConversation
        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "saveConversation", new CompressFeedbackHooker(3));

        // ⑥ 滚动导航按钮：ChatListKt#MessageJumper（Kelivo 式显隐：位移门槛+模式）
        hookMethodByName(cl, "me.rerere.rikkahub.ui.pages.chat.ChatListKt",
            "MessageJumper", new NavButtonsHooker());

        // ⑦ 缓存 RikkaHub「消息导航按钮」开关真值（NavButtonsHooker 常驻模式尊重总开关用）
        hookMethodByName(cl, "me.rerere.rikkahub.data.datastore.DisplaySetting",
            "getShowMessageJumper", new ShowMessageJumperHooker());

        // ⑧ 盘古之白：Resources#getString(int)
        //    （宿主类 hook 全在前、框架类兜底放最后：热重载时 oldHandles[0] 是宿主类，
        //      框架类 Resources 的 declaringClass loader 是平台 loader，会污染宿主 cl 推断 → 2026-09-05）
        hookMethodInt(cl, "android.content.res.Resources", "getString", new PanguHooker());

        log(INFO, TAG, "installHooks done: " + sHookOk + " OK / " + sHookFail + " FAIL / \n" + sHookDetail);
        sHookOk = sHookFail = 0;
        sHookDetail.setLength(0);
    }

    // ===== hook 辅助方法 =====

    /** hook 方法：getDeclaredMethod(clsName, methodName, Object.class) → this.hook(executable).intercept(hooker) */
    private void hookMethod(ClassLoader cl, String clsName, String methodName, XposedInterface.Hooker hooker) {
        try {
            Class<?> cls = cl.loadClass(clsName);
            Method m = cls.getDeclaredMethod(methodName, Object.class);
            hook(m).intercept(hooker);
            sHookOk++;
            sHookDetail.append("[OK] ").append(clsName).append("#").append(methodName).append("\n");
        } catch (Throwable e) {
            sHookFail++;
            sHookDetail.append("[FAIL] ").append(clsName).append("#").append(methodName)
                .append(": ").append(e.getMessage()).append("\n");
        }
    }

    /** hook 方法：getDeclaredMethod(clsName, methodName, Object.class, int.class) */
    private void hookMethodObjInt(ClassLoader cl, String clsName, String methodName, XposedInterface.Hooker hooker) {
        try {
            Class<?> cls = cl.loadClass(clsName);
            Method m = cls.getDeclaredMethod(methodName, Object.class, int.class);
            hook(m).intercept(hooker);
            sHookOk++;
            sHookDetail.append("[OK] ").append(clsName).append("#").append(methodName).append("\n");
        } catch (Throwable e) {
            sHookFail++;
            sHookDetail.append("[FAIL] ").append(clsName).append("#").append(methodName)
                .append(": ").append(e.getMessage()).append("\n");
        }
    }

    /** hook 方法：getDeclaredMethod(clsName, methodName, int.class) */
    private void hookMethodInt(ClassLoader cl, String clsName, String methodName, XposedInterface.Hooker hooker) {
        try {
            Class<?> cls = cl.loadClass(clsName);
            Method m = cls.getDeclaredMethod(methodName, int.class);
            hook(m).intercept(hooker);
            sHookOk++;
            sHookDetail.append("[OK] ").append(clsName).append("#").append(methodName).append("\n");
        } catch (Throwable e) {
            sHookFail++;
            sHookDetail.append("[FAIL] ").append(clsName).append("#").append(methodName)
                .append(": ").append(e.getMessage()).append("\n");
        }
    }

    /**
     * hook 方法：精确匹配第一参类型（argClsName 加载的具体类型），getDeclaredMethod(clsName, methodName, argCls, int.class)
     * 用于 SoundEffectPlayer.play$default 第一参是具体类型（非 Object）的场景。
     */
    private void hookMethodObjIntExact(ClassLoader cl, String clsName, String methodName,
                                        String argClsName, XposedInterface.Hooker hooker) {
        try {
            Class<?> cls = cl.loadClass(clsName);
            Class<?> argCls = cl.loadClass(argClsName);
            Method m = cls.getDeclaredMethod(methodName, argCls, int.class);
            hook(m).intercept(hooker);
            sHookOk++;
            sHookDetail.append("[OK] ").append(clsName).append("#").append(methodName).append("\n");
        } catch (Throwable e) {
            sHookFail++;
            sHookDetail.append("[FAIL] ").append(clsName).append("#").append(methodName)
                .append(": ").append(e.getMessage()).append("\n");
        }
    }

    /**
     * hook 方法：按方法名匹配（遍历 cls.getDeclaredMethods 找 name 相同的，取第一个）。
     * 用于 suspend 函数（方法名含 mangled 后缀）或参数不确定的场景。
     */
    private void hookMethodByName(ClassLoader cl, String clsName, String methodName, XposedInterface.Hooker hooker) {
        try {
            Class<?> cls = cl.loadClass(clsName);
            Method target = null;
            for (Method m : cls.getDeclaredMethods()) {
                if (m.getName().equals(methodName)) {
                    target = m;
                    break;
                }
            }
            if (target == null) throw new NoSuchMethodException(clsName + "#" + methodName);
            hook(target).intercept(hooker);
            sHookOk++;
            sHookDetail.append("[OK] ").append(clsName).append("#").append(methodName).append("\n");
        } catch (Throwable e) {
            sHookFail++;
            sHookDetail.append("[FAIL] ").append(clsName).append("#").append(methodName)
                .append(": ").append(e.getMessage()).append("\n");
        }
    }

    // ===== HookLogger 实现 =====

    @Override
    public void logD(String tag, String msg) {
        log(DEBUG, tag, msg);
    }

    @Override
    public void logD(String tag, String msg, Throwable tr) {
        log(DEBUG, tag, msg, tr);
    }

    // ===== restoreModuleState =====

    private void restoreModuleState() {
        Debug.sLogger = this;
        sCompressInProgress = false;
        SharedPreferences remotePrefs = getRemotePreferences(Prefs.PREFS_GROUP);
        Prefs.init(remotePrefs);
        // #ifdef DEBUG
        if (BuildConfig.DEBUG) {
            remotePrefs.registerOnSharedPreferenceChangeListener((prefs, key) -> {
                boolean val = prefs.getBoolean(key, false);
                log(INFO, TAG, "[switch] " + key + " = " + val);
            });
        }
        // #endif
    }

    // ===== notifyCompressResult =====

    public static void notifyCompressResult(Context ctx, boolean success) {
        if (ctx == null) return;
        // Toast
        Toast.makeText(ctx, success ? "压缩成功" : "压缩失败", Toast.LENGTH_SHORT).show();
        // 振动（尽力而为，无 VIBRATE 权限静默跳过）
        try {
            Vibrator vib = (Vibrator) ctx.getSystemService("vibrator");
            if (vib != null) {
                long ms = success ? 80 : 120;
                int amp = success ? 150 : 200;
                vib.vibrate(VibrationEffect.createOneShot(ms, amp));
            }
        } catch (Throwable ignored) {}
        // 通知（尽力而为）
        try {
            NotificationManager nm = (NotificationManager) ctx.getSystemService("notification");
            if (nm != null) {
                String channelId = "rikka_compress";
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    nm.createNotificationChannel(
                        new NotificationChannel(channelId, "压缩反馈", NotificationManager.IMPORTANCE_DEFAULT));
                }
                int icon = success ? android.R.drawable.stat_notify_chat : android.R.drawable.stat_notify_error;
                nm.notify(0x7f12,
                    new android.app.Notification.Builder(ctx, channelId)
                        .setSmallIcon(icon)
                        .setContentTitle(success ? "对话历史压缩成功" : "对话历史压缩失败")
                        .setAutoCancel(true)
                        .build());
            }
        } catch (Throwable ignored) {}
    }

    // ===== 4 个 Hooker 内部类 =====

    /** ① 盘古之白 hooker */
    static class PanguHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object raw = chain.proceed();
            if (raw == null) return null;
            if (!Prefs.isPanguEnabled()) return raw;
            if (!(raw instanceof String)) return raw;
            String orig = (String) raw;
            String result = Pangu.pangu(orig);
            if (!result.equals(orig)) Debug.d(TAG, "PANGU: [" + orig + "] -> [" + result + "]");
            return result;
        }
    }

    /** ② ASR 声音 hooker */
    static class AsrSoundHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object arg1 = chain.getArg(1);
            if (!Prefs.isAsrSoundMuted()) return chain.proceed();
            if (!(arg1 instanceof Integer)) return chain.proceed();
            int rid = ((Integer) arg1).intValue();
            if (rid == 0x7f120000 || rid == 0x7f120001) return null; // asr_start/stop 吞掉
            return chain.proceed();
        }
    }

    /** ③ 振动增强 hooker */
    static class HapticVibrateHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object arg0 = chain.getArg(0);
            if (!Prefs.isHapticBoost()) return chain.proceed();
            if (!(arg0 instanceof Integer)) return chain.proceed();
            int htype = ((Integer) arg0).intValue();
            if (htype == 0x17 || htype == 0xd) {
                return chain.proceed(new Object[]{ Integer.valueOf(0x3) }); // 换强振
            }
            return chain.proceed();
        }
    }

    /** ④⑤⑥ 压缩反馈 hooker（三用途，kind 由构造传入） */
    static class CompressFeedbackHooker implements XposedInterface.Hooker {
        private final int kind; // 1=开始 2=失败(addError) 3=成功(saveConversation)
        CompressFeedbackHooker(int kind) { this.kind = kind; }

        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            if (!Prefs.isCompressFeedback()) return chain.proceed();

            switch (kind) {
                case 1: // compressConversation 入口
                    Debug.d(TAG, "compress start, flag=true");
                    sCompressInProgress = true;
                    break;

                case 2: // addError
                    if (sCompressInProgress) {
                        Debug.d(TAG, "compress FAILED, notify");
                        Context ctx = getContextFromThis(chain);
                        notifyCompressResult(ctx, false);
                        sCompressInProgress = false;
                    }
                    break;

                case 3: // saveConversation
                    if (sCompressInProgress) {
                        // 区分：发送消息也会 saveConversation，只有栈里有 compressConversation 才是压缩收尾
                        StackTraceElement[] stack = Thread.currentThread().getStackTrace();
                        boolean fromCompress = false;
                        for (StackTraceElement ste : stack) {
                            if (ste.getMethodName().contains("compressConversation")) {
                                fromCompress = true;
                                break;
                            }
                        }
                        if (fromCompress) {
                            Debug.d(TAG, "compress SUCCESS, notify");
                            Context ctx = getContextFromThis(chain);
                            notifyCompressResult(ctx, true);
                            sCompressInProgress = false;
                        }
                    }
                    break;
            }
            return chain.proceed();
        }

        /** 从 hook 的 this（ChatService 实例）反射读 context 字段（Application） */
        private static Context getContextFromThis(XposedInterface.Chain chain) {
            try {
                Object thiz = chain.getThisObject();
                if (thiz == null) return null;
                Field f = thiz.getClass().getDeclaredField("context");
                f.setAccessible(true);
                Object val = f.get(thiz);
                return val instanceof Context ? (Context) val : null;
            } catch (Throwable e) {
                return null;
            }
        }
    }

    /**
     * ⑦ 滚动导航按钮控制 hooker（Kelivo 式显隐：位移门槛抑制轻滑 + 显示窗口内保持）。
     * <p>
     * hook 点: ChatListKt#MessageJumper(ZZ,CoroutineScope,LazyListState,GapComposer,I)，
     * 参数 arg0 = show（显示链最末端收口）。原生行为：任何滚动停止后显示约 1.5s（isRecentScroll delay）。
     * RikkaHub 自身「消息导航按钮」设置 = 总开关（原生 show=false 一律放行，尊重开关）。
     * <p>
     * 模式: 0=智能(默认) / 1=常驻(尊重 RikkaHub 总开关, 真值由 ShowMessageJumperHooker 缓存) / 2=原版零干预。
     * 智能 = 位移门槛（近似 Kelivo"真实用户滚动"过滤）：距上次放行超过显示窗口后，
     * 滚动位移不足门槛（轻滑/惯性尾段）→ 抑制不显示；连续滚动（窗口内）→ 保持显示不闪断。
     * 抑制不更新"放行窗口"，保证连续轻滑持续被抑制；基准在放行/抑制时都更新，防位移累计误判。
     * ⚠️ 不做贴底/贴顶整组抑制：RikkaHub 4 键一体，滚到底时"回顶/上一条"仍需要；
     *    Kelivo 的 near-bottom 抑制的是其独立"回底"钮（showJumpToBottom 单独控制），结构不同无法照搬。
     */
    static class NavButtonsHooker implements XposedInterface.Hooker {

        /** 滚动显示阈值范围（无级，用户滑块 1..20 条） */
        private static final int THRESHOLD_MIN = 1;
        private static final int THRESHOLD_MAX = 20;

        /** 连续会话窗口 ms：距上次放行 ≤ 此值视为连续翻页，位移不足也放行（避免闪断） */
        private static final long WINDOW_MS = 1500;

        // ---- 反射（宿主 LazyListState，懒加载缓存）----
        private static Method sMFirstIndex;
        private static Method sMFirstOffset;

        // ---- 状态（UI 主线程串行访问）----
        /** RikkaHub「消息导航按钮」开关真值缓存（由 ShowMessageJumperHooker 每次 getter 读取时更新；null=未知） */
        static volatile Boolean sShowMessageJumper;
        /** 最近一次处理的 LazyListState 实例（弱引用防泄漏）：换会话/页面 → 重置基准防串扰 */
        private static WeakReference<Object> sLastState;
        /** 上次【放行显示】时刻：仅放行更新（抑制不更新），是"连续滚动保持显示"窗口的依据 */
        private static long sLastShowMs;
        /** 位移基准（放行与抑制都更新：抑制后从新位置起算，防连续轻滑累计位移误判） */
        private static int sBaseIndex = Integer.MIN_VALUE;
        private static int sBaseOffset;

        // ---- 配置节流（MessageJumper 重组频繁，避免高频跨进程读 prefs）----
        private static long sCfgAt;
        private static int sCfgMode = -1;   // -1 强制首帧打 cfg
        private static int sCfgThresh;

        // ---- 观测（一次性/状态翻转驱动日志，防每帧重组刷屏）----
        private static boolean sParamLogged; // 参数布局自检是否已打
        private static int sLastResult = -1; // 上次判定结果

        // 判定结果码
        private static final int R_HIDE = 0;     // 隐藏放行（原生 show=false，含 RikkaHub 总开关关）
        private static final int R_SHOW = 1;     // 显示放行（通过判定 / 窗口内保持 / 首帧建档）
        private static final int R_SUPPRESS = 2; // 抑制轻滑（不足位移门槛）
        private static final int R_ERR = 3;      // 异常兜底
        private static final int R_ALWAYS = 4;   // 常驻模式显示

        private static String resultName(int r) {
            switch (r) {
                case R_HIDE: return "隐藏放行";
                case R_SHOW: return "显示放行";
                case R_SUPPRESS: return "抑制轻滑";
                case R_ERR: return "异常兜底";
                case R_ALWAYS: return "常驻显示";
                default: return "?";
            }
        }

        /** 结果翻转才打日志（同一结果持续帧不刷屏） */
        private static void logResult(int result, String detail) {
            if (result == sLastResult) return;
            sLastResult = result;
            Debug.d(TAG, "NavBtn -> " + resultName(result) + (detail == null ? "" : " " + detail));
        }

        /** 参数布局自检（一次性）：确认 hook 点 arg0=show / arg3=LazyListState 假设 */
        private static void logParamsOnce(XposedInterface.Chain chain) {
            if (sParamLogged) return;
            sParamLogged = true;
            try {
                StringBuilder sb = new StringBuilder("NavBtn ARGS n=").append(chain.getArgs().size());
                for (int i = 0; i < chain.getArgs().size(); i++) {
                    Object a = chain.getArgs().get(i);
                    sb.append(" [").append(i).append("]=")
                      .append(a == null ? "null" : a.getClass().getSimpleName());
                }
                Debug.d(TAG, sb.toString());
            } catch (Throwable ignored) {}
        }

        private static void refreshCfg() {
            long now = System.currentTimeMillis();
            if (now - sCfgAt > 300) {
                int mode = Prefs.navMode();
                int thresh = Prefs.navSensitivity();
                if (mode != sCfgMode || thresh != sCfgThresh) {
                    Debug.d(TAG, "NavBtn cfg: mode=" + mode + " thresh=" + thresh + "条");
                }
                sCfgMode = mode;
                sCfgThresh = thresh;
                sCfgAt = now;
            }
        }

        private static synchronized void ensureMethods(Class<?> cls) throws Throwable {
            if (sMFirstIndex != null && sMFirstIndex.getDeclaringClass() == cls) return;
            sMFirstIndex = cls.getMethod("getFirstVisibleItemIndex");
            sMFirstOffset = cls.getMethod("getFirstVisibleItemScrollOffset");
            sMFirstIndex.setAccessible(true);
            sMFirstOffset.setAccessible(true);
        }

        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            logParamsOnce(chain);
            refreshCfg();
            int mode = sCfgMode;
            if (mode == 2) return chain.proceed();              // 原版：零干预（RikkaHub 自身逻辑）

            boolean show = chain.getArg(0) instanceof Boolean && (Boolean) chain.getArg(0);

            if (mode == 1) {                                     // 常驻（尊重 RikkaHub 总开关）
                // 开关明确关 → 放行隐藏（原生 show=false 已含开关）；开/未知 → 常驻强制显示
                if (Boolean.FALSE.equals(sShowMessageJumper)) {
                    logResult(R_HIDE, "常驻但 RikkaHub 开关已关");
                    return chain.proceed();
                }
                logResult(R_ALWAYS, null);
                return chain.proceed(withShow(chain, true));
            }
            // mode == 0 智能（滚动降灵敏，默认）
            if (!show) {                                         // 原生隐藏（含 RikkaHub 总开关关）→ 放行
                logResult(R_HIDE, null);
                return chain.proceed();
            }

            Object state = chain.getArg(3);
            if (state == null) {                                 // 保险
                logResult(R_ERR, "state=null");
                return chain.proceed();
            }
            try {
                ensureMethods(state.getClass());

                // 换会话/页面（state 实例变化）→ 重置基准与窗口，防跨会话串扰
                Object prev = sLastState == null ? null : sLastState.get();
                if (prev != state) {
                    sLastState = new WeakReference<Object>(state);
                    sBaseIndex = Integer.MIN_VALUE;
                    sBaseOffset = 0;
                    sLastShowMs = 0;
                }

                int idx = ((Integer) sMFirstIndex.invoke(state)).intValue();
                int off = ((Integer) sMFirstOffset.invoke(state)).intValue();
                long now = System.currentTimeMillis();
                int thresh = Math.max(THRESHOLD_MIN, Math.min(THRESHOLD_MAX, sCfgThresh));

                // 显示窗口内（距上次放行 ≤ WINDOW_MS）：连续滚动 → 保持显示，不闪断
                if (sLastShowMs != 0 && (now - sLastShowMs) <= WINDOW_MS) {
                    sBaseIndex = idx; sBaseOffset = off;
                    logResult(R_SHOW, "窗口内保持 idx=" + idx);
                    return chain.proceed(withShow(chain, true));
                }

                if (sBaseIndex == Integer.MIN_VALUE) {           // 首帧无基准：放行建档
                    sBaseIndex = idx; sBaseOffset = off; sLastShowMs = now;
                    logResult(R_SHOW, "首帧建档 idx=" + idx);
                    return chain.proceed(withShow(chain, true));
                }

                // 窗口外：位移门槛判定（不足门槛 = 轻滑/惯性尾段 → 抑制）
                // 阈值 = 滑过 ≥N 条（无级用户设）；同条内大滑动(≥N*160px)也视为跨 N 条
                int idxDelta = Math.abs(idx - sBaseIndex);
                int offDelta = Math.abs(off - sBaseOffset);
                boolean distOk = idxDelta >= thresh
                    || (idxDelta == 0 && offDelta >= thresh * 160);
                if (!distOk) {
                    sBaseIndex = idx; sBaseOffset = off;         // 抑制也更新基准：防连续轻滑累计
                    logResult(R_SUPPRESS, "idxΔ=" + idxDelta
                        + " offΔ=" + offDelta + " thr=≥" + thresh + "条");
                    return chain.proceed(withShow(chain, false));
                }
                sBaseIndex = idx; sBaseOffset = off; sLastShowMs = now;
                logResult(R_SHOW, "门槛通过 idx=" + idx + " idxΔ=" + idxDelta);
                return chain.proceed(withShow(chain, true));
            } catch (Throwable e) {
                logResult(R_ERR, String.valueOf(e));
                return chain.proceed();                          // 异常兜底放行，不破坏 UI
            }
        }

        /** 仅替换 arg0(show)，其余原样 → 构造全量参数组 */
        private static Object[] withShow(XposedInterface.Chain chain, boolean show) {
            List<Object> args = new ArrayList<>(chain.getArgs());
            args.set(0, Boolean.valueOf(show));
            return args.toArray();
        }
    }

    /**
     * ⑧ RikkaHub「消息导航按钮」开关 getter 缓存 hooker。
     * <p>
     * hook 点: DisplaySetting#getShowMessageJumper()（返回 boolean，未混淆）。
     * ChatList 重组计算 show 时会先调用它（读 settings.displaySetting.showMessageJumper，
     * smali line 187），早于 MessageJumper 调用 → NavButtonsHooker 常驻模式可拿到开关真值：
     * 开关明确关 → 常驻也不显示（尊重 RikkaHub 总开关）。本 hooker 不改返回值，仅缓存。
     */
    static class ShowMessageJumperHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object r = chain.proceed();
            NavButtonsHooker.sShowMessageJumper =
                Boolean.valueOf(r instanceof Boolean && (Boolean) r);
            return r;
        }
    }
}
