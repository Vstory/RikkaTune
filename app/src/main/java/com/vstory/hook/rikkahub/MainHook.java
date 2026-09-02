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

import java.lang.reflect.Field;
import java.lang.reflect.Method;

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
        if (Debug.DEBUG) {
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
        // unhook 旧 handle
        ClassLoader cl = null;
        if (param.getOldHookHandles() != null) {
            for (XposedInterface.HookHandle h : param.getOldHookHandles()) {
                try {
                    if (cl == null) cl = h.getExecutable().getDeclaringClass().getClassLoader();
                } catch (Throwable ignored) {}
                try { h.unhook(); } catch (Throwable ignored) {}
            }
        }
        if (cl == null) cl = mAppClassLoader;
        if (cl == null) return;
        installHooks(cl);
        restoreModuleState();
        log(INFO, TAG, "hot reloaded, hooks reinstalled");
    }

    // ===== installHooks =====

    private void installHooks(ClassLoader cl) {
        sHookDetail = new StringBuilder();
        sHookOk = sHookFail = 0;

        // ① 盘古之白：Resources#getString(int)
        hookMethodInt(cl, "android.content.res.Resources", "getString", new PanguHooker());

        // ② ASR 声音：SoundEffectPlayer#play$default(SoundEffectPlayer, int)
        hookMethodObjIntExact(cl,
            "me.rerere.rikkahub.utils.SoundEffectPlayer",
            "play$default",
            "me.rerere.rikkahub.utils.SoundEffectPlayer",
            new AsrSoundHooker());

        // ③ 振动增强：PlatformHapticFeedback#performHapticFeedback-CdsT49E(int)
        hookMethodInt(cl,
            "androidx.compose.ui.hapticfeedback.PlatformHapticFeedback",
            "performHapticFeedback-CdsT49E",
            new HapticVibrateHooker());

        // ④ 压缩开始：ChatService#compressConversation-hUnOzRk
        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "compressConversation-hUnOzRk", new CompressFeedbackHooker(1));

        // ⑤ 压缩失败：ChatService#addError
        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "addError", new CompressFeedbackHooker(2));

        // ⑥ 压缩成功：ChatService#saveConversation
        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "saveConversation", new CompressFeedbackHooker(3));

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
        if (Debug.DEBUG) {
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
}
