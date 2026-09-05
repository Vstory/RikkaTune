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







public class MainHook extends XposedModule implements HookLogger {

    public static final String TAG = "RikkaTune";

    private ClassLoader mAppClassLoader;


    public static boolean sCompressInProgress;

    private static int sHookOk;
    private static int sHookFail;
    private static StringBuilder sHookDetail;

    public MainHook() { super(); }



    @Override
    public void onModuleLoaded(XposedModuleInterface.ModuleLoadedParam param) {
        Debug.sLogger = this;
        log(INFO, TAG, "api102 module loaded");
        SharedPreferences remotePrefs = getRemotePreferences(Prefs.PREFS_GROUP);
        Prefs.init(remotePrefs);


        if (BuildConfig.DEBUG) {
            remotePrefs.registerOnSharedPreferenceChangeListener((prefs, key) -> {
                boolean val = prefs.getBoolean(key, false);
                log(INFO, TAG, "[switch] " + key + " = " + val);
            });
        }

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





    private static boolean isPlatformClass(String className) {
        return className.startsWith("android.") || className.startsWith("java.")
            || className.startsWith("javax.") || className.startsWith("sun.")
            || className.startsWith("dalvik.") || className.startsWith("jdk.")
            || className.startsWith("com.android.");
    }

    private void installHooks(ClassLoader cl) {
        sHookDetail = new StringBuilder();
        sHookOk = sHookFail = 0;


        hookMethodObjIntExact(cl,
            "me.rerere.rikkahub.utils.SoundEffectPlayer",
            "play$default",
            "me.rerere.rikkahub.utils.SoundEffectPlayer",
            new AsrSoundHooker());


        hookMethodInt(cl,
            "androidx.compose.ui.hapticfeedback.PlatformHapticFeedback",
            "performHapticFeedback-CdsT49E",
            new HapticVibrateHooker());


        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "compressConversation-hUnOzRk", new CompressFeedbackHooker(1));


        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "addError", new CompressFeedbackHooker(2));


        hookMethodByName(cl, "me.rerere.rikkahub.service.ChatService",
            "saveConversation", new CompressFeedbackHooker(3));


        hookMethodByName(cl, "me.rerere.rikkahub.ui.pages.chat.ChatListKt",
            "MessageJumper", new NavButtonsHooker());


        hookMethodByName(cl, "me.rerere.rikkahub.data.datastore.DisplaySetting",
            "getShowMessageJumper", new ShowMessageJumperHooker());




        hookMethodInt(cl, "android.content.res.Resources", "getString", new PanguHooker());

