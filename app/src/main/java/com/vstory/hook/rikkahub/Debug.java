/**
 * D 级调试日志：双通道（框架日志 + logcat）。
 * <p>
 * UI 进程 sLogger=null → 只打 logcat（不触发 MainHook 加载）。
 * hook 进程 sLogger=MainHook → 双通道。
 */
public class Debug {

    /** hook 进程由 MainHook 注入，UI 进程为 null */
    public static HookLogger sLogger;

    public static void d(String tag, String msg) {
        if (sLogger != null) sLogger.logD(tag, msg);
        android.util.Log.d(tag, msg);
    }

    public static void d(String tag, String msg, Throwable tr) {
        if (sLogger != null) sLogger.logD(tag, msg, tr);
        android.util.Log.d(tag, msg, tr);
    }
}
