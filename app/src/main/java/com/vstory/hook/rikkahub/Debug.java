package com.vstory.hook.rikkahub;

/**
 * D 级调试日志：双通道（框架日志 + logcat）。
 * <p>
 * UI 进程 sLogger=null → 只打 logcat（不触发 MainHook 加载）。
 * hook 进程 sLogger=MainHook → 双通道。
 */
public class Debug {

    /** hook 进程由 MainHook 注入，UI 进程为 null */
    public static HookLogger sLogger;

    // #ifdef DEBUG
    // D 级调试日志门控: release 下 BuildConfig.DEBUG=false → javac 常量折叠,
    // 整个 if 块不生成字节码, d() 方法体为空 → 正式版零日志副作用。
    // (toggle_debug.sh 只管注释/恢复本块, 不影响调用点)
    // #endif
    public static void d(String tag, String msg) {
        if (BuildConfig.DEBUG) {
            if (sLogger != null) sLogger.logD(tag, msg);
            android.util.Log.i(tag, msg);  // 改用 Log.i 避免被 Android 16 过滤
        }
    }

    public static void d(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG) {
            if (sLogger != null) sLogger.logD(tag, msg, tr);
            android.util.Log.i(tag, msg);  // 改用 Log.i 避免被 Android 16 过滤
        }
    }
}
