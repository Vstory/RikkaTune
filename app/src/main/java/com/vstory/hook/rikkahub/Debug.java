package com.vstory.hook.rikkahub;

/**
 * D 级调试日志：双通道（框架日志 + logcat）。
 * <p>
 * UI 进程 sLogger=null → 只打 logcat（不触发 MainHook 加载）。
 * hook 进程 sLogger=MainHook → 双通道。
 */
public class Debug {

    /** true = debug 构建（实时日志等调试代码生效）；release 构建改 false */
    public static final boolean DEBUG = true;

    /** hook 进程由 MainHook 注入，UI 进程为 null */
    public static HookLogger sLogger;

    public static void d(String tag, String msg) {
        if (sLogger != null) sLogger.logD(tag, msg);
        android.util.Log.i(tag, msg);  // 改用 Log.i 避免被 Android 16 过滤
    }

    public static void d(String tag, String msg, Throwable tr) {
        if (sLogger != null) sLogger.logD(tag, msg, tr);
        android.util.Log.i(tag, msg);  // 改用 Log.i 避免被 Android 16 过滤
    }
}
