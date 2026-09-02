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
#   - ⚠️ 必须 public: Debug 类要读它(跨类), private 会抛 IllegalAccessError
.field public static sDebug:Lcom/vstory/hook/rikkahub/MainHook;

# ⚠️ hook 注册计数器（聚合日志防刷屏, 2026-09-01）
#   - 每个 hook 成功/失败只更新计数, 不单独 log()（避免每 hook 一条刷屏）
#   - installHooks 末尾一次性 log 汇总: "installHooks done: N OK / M FAIL"
#   - 只在 hookMethodInt / hookMethodObjIntExact 里 ++, 由 installHooks 读取并清零
.field private static sHookOk:I

.field private static sHookFail:I

# hook 注册明细（可选, 存 "cls#mth" 便于汇总里看哪个挂了/哪个失败）; 用空格分隔
.field private static sHookDetail:Ljava/lang/StringBuilder;

# ⚠️ 压缩反馈标志: 压缩对话历史进行中 = true (CompressFeedbackHooker 用)
#   - compressConversation 入口置 true; addError(压缩失败)/saveConversation(压缩成功) 后清 false
#   - 热重载后 static 复位, 需在 restoreModuleState 恢复为 false
#   - ⚠️ 必须 public: CompressFeedbackHooker 跨类读写它, private 抛 IllegalAccessError!
.field public static sCompressInProgress:Z


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
# 例: Resources.getString(int) / PlatformHapticFeedback.performHapticFeedback-CdsT49E(int)
# 日志: 打印 "hook OK/FAILED: cls#mth"（中性, 用 cls#method 区分功能, 不硬编码功能名）
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

    # hook OK → sHookOk++ + 追加 "[OK] cls#mth " 到明细 (聚合一条, 不单独 log)
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const-string v1, "[OK] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    # 成功路径: 跳过异常处理块
    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log

    # 异常处理: sHookFail++ + 把 cls#mth 追加到明细 (聚合到 installHooks 末尾)
    :catch_log
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    # 追加 "[cls#mth] " 到 sHookDetail (失败时显示哪个方法没找到)
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :end_hook
    return-void
.end method