        log(INFO, TAG, "installHooks done: " + sHookOk + " OK / " + sHookFail + " FAIL / \n" + sHookDetail);
        sHookOk = sHookFail = 0;
        sHookDetail.setLength(0);
    }




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



    @Override
    public void logD(String tag, String msg) {
        log(DEBUG, tag, msg);
    }

    @Override
    public void logD(String tag, String msg, Throwable tr) {
        log(DEBUG, tag, msg, tr);
    }



    private void restoreModuleState() {
        Debug.sLogger = this;
        sCompressInProgress = false;
        SharedPreferences remotePrefs = getRemotePreferences(Prefs.PREFS_GROUP);
        Prefs.init(remotePrefs);

        if (BuildConfig.DEBUG) {
            remotePrefs.registerOnSharedPreferenceChangeListener((prefs, key) -> {
                boolean val = prefs.getBoolean(key, false);
                log(INFO, TAG, "[switch] " + key + " = " + val);
            });
        }

    }



    public static void notifyCompressResult(Context ctx, boolean success) {
        if (ctx == null) return;

        Toast.makeText(ctx, success ? "压缩成功" : "压缩失败", Toast.LENGTH_SHORT).show();

        try {
            Vibrator vib = (Vibrator) ctx.getSystemService("vibrator");
            if (vib != null) {
                long ms = success ? 80 : 120;
                int amp = success ? 150 : 200;
                vib.vibrate(VibrationEffect.createOneShot(ms, amp));
            }
        } catch (Throwable ignored) {}

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


    static class AsrSoundHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object arg1 = chain.getArg(1);
            if (!Prefs.isAsrSoundMuted()) return chain.proceed();
            if (!(arg1 instanceof Integer)) return chain.proceed();
            int rid = ((Integer) arg1).intValue();
            if (rid == 0x7f120000 || rid == 0x7f120001) return null;
            return chain.proceed();
        }
    }


    static class HapticVibrateHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object arg0 = chain.getArg(0);
            if (!Prefs.isHapticBoost()) return chain.proceed();
            if (!(arg0 instanceof Integer)) return chain.proceed();
            int htype = ((Integer) arg0).intValue();
            if (htype == 0x17 || htype == 0xd) {
                return chain.proceed(new Object[]{ Integer.valueOf(0x3) });
            }
            return chain.proceed();
        }
    }


    static class CompressFeedbackHooker implements XposedInterface.Hooker {
        private final int kind;
        CompressFeedbackHooker(int kind) { this.kind = kind; }

        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            if (!Prefs.isCompressFeedback()) return chain.proceed();

            switch (kind) {
                case 1:
                    Debug.d(TAG, "compress start, flag=true");
                    sCompressInProgress = true;
                    break;

                case 2:
                    if (sCompressInProgress) {
                        Debug.d(TAG, "compress FAILED, notify");
                        Context ctx = getContextFromThis(chain);
                        notifyCompressResult(ctx, false);
                        sCompressInProgress = false;
                    }
                    break;

                case 3:
                    if (sCompressInProgress) {

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















    static class NavButtonsHooker implements XposedInterface.Hooker {


        private static final int THRESHOLD_MIN = 1;
        private static final int THRESHOLD_MAX = 20;


        private static final long WINDOW_MS = 1500;


        private static Method sMFirstIndex;
        private static Method sMFirstOffset;



        static volatile Boolean sShowMessageJumper;

        private static WeakReference<Object> sLastState;

        private static long sLastShowMs;

        private static int sBaseIndex = Integer.MIN_VALUE;
        private static int sBaseOffset;


        private static long sCfgAt;
        private static int sCfgMode = -1;
        private static int sCfgThresh;


        private static boolean sParamLogged;
        private static int sLastResult = -1;


        private static final int R_HIDE = 0;
        private static final int R_SHOW = 1;
        private static final int R_SUPPRESS = 2;
        private static final int R_ERR = 3;
        private static final int R_ALWAYS = 4;

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


        private static void logResult(int result, String detail) {
            if (result == sLastResult) return;
            sLastResult = result;
            Debug.d(TAG, "NavBtn -> " + resultName(result) + (detail == null ? "" : " " + detail));
        }


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
            if (mode == 2) return chain.proceed();

            boolean show = chain.getArg(0) instanceof Boolean && (Boolean) chain.getArg(0);

            if (mode == 1) {

                if (Boolean.FALSE.equals(sShowMessageJumper)) {
                    logResult(R_HIDE, "常驻但 RikkaHub 开关已关");
                    return chain.proceed();
                }
                logResult(R_ALWAYS, null);
                return chain.proceed(withShow(chain, true));
            }

            if (!show) {
                logResult(R_HIDE, null);
                return chain.proceed();
            }

            Object state = chain.getArg(3);
            if (state == null) {
                logResult(R_ERR, "state=null");
                return chain.proceed();
            }
            try {
                ensureMethods(state.getClass());


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


                if (sLastShowMs != 0 && (now - sLastShowMs) <= WINDOW_MS) {
                    sBaseIndex = idx; sBaseOffset = off;
                    logResult(R_SHOW, "窗口内保持 idx=" + idx);
                    return chain.proceed(withShow(chain, true));
                }

                if (sBaseIndex == Integer.MIN_VALUE) {
                    sBaseIndex = idx; sBaseOffset = off; sLastShowMs = now;
                    logResult(R_SHOW, "首帧建档 idx=" + idx);
                    return chain.proceed(withShow(chain, true));
                }



                int idxDelta = Math.abs(idx - sBaseIndex);
                int offDelta = Math.abs(off - sBaseOffset);
                boolean distOk = idxDelta >= thresh
                    || (idxDelta == 0 && offDelta >= thresh * 160);
                if (!distOk) {
                    sBaseIndex = idx; sBaseOffset = off;
                    logResult(R_SUPPRESS, "idxΔ=" + idxDelta
                        + " offΔ=" + offDelta + " thr=≥" + thresh + "条");
                    return chain.proceed(withShow(chain, false));
                }
                sBaseIndex = idx; sBaseOffset = off; sLastShowMs = now;
                logResult(R_SHOW, "门槛通过 idx=" + idx + " idxΔ=" + idxDelta);
                return chain.proceed(withShow(chain, true));
            } catch (Throwable e) {
                logResult(R_ERR, String.valueOf(e));
                return chain.proceed();
            }
        }


        private static Object[] withShow(XposedInterface.Chain chain, boolean show) {
            List<Object> args = new ArrayList<>(chain.getArgs());
            args.set(0, Boolean.valueOf(show));
            return args.toArray();
        }
    }









    static class ShowMessageJumperHooker implements XposedInterface.Hooker {
        @Override public Object intercept(XposedInterface.Chain chain) throws Throwable {
            Object r = chain.proceed();
            NavButtonsHooker.sShowMessageJumper =
                Boolean.valueOf(r instanceof Boolean && (Boolean) r);
            return r;
        }
    }
}
