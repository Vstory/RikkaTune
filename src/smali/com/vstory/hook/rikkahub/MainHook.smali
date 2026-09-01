#
# ============================================================
# libxposed API 102 模块入口模板（通用）
# 来源: 懒饭模块(com.xiachufang.lazycook) 实战沉淀 + 钱迹模块带参 hook 经验
# 用法: 复制本文件到新项目, 全局替换 com/vstory/hook/rikkahub → 你的包名
# ============================================================
# 生命周期: onModuleLoaded → onPackageReady → installHooks
# 热重载:   onHotReloading 返回 true + onHotReloaded unhook旧handle
#           + installHooks 重装 + restoreModuleState 恢复 static
# 注意:
#   - 禁止调用传统 de.robv.android.xposed.* API
#   - Class.forName 的 initialize 必须 false（触发 <clinit> 会让 APP 崩溃!）
#   - 寄存器公式: .registers ≥ 局部最高寄存器号+1 + 参数个数(含this)
#   - Hooker.intercept() 返回值 = 被 hook 方法的最终返回值（无 setResult）
#   - ⚠️ §16 热重载坑: 热重载 = 新 ClassLoader 重载模块类 → 全部 static 复位!
#     有 static 状态的模块（广播幂等标志/数据类/RemotePreferences 等）
#     必须在 restoreModuleState() 里恢复, 否则出现数据分裂/配置开关失效
#
.class public Lcom/vstory/hook/rikkahub/MainHook;
.super Lio/github/libxposed/api/XposedModule;

# 保存被 hook 应用的 classLoader（热重载 fallback 用，主路径从旧 hook handle 取）
.field private mAppClassLoader:Ljava/lang/ClassLoader;

# ⚠️ 调试日志入口: 供 Debug.smali 拿当前 MainHook 实例来调框架 log()（D 级框架日志）
#   - onModuleLoaded 里初始化为 this; 热重载后 sDebug 复位为 null, 需在 restoreModuleState 恢复
#   - 静态引用: 让独立 Debug 类(无 MainHook 实例)也能调框架 log(); 不影响 logcat
.field private static sDebug:Lcom/vstory/hook/rikkahub/MainHook;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lio/github/libxposed/api/XposedModule;-><init>()V

    return-void
.end method

