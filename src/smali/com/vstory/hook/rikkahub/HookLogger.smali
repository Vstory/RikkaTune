#
# ============================================================
# HookLogger.smali — 框架日志桥接口（UI 进程安全的关键）
# ============================================================
# 📌 为什么存在 (2026-09-02 NoClassDefFoundError 修复):
#   - 旧 Debug.d 直接 sget MainHook.sDebug -> UI 进程(控制面板, 模块自身进程)强制加载
#     MainHook -> MainHook extends XposedModule(api.jar) UI 进程没有 -> 崩溃
#   - 本接口是纯 Java 接口(无任何 libxposed 依赖) -> UI 进程能正常加载
#   - Debug 静态持有 sLogger:HookLogger; MainHook 实现本接口并在 onModuleLoaded/
#     restoreModuleState 注入 this
#   - UI 进程: sLogger=null -> Debug.d 跳过框架通道, 只打 logcat (不触发 MainHook 加载)
#   - hook 进程: sLogger=MainHook -> 双通道(框架 logD + logcat) 全保留
# ============================================================
.class public abstract interface Lcom/vstory/hook/rikkahub/HookLogger;
.super Ljava/lang/Object;

# D 级框架日志 (内部调 this.log(3, tag, msg))
.method public abstract logD(Ljava/lang/String;Ljava/lang/String;)V
.end method

# D 级框架日志 + 异常 (内部调 this.log(3, tag, msg, tr))
.method public abstract logD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
.end method