# 通用 hook 辅助（(Object,int) 双参方法版）: 参数类型数组为 {Object.class, int.class}
# 例: SoundEffectPlayer.play$default(SoundEffectPlayer, int) / Resources.getColor(int,Theme)
#   注意: 第一参是具体对象类型时, 用 Object.class 反射 getDeclaredMethod 可匹配(ART 对 void 接受父类)
#   但若要精确匹配子类声明的签名, 应传入其声明类; 这里 SoundEffectPlayer 的 play$default 第一参就是
#   SoundEffectPlayer 自身, 用 Object.class 反射有时不匹配(见下 hookMethodObjIntExact)。
#   本方法用于: 通过 Object.class 触发 getDeclaredMethod 时能匹配的 (Object,int) 签名场景。
# ⚠️ SoundEffectPlayer.play$default 第一参是 SoundEffectPlayer 具体类型, 需用 Exact 版本 hookMethodObjIntExact
.method private hookMethodObjInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 15

    move-object v6, p2
    move-object v7, p3

    :try_start
    const/4 v0, 0x0

    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    # getDeclaredMethod(methodName, new Class[]{Object.class, int.class})
    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const-class v8, Ljava/lang/Object;

    const/4 v9, 0x0

    aput-object v8, v5, v9

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v9, 0x1

    aput-object v8, v5, v9

    invoke-virtual {v4, v7, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-virtual {p0, v4}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v4

    sget-object v5, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;

    invoke-interface {v4, v5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v4

    invoke-interface {v4, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;

    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log

    :catch_log
    move-exception v0

    return-void

    :end_hook
    return-void
.end method

# 通用 hook 辅助（(Object,int) 精确匹配版）: 第一参用传入的具体参数类型类, 匹配具体签名
# 用于 SoundEffectPlayer.play$default(SoundEffectPlayer, int): 第一参就是 SoundEffectPlayer 具体类型
#   - clsName = 被 hook 的类全名(L...;)
#   - methodName = 方法名
#   - argClass0 = 第一个参数的具体类型类全名(如 Lme/rerere/rikkahub/utils/SoundEffectPlayer;)
#   通过 Class.forName(argClass0) 拿到参数类型, 使 getDeclaredMethod 精确匹配
# 日志: 打印 "hook OK/FAILED: cls#mth"（中性, 用 cls#method 区分功能）
# ⚠️ 成功路径 :try_end 前必须 goto :end_hook 跳过 handler, 否则掉进 move-exception → ART VerifyError!
.method private hookMethodObjIntExact(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 16

    # v6 = 类名, v7 = 方法名 (供日志用)
    move-object v6, p2
    move-object v7, p3

    :try_start
    const/4 v0, 0x0

    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    # getDeclaredMethod(methodName, new Class[]{argClass0, int.class})
    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    # 参数0: argClass0 (String 类名 → Class)
    const/4 v0, 0x0

    invoke-static {p4, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v8

    const/4 v9, 0x0

    aput-object v8, v5, v9

    # 参数1: int.class
    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v9, 0x1

    aput-object v8, v5, v9

    invoke-virtual {v4, v7, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-virtual {p0, v4}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v4

    sget-object v5, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;

    invoke-interface {v4, v5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v4

    invoke-interface {v4, p5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;

    # hook OK → sHookOk++ + 追加 "[OK] cls#mth " 到明细 (聚合一条, 不单独 log)
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const-string v1, "[OK] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log

    # 异常处理: sHookFail++ + 把 cls#mth 追加到明细 (聚合到 installHooks 末尾)
    :catch_log
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    # 追加 "[cls#mth] " 到 sHookDetail (失败时显示哪个方法没找到)
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :end_hook
    return-void
.end method

# 通用 hook 辅助（按方法名匹配版, 不传参数类型）:
#   适用: suspend 方法(带 Continuation 参数, 签名复杂) / mangled 名 / 不确定参数
#   做法: clazz.getDeclaredMethods() 遍历, 找 getName().equals(methodName) 的第一个 hook
#   单 hook 失败只跳过该 hook, 不影响其它 hook; 成功/失败计入 sHookOk/sHookFail 聚合
.method private hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 15

    # v6 = 类名, v7 = 方法名 (供日志用)
    move-object v6, p2
    move-object v7, p3

    :try_start
    # Class.forName(className, false, classLoader)
    const/4 v0, 0x0

    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    # Method[] ms = clazz.getDeclaredMethods()
    invoke-virtual {v4}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v5

    # for (Method m : ms)
    array-length v2, v5

    const/4 v3, 0x0

    :loop
    if-ge v3, v2, :not_found

    aget-object v8, v5, v3

    # if (m.getName().equals(methodName))
    invoke-virtual {v8}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :next

    # 匹配 → hook(m).setExceptionMode(PROTECTIVE).intercept(hooker)
    invoke-virtual {p0, v8}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v8

    sget-object v9, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;

    invoke-interface {v8, v9}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;

    move-result-object v8

    invoke-interface {v8, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;

    # hook OK → sHookOk++ + 追加 "[OK] cls#mth \n" 到明细
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const-string v1, "[OK] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :end_hook

    :next
    add-int/lit8 v3, v3, 0x1

    goto :loop

    :not_found
    # 未找到 → 走 catch 逻辑(sHookFail++ + 明细 [cls#mth])
    const/4 v0, 0x0

    throw v0
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log

    # 异常处理: sHookFail++ + 追加 "[cls#mth] \n" 到明细
    :catch_log
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :end_hook
    return-void
.end method
# 📌 新项目修改点: 在这里添加你的 hook 目标（类名/方法名/Hooker）
.method private installHooks(Ljava/lang/ClassLoader;)V
    .registers 12

    # ⚠️ 聚合日志: 初始化明细收集器 + 重置计数器(热重载防叠加), 供末尾汇总输出
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sput-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const/4 v0, 0x0

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    # ==========================================================
    # ① 盘古之白 Hooker: 处理 android.content.res.Resources#getString(int)
    # 作用: UI 中文文案里 中文↔英文/数字 交界处插入空格
    # ==========================================================
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;

    invoke-direct {v1}, Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;-><init>()V

    const-string v4, "android.content.res.Resources"

    const-string v5, "getString"

    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V

    # ==========================================================
    # ② ASR 声音 Hooker: hook SoundEffectPlayer#play$default(SoundEffectPlayer, int)
    # 作用: 去掉语音输入 开始/结束 的提示音 (asr_start=0x7f120000 / asr_stop=0x7f120001)
    # 第一参是 SoundEffectPlayer 具体类型, 用 Exact 版精确匹配签名
    # 寄存器布局: v0=this v1=cl v2=clsName v3=methodName v4=argClass0 v5=hooker
    # ==========================================================
    new-instance v5, Lcom/vstory/hook/rikkahub/MainHook$AsrSoundHooker;

    invoke-direct {v5}, Lcom/vstory/hook/rikkahub/MainHook$AsrSoundHooker;-><init>()V

    move-object v0, p0
    move-object v1, p1

    const-string v2, "me.rerere.rikkahub.utils.SoundEffectPlayer"

    const-string v3, "play$default"

    const-string v4, "me.rerere.rikkahub.utils.SoundEffectPlayer"

    invoke-direct/range {v0 .. v5}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodObjIntExact(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V

    # ==========================================================
    # ③ 振动增强 Hooker: hook PlatformHapticFeedback#performHapticFeedback-CdsT49E(int)
    # 作用: 把语音输入 开始(0x17)/结束(0xd) 的弱振动替换成 0x3(Confirm, 跟消息生成触觉反馈一致)
    # 注意: 方法名含 "-CdsT49E"(Compose 内联类 mangled 名), 反射 getDeclaredMethod 按 Dex 名可用;
    #       若反射失败只跳过强度增强, 不影响 ② 去声音
    # ==========================================================
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$HapticVibrateHooker;

    invoke-direct {v1}, Lcom/vstory/hook/rikkahub/MainHook$HapticVibrateHooker;-><init>()V

    const-string v4, "androidx.compose.ui.hapticfeedback.PlatformHapticFeedback"

    const-string v5, "performHapticFeedback-CdsT49E"

    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V

    # ============================================================
    # ④ 压缩开始 Hooker: hook ChatService.compressConversation-hUnOzRk 入口
    # 作用: 压缩对话历史开始时置 sCompressInProgress=true
    # 说明: suspend 方法(带 Continuation), 用 hookMethodByName 按名匹配; 不关心返回值
    # ============================================================
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;-><init>(I)V

    const-string v4, "me.rerere.rikkahub.service.ChatService"

    const-string v5, "compressConversation-hUnOzRk"

    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V

    # ============================================================
    # ⑤ 压缩失败 Hooker: hook ChatService.addError(String title,...)
    # 作用: 压缩失败(标志=true 且 title 含 "compress") → 失败提示 + 清标志
    # 注意: addError 第一参是 title(String), 源码 title="Conversation compression failed"
    # ============================================================
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;

    const/4 v2, 0x2

    invoke-direct {v1, v2}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;-><init>(I)V

    const-string v4, "me.rerere.rikkahub.service.ChatService"

    const-string v5, "addError"

    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V

    # ============================================================
    # ⑥ 压缩成功 Hooker: hook ChatService.saveConversation(Uuid,Conversation,Continuation)
    # 作用: 压缩成功(标志=true 且 saveConversation 被调) → 成功提示 + 清标志
    # 说明: suspend 方法, 用 hookMethodByName 按名匹配
    # ============================================================
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;

    const/4 v2, 0x3

    invoke-direct {v1, v2}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;-><init>(I)V

    const-string v4, "me.rerere.rikkahub.service.ChatService"

    const-string v5, "saveConversation"

    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    const/4 v0, 0x4

    const-string v1, "RikkaTune"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "installHooks done: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v3, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, " OK / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v3, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, " FAIL / \n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    # 附上明细（每条已带 \n, 从新行开始: "[OK] cls#mth\n")
    sget-object v3, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V

    # 清零计数器（热重载防叠加）
    const/4 v0, 0x0

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I

    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I

    # 清空明细
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->setLength(I)V

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

    # 安装全部 hooks (末尾会自动输出 "installHooks done: N OK / M FAIL" 汇总)
    invoke-direct {p0, v0}, Lcom/vstory/hook/rikkahub/MainHook;->installHooks(Ljava/lang/ClassLoader;)V

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
    .registers 2

    # ⚠️ 恢复静态引用 sDebug = this（热重载 = 新 ClassLoader 重载模块类 → static 全复位, sDebug 变 null）
    sput-object p0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    # ⚠️ 复位压缩反馈标志（热重载后 static 全复位, 避免残留 true 误报成功）
    const/4 v0, 0x0

    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z

    # 示例: 重新绑定跨进程配置 (XposedModule.getRemotePreferences)
    # const-string v0, "config"
    # invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedModule;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;
    # move-result-object v0
    # ... 再调用你自己的 ConfigData.init / 数据类 init / 广播标志恢复

    return-void
.end method

# ============================================================
# notifyCompressResult(Context, boolean) — 压缩成功/失败提示
# 用途: 压缩对话历史 成功/失败时 Toast + 通知 + 振动提示一次
# 参数: ctx(Context, 可能 null) / success(boolean: true=成功 false=失败)
# 提示:
#   - Toast: "压缩成功"/"压缩失败"
#   - 通知: 系统通知(含 Channel, API26+), 成功/失败图标不同
#   - 振动: Vibrator.createOneShot(ms, amplitude)
#          参考已有逻辑(0x3 Confirm 强振可感知): 成功(80ms,150) 失败(120ms,200)
# 注意: 模块 manifest 无通知权限声明(Android 13+ 通知权限 runtime) → 通知可能不显示,
#       Toast + 振动一定生效; 通知尽力而为(try-catch 包裹)
# ============================================================
.method public static notifyCompressResult(Landroid/content/Context;Z)V
    .registers 9

    # 防御: ctx null → 只返回
    if-eqz p0, :return

    # ============ Toast ============
    # String msg = success ? "压缩成功" : "压缩失败"
    const-string v0, "压缩成功"

    if-eqz p1, :toast_fail

    goto :toast_show

    :toast_fail
    const-string v0, "压缩失败"

    :toast_show
    # Toast.makeText(ctx, msg, LENGTH_SHORT).show()
    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    # ============ 振动 ============
    # ⚠️ 方案（2026-09-02 修正）: 目标 APP(RikkaHub) 无 VIBRATE 权限!
    #    Vibrator.vibrate() 用进程权限=RikkaHub 权限, 无 VIBRATE → SecurityException 被吞 → 不振
    #    修复: ① Vibrator 直接振动保留(万一有权限双保险, 静默 try-catch)
    #          ② 主路径 = 通知渠道启用振动(channel.enableVibration + setVibrationPattern)
    #             → 系统通知服务负责振动, 不需要 APP 的 VIBRATE 权限, 只要通知能弹出(已有 POST_NOTIFICATIONS)
    :try_start_vib
    # Debug.d("RikkaTune", "vibrate: try Vibrator")
    const-string v0, "RikkaTune"

    const-string v1, "vibrate: try Vibrator"

    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # Vibrator vib = (Vibrator) ctx.getSystemService("vibrator")
    const-string v0, "vibrator"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Landroid/os/Vibrator;

    if-eqz v1, :skip_vib

    check-cast v0, Landroid/os/Vibrator;

    # long ms = success ? 80 : 120
    const-wide/16 v1, 0x50

    if-eqz p1, :vib_ms_fail

    goto :vib_ms_ok

    :vib_ms_fail
    const-wide/16 v1, 0x78

    :vib_ms_ok
    # int amplitude = success ? 150 : 200
    const/16 v3, 0x96

    if-eqz p1, :vib_amp_fail

    goto :vib_amp_ok

    :vib_amp_fail
    const/16 v3, 0xc8

    :vib_amp_ok
    # VibrationEffect.createOneShot(ms, amplitude)
    invoke-static {v1, v2, v3}, Landroid/os/VibrationEffect;->createOneShot(JI)Landroid/os/VibrationEffect;

    move-result-object v1

    # vib.vibrate(effect)
    invoke-virtual {v0, v1}, Landroid/os/Vibrator;->vibrate(Landroid/os/VibrationEffect;)V

    :skip_vib
    :try_end_vib
    .catch Ljava/lang/Throwable; {:try_start_vib .. :try_end_vib} :catch_vib

    :catch_vib
    # 振动失败静默跳过 (无 VIBRATE 权限时走这里, 通知渠道振动兜底)
    # Debug.d("RikkaTune", "vibrate: FAILED (no VIBRATE perm?)")
    const-string v0, "RikkaTune"

    const-string v1, "vibrate: FAILED (no VIBRATE perm?)"

    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # ============ 通知 ============
    :try_start_notif
    # NotificationManager nm = (NotificationManager) ctx.getSystemService("notification")
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Landroid/app/NotificationManager;

    if-eqz v1, :skip_notif

    check-cast v0, Landroid/app/NotificationManager;

    # NotificationChannel(API 26+): id="compress_feedback", name="压缩反馈", IMPORTANCE_DEFAULT
    const-string v1, "compress_feedback"

    const-string v2, "压缩反馈"

    const/4 v3, 0x3

    new-instance v4, Landroid/app/NotificationChannel;

    invoke-direct {v4, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    # ⚠️ 通知渠道启用振动（主振动路径, 2026-09-02 修正）:
    #   channel.enableVibration(true) + channel.setVibrationPattern(long[])
    #   → 通知弹出时系统通知服务振动, 不需要 APP 的 VIBRATE 权限!
    #   模式: 成功 = [0,80,40,80] 短两振 / 失败 = [0,120,60,120] 长两振 (ms)
    const/4 v1, 0x1

    invoke-virtual {v4, v1}, Landroid/app/NotificationChannel;->enableVibration(Z)V

    # long[] pattern = success ? {0,80,40,80} : {0,120,60,120}
    const/4 v1, 0x4

    new-array v1, v1, [J

    const/4 v2, 0x0

    const-wide/16 v5, 0x0

    aput-wide v5, v1, v2

    const/4 v2, 0x1

    const-wide/16 v5, 0x50

    if-eqz p1, :pat_s1

    goto :pat_ok1

    :pat_s1
    const-wide/16 v5, 0x78

    :pat_ok1
    aput-wide v5, v1, v2

    const/4 v2, 0x2

    const-wide/16 v5, 0x28

    if-eqz p1, :pat_s2

    goto :pat_ok2

    :pat_s2
    const-wide/16 v5, 0x3c

    :pat_ok2
    aput-wide v5, v1, v2

    const/4 v2, 0x3

    const-wide/16 v5, 0x50

    if-eqz p1, :pat_s3

    goto :pat_ok3

    :pat_s3
    const-wide/16 v5, 0x78

    :pat_ok3
    aput-wide v5, v1, v2

    invoke-virtual {v4, v1}, Landroid/app/NotificationChannel;->setVibrationPattern([J)V

    # nm.createNotificationChannel(channel)
    invoke-virtual {v0, v4}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    # Debug.d("RikkaTune", "notify: channel created with vibration")
    const-string v1, "RikkaTune"

    const-string v2, "notify: channel created with vibration"

    invoke-static {v1, v2}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # Notification.Builder builder = new Notification.Builder(ctx, channelId)
    new-instance v4, Landroid/app/Notification$Builder;

    const-string v5, "compress_feedback"

    invoke-direct {v4, p0, v5}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    # 图标: 系统内置 (成功 stat_notify_sync / 失败 stat_notify_error)
    const v5, 0x1080083

    if-eqz p1, :icon_fail

    goto :icon_ok

    :icon_fail
    const v5, 0x1080078

    :icon_ok
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    # 标题
    const-string v5, "RikkaTune"

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    # 内容
    const-string v5, "对话历史压缩成功"

    if-eqz p1, :text_fail

    goto :text_ok

    :text_fail
    const-string v5, "对话历史压缩失败"

    :text_ok
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    # 自动消失
    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    # Notification n = builder.build()
    invoke-virtual {v4}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    # nm.notify(id, n)  // id: 成功=1 失败=2
    const/4 v2, 0x1

    if-eqz p1, :notif_id_fail

    goto :notif_id_ok

    :notif_id_fail
    const/4 v2, 0x2

    :notif_id_ok
    invoke-virtual {v0, v2, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    :skip_notif
    :try_end_notif
    .catch Ljava/lang/Throwable; {:try_start_notif .. :try_end_notif} :catch_notif

    :catch_notif
    # 通知失败静默跳过 (无通知权限等)

    :return
    return-void
.end method
