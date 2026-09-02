/**
 * 框架日志桥接口（UI 进程安全）。
 * <p>
 * UI 进程（模块自身）无 libxposed 运行时，无法直接调 MainHook（extends XposedModule）。
 * 本接口是纯 Java，UI 进程能加载；MainHook 实现它并在 onModuleLoaded/restoreModuleState
 * 通过 Debug.sLogger 注入 this → UI 进程 sLogger=null 跳过框架通道只打 logcat。
 */
public interface HookLogger {
    void logD(String tag, String msg);
    void logD(String tag, String msg, Throwable tr);
}