# 通用 hook 辅助（无参方法版）:
#   Class.forName(cls, false, cl) → getDeclaredMethod(m, new Class[0])
#   → hook(method).setExceptionMode(PROTECTIVE).intercept(hooker)
# 4 参数 + this = 5 个寄存器, invoke-direct 普通形式上限内
# 单个 hook 失败只跳过该 hook, 不影响其它 hook
.method private hookMethod(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 7

    :try_start
    # Class.forName(className, false, classLoader) — initialize 必须 false!
    const/4 v0, 0x0

    invoke-static {p2, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    # clazz.getDeclaredMethod(methodName, new Class[0])
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Class;

    invoke-virtual {v0, p3, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    # hook(method) -> HookBuilder (XposedInterfaceWrapper 方法, invoke-virtual)
    invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v0

    # builder.setExceptionMode(ExceptionMode.PROTECTIVE) -> HookBuilder (接口方法, invoke-interface)
    sget-object v1, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;

    invoke-interface {v0, v1}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v0

    # builder.intercept(hooker) -> HookHandle (接口方法, invoke-interface)
    invoke-interface {v0, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_ignore

    :catch_ignore
    return-void
.end method

# 通用 hook 辅助（(String,int) 双参方法版）: 有参方法必须传参数类型数组
# 例: getInt(String,int) / c(String,int) / putInt(String,int)
.method private hookMethodStrInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 9

    :try_start
    # Class.forName(className, false, classLoader)
    const/4 v0, 0x0

    invoke-static {p2, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    # clazz.getDeclaredMethod(methodName, new Class[]{String.class, int.class})
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Class;

    const-class v2, Ljava/lang/String;

    const/4 v3, 0x0

    aput-object v2, v1, v3

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v3, 0x1

    aput-object v2, v1, v3

    invoke-virtual {v0, p3, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    # hook(method) -> HookBuilder
    invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v0

    # builder.setExceptionMode(ExceptionMode.PROTECTIVE)
    sget-object v1, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;

    invoke-interface {v0, v1}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v0

    # builder.intercept(hooker)
    invoke-interface {v0, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_ignore

    :catch_ignore
    return-void
.end method

# 通用 hook 辅助（(int) 单参方法版）: 参数类型数组为 {int.class}
# 例: Resources.getString(int) / SomeClass.getTitle(int)
# 带诊断日志: 打印 Class.forName / getDeclaredMethod / hook 各步结果与异常
# ⚠️ try-catch 注意事项（踩坑）:
#   - handler(:catch_log) 必须以 move-exception 开头
#   - 成功路径(:try_end 前)必须 goto 跳过 handler, 否则正常流会掉进 move-exception → ART VerifyError!
.method private hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 15

    # v6 = 类名, v7 = 方法名 (供日志用)
    move-object v6, p2
    move-object v7, p3

    :try_start
    # Class.forName(className, false, classLoader)
    const/4 v0, 0x0

    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    # clazz.getDeclaredMethod(methodName, new Class[]{int.class})
    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v9, 0x0

    aput-object v8, v5, v9

    invoke-virtual {v4, v7, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    # hook(method) -> HookBuilder
    invoke-virtual {p0, v4}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v4

    # builder.setExceptionMode(ExceptionMode.PROTECTIVE)
    sget-object v5, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;

    invoke-interface {v4, v5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v4

    # builder.intercept(hooker)
    invoke-interface {v4, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;

    # log(INFO, TAG, "PANGU hook OK: cls#mth")
    const/4 v0, 0x4
    const-string v1, "RikkaTune"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "PANGU hook OK: "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v3, "#"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {p0, v0, v1, v2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    # 成功路径: 跳过异常处理块
    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log

    # 异常处理: 打印异常信息
    :catch_log
    move-exception v0
    # log(ERROR, TAG, "PANGU hook FAILED cls#mth : <异常>") — 错误用 E(6)
    const/4 v1, 0x6
    const-string v2, "RikkaTune"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "PANGU hook FAILED "
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v4, "#"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v4, " : "
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {p0, v1, v2, v3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    :end_hook
    return-void
.end method

# 安装全部 hooks（onPackageReady 与 onHotReloaded 共用）
# 📌 新项目修改点: 在这里添加你的 hook 目标（类名/方法名/Hooker）
.method private installHooks(Ljava/lang/ClassLoader;)V
    .registers 10

    # 盘古之白 Hooker: 处理 android.content.res.Resources#getString(int)
    # 作用: UI 中文文案里 中文↔英文/数字 交界处插入空格
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;

    invoke-direct {v1}, Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;-><init>()V

    # ==========================================
    # 核心 hook: android.content.res.Resources#getString(int)
    # 这是所有 UI 资源字符串（含 Compose stringResource）运行时必经入口
    # 覆盖: 读取JSON失败 → 读取 JSON 失败 / 添加Header → 添加 Header
    # ==========================================
    const-string v4, "android.content.res.Resources"

    const-string v5, "getString"

    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V

    return-void
.end method


# virtual methods
# D 级调试日志实例方法（框架日志）: 内部调 this.log(3, tag, msg)（android.util.Log.DEBUG=3）
# 供 Debug.smali 的静态 d() 通过 sDebug 调框架 log(); 调试版保留, 正式版可注释/保留(无害, 无输出)
.method public logD(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4

    # this.log(DEBUG=3, tag, msg)
    const/4 v0, 0x3

    invoke-virtual {p0, v0, p1, p2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

# D 级调试日志实例方法（框架日志）+ 异常: 内部调 this.log(3, tag, msg, tr)
.method public logD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 6

    # this.log(DEBUG=3, tag, msg, tr)
    const/4 v0, 0x3

    invoke-virtual {p0, v0, p1, p2, p3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public onModuleLoaded(Lio/github/libxposed/api/XposedModuleInterface$ModuleLoadedParam;)V
    .registers 5

    # ⚠️ 初始化静态引用 sDebug = this（供 Debug.smali 调框架 log()）; 热重载后需在 restoreModuleState 恢复
    sput-object p0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    # log(Log.INFO, "TAG", "api102 module loaded")
    const/4 v0, 0x4

    const-string v1, "RikkaTune"

    const-string v2, "api102 module loaded"

    invoke-virtual {p0, v0, v1, v2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onPackageReady(Lio/github/libxposed/api/XposedModuleInterface$PackageReadyParam;)V
    .registers 7

    # 获取目标包 classLoader 并保存（热重载 fallback 用）
    invoke-interface {p1}, Lio/github/libxposed/api/XposedModuleInterface$PackageReadyParam;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    iput-object v0, p0, Lcom/vstory/hook/rikkahub/MainHook;->mAppClassLoader:Ljava/lang/ClassLoader;

    # log(INFO, TAG, "[pkg] onPackageReady, cl=<classloader or null>")
    const/4 v1, 0x4
    const-string v2, "RikkaTune"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "[pkg] onPackageReady, classLoader="
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    if-eqz v0, :cl_null
    const-string v4, "non-null"
    goto :cl_log
    :cl_null
    const-string v4, "NULL!"
    :cl_log
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {p0, v1, v2, v3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    # 安装全部 hooks
    invoke-direct {p0, v0}, Lcom/vstory/hook/rikkahub/MainHook;->installHooks(Ljava/lang/ClassLoader;)V

    # log(Log.INFO, "RikkaTune", "installHooks done (check [hook] logs)")
    const/4 v1, 0x4

    const-string v2, "RikkaTune"

    const-string v3, "installHooks done (check [hook] logs)"

    invoke-virtual {p0, v1, v2, v3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

# 允许热重载（接口默认返回 false, 不覆写会拒绝热重载请求）
.method public onHotReloading(Lio/github/libxposed/api/XposedModuleInterface$HotReloadingParam;)Z
    .registers 3

    const/4 v0, 0x1

    return v0
.end method

# 热重载完成后: 从旧 hook handle 取 classLoader → unhook 全部旧 hooks → installHooks 重装
.method public onHotReloaded(Lio/github/libxposed/api/XposedModuleInterface$HotReloadedParam;)V
    .registers 8

    # 1. 从旧 hook handle 取 app classLoader（热重载不会重放 onPackageReady, 新实例字段为 null）
    const/4 v0, 0x0

    invoke-interface {p1}, Lio/github/libxposed/api/XposedModuleInterface$HotReloadedParam;->getOldHookHandles()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :try_handle

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/github/libxposed/api/XposedInterface$HookHandle;

    invoke-interface {v1}, Lio/github/libxposed/api/XposedInterface$HookHandle;->getExecutable()Ljava/lang/reflect/Executable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/reflect/Executable;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    :try_handle
    # 2. unhook 全部旧 hooks
    invoke-interface {p1}, Lio/github/libxposed/api/XposedModuleInterface$HotReloadedParam;->getOldHookHandles()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :loop_unhook
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :done_unhook

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/github/libxposed/api/XposedInterface$HookHandle;

    invoke-interface {v2}, Lio/github/libxposed/api/XposedInterface$HookHandle;->unhook()V

    goto :loop_unhook

    :done_unhook
    # 3. fallback: 用保存的 mAppClassLoader
    if-nez v0, :have_cl

    iget-object v0, p0, Lcom/vstory/hook/rikkahub/MainHook;->mAppClassLoader:Ljava/lang/ClassLoader;

    :have_cl
    # 4. 拿不到 classLoader 就不重装
    if-nez v0, :install

    return-void

    :install
    # 5. 重装 hooks
    invoke-direct {p0, v0}, Lcom/vstory/hook/rikkahub/MainHook;->installHooks(Ljava/lang/ClassLoader;)V

    # 6. 恢复热重载后复位的 static 状态（§16: 热重载 = 新 ClassLoader 重载 → static 全复位）
    #    纯 hook（无 static 状态）的模块可删除下面这行
    invoke-direct {p0}, Lcom/vstory/hook/rikkahub/MainHook;->restoreModuleState()V

    # log(Log.INFO, "RikkaTune", "hot reloaded, hooks reinstalled")
    const/4 v1, 0x4

    const-string v2, "RikkaTune"

    const-string v3, "hot reloaded, hooks reinstalled"

    invoke-virtual {p0, v1, v2, v3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

# 恢复热重载后复位的 static 状态（§16 通用坑: 热重载 = 新 ClassLoader 重载模块类 → static 全复位）
# 📌 新项目按需实现:
#   若模块有 static 状态（广播幂等标志/数据类 context/跨进程 RemotePreferences）:
#   - 恢复广播通道幂等标志（避免热重载后重复注册 receiver → 数据分裂 sent 0/sent N）
#   - 重新 init 数据类（context/folderPath/allData）
#   - 重新绑定 RemotePreferences（system_server 进程 uiContext=null → 配置读默认值, 开关失效）
#   纯 hook（返回 true/改参数, 无 static 状态）的模块可留空
.method private restoreModuleState()V
    .registers 1

    # ⚠️ 恢复静态引用 sDebug = this（热重载 = 新 ClassLoader 重载模块类 → static 全复位, sDebug 变 null）
    sput-object p0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    # 示例: 重新绑定跨进程配置 (XposedModule.getRemotePreferences)
    # const-string v0, "config"
    # invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedModule;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;
    # move-result-object v0
    # ... 再调用你自己的 ConfigData.init / 数据类 init / 广播标志恢复

    return-void
.end method
