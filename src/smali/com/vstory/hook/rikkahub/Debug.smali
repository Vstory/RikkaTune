#
# ============================================================
# Debug.smali — 独立调试日志文件（D/debug 级，双通道：框架日志 + app logcat）
# ============================================================
# 📌 用途: 统一封装"非正式版 D 级调试日志"，独立维护，便于正式版清理 + 恢复
#   调试版: 调用 Debug.d(...) 打 D 级日志（业务调试信息，如拦截值）
#   正式版: 【只注释业务代码里的调用点，本文件与方法永不删】
#           下次调新功能/新版本 → 取消注释调用点 → 恢复调试
# 📌 双通道: d() 内部【同时】走两个通道，两边都能看：
#   ① 框架日志  → 经 sLogger(HookLogger) 调 MainHook.logD → LSPosed 管理器可见
#   ② logcat    → android.util.Log.d(tag,msg)，adb logcat 可见
# ⚠️ UI 进程安全 (2026-09-02 重构, 修 NoClassDefFoundError):
#   - 旧实现直接 sget MainHook.sDebug → UI 进程(控制面板)加载 MainHook → 崩
#   - 现在只引用本类字段 sLogger + HookLogger 接口(纯 Java, UI 进程可加载)
#   - MainHook(实现 HookLogger) 在 onModuleLoaded/restoreModuleState 注入 this
#   - UI 进程 sLogger=null → 自动跳过框架通道只打 logcat，不触发 MainHook 类加载
# 📌 级别: android.util.Log.DEBUG = 3（D）
# ============================================================
.class public Lcom/vstory/hook/rikkahub/Debug;
.super Ljava/lang/Object;

# ⚠️ 框架日志器引用 (接口类型, 非 MainHook 类!): hook 进程由 MainHook 注入, UI 进程为 null
.field public static sLogger:Lcom/vstory/hook/rikkahub/HookLogger;

# 调试日志: D 级（双通道: 框架 logD + logcat Log.d）
# param: String tag, String msg
.method public static d(Ljava/lang/String;Ljava/lang/String;)V
    .registers 3

    # ① 框架日志: 读 Debug.sLogger, 非 null 则经接口调 MainHook.logD
    sget-object v0, Lcom/vstory/hook/rikkahub/Debug;->sLogger:Lcom/vstory/hook/rikkahub/HookLogger;

    if-eqz v0, :logcat

    invoke-interface {v0, p0, p1}, Lcom/vstory/hook/rikkahub/HookLogger;->logD(Ljava/lang/String;Ljava/lang/String;)V

    :logcat
    # ② logcat: android.util.Log.d(tag, msg)
    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

# 调试日志: D 级 + 异常（双通道: 框架 logD + logcat Log.d）
# param: String tag, String msg, Throwable tr
.method public static d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5

    # ① 框架日志: 读 Debug.sLogger, 非 null 则经接口调 MainHook.logD(带异常)
    sget-object v0, Lcom/vstory/hook/rikkahub/Debug;->sLogger:Lcom/vstory/hook/rikkahub/HookLogger;

    if-eqz v0, :logcat

    invoke-interface {v0, p0, p1, p2}, Lcom/vstory/hook/rikkahub/HookLogger;->logD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :logcat
    # ② logcat: android.util.Log.d(tag, msg, tr)
    invoke-static {p0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method
