#
# ============================================================
# Debug.smali — 独立调试日志文件（D/debug 级，双通道：框架日志 + app logcat）
# ============================================================
# 📌 用途: 统一封装"非正式版 D 级调试日志"，独立维护，便于正式版清理 + 恢复
#   调试版: 调用 Debug.d(...) 打 D 级日志（业务调试信息，如拦截值）
#   正式版: 【只注释业务代码里的调用点，本文件与方法永不删】
#           下次调新功能/新版本 → 取消注释调用点 → 恢复调试
# 📌 双通道: d() 内部【同时】走两个通道，两边都能看：
#   ① 框架日志  → MainHook.logD(tag,msg)（内部 this.log(3,tag,msg)），LSPosed 管理器可见
#   ② logcat    → android.util.Log.d(tag,msg)，adb logcat 可见
#   ⚠️ 框架 log() 是 MainHook 实例方法 → 需 MainHook.sDebug 指向当前实例
#       (onModuleLoaded 初始化, 热重载在 restoreModuleState 恢复)
# 📌 级别: android.util.Log.DEBUG = 3（D）
# ============================================================
.class public Lcom/vstory/hook/rikkahub/Debug;
.super Ljava/lang/Object;

# 调试日志: D 级（双通道: 框架 logD + logcat Log.d）
# param: String tag, String msg
.method public static d(Ljava/lang/String;Ljava/lang/String;)V
    .registers 3

    # ① 框架日志: 读 MainHook.sDebug, 非 null 则调它的 logD(tag,msg)
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    if-eqz v0, :logcat

    invoke-virtual {v0, p0, p1}, Lcom/vstory/hook/rikkahub/MainHook;->logD(Ljava/lang/String;Ljava/lang/String;)V

    :logcat
    # ② logcat: android.util.Log.d(tag, msg)
    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

# 调试日志: D 级 + 异常（双通道: 框架 logD + logcat Log.d）
# param: String tag, String msg, Throwable tr
.method public static d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5

    # ① 框架日志: 读 MainHook.sDebug, 非 null 则调它的 logD(tag,msg,tr)
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    if-eqz v0, :logcat

    invoke-virtual {v0, p0, p1, p2}, Lcom/vstory/hook/rikkahub/MainHook;->logD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :logcat
    # ② logcat: android.util.Log.d(tag, msg, tr)
    invoke-static {p0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method
