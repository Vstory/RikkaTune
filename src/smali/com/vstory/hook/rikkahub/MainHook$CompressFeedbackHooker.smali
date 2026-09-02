#
# ============================================================
# CompressFeedbackHooker — 压缩对话历史 成功/失败提示
# 用途: RikkaHub 压缩历史成功后无提示/失败提示弱 → 成功/失败时
#       Toast + 通知 + 振动提示一次(振动幅度参考已有 0x3 Confirm 强振)
# 实现: 一个 hooker 三用途, 构造传入 kind:
#   kind=1: hook ChatService.compressConversation-hUnOzRk 入口
#           → 置 MainHook.sCompressInProgress = true (压缩开始)
#   kind=2: hook ChatService.addError(String,Throwable,Uuid,ChatErrorSolution)
#           → 若 sCompressInProgress && title 含 "compress"(忽略大小写)
#             → 失败提示 MainHook.notifyCompressResult(ctx, false), 清标志
#   kind=3: hook ChatService.saveConversation(Uuid,Conversation,Continuation)
#           → 若 sCompressInProgress → 成功提示 notifyCompressResult(ctx, true), 清标志
# 原理:
#   - 压缩成功唯一落库动作 = saveConversation(在 compressConversation 末尾)
#   - 压缩失败不调 saveConversation → 走 addError(title="Conversation compression failed")
#   - addError 其它错误 title 不含 compress, 不误报
# 拿 Context: hook 的 this = ChatService 实例, 反射读其 context 字段(Application)
# ============================================================
# ⚠️ libxposed Chain API:
#   - getThisObject() 返回被 hook 方法所属实例 (static 方法为 null)
#   - getArg(int index) 返回 Object
#   - proceed() 必须调用, 否则原方法不执行!
# ============================================================
.class public Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;
.super Ljava/lang/Object;

# interfaces
.implements Lio/github/libxposed/api/XposedInterface$Hooker;

# instance fields
.field private final kind:I

# direct methods
.method public constructor <init>(I)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->kind:I

    return-void
.end method

# virtual methods
# Object intercept(Chain chain) -> 按 kind 分支处理, 始终 proceed()
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 10

    iget v0, p0, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->kind:I

    # switch(kind)
    const/4 v1, 0x1

    if-eq v0, v1, :kind_1

    const/4 v1, 0x2

    if-eq v0, v1, :kind_2

    const/4 v1, 0x3

    if-eq v0, v1, :kind_3

    # 未知 kind → 直接放行
    goto :proceed

    # ============================================================
    # kind=1: compressConversation 入口 → 置压缩标志
    # ============================================================
    :kind_1
    # Debug.d("RikkaTune", "compress start, flag=true")
    const-string v0, "RikkaTune"

    const-string v1, "compress start, flag=true"
    # 
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z

    goto :proceed

    # ============================================================
    # kind=2: addError → 若压缩中 && title 含 "compress" → 失败提示
    # ============================================================
    :kind_2
    # 压缩中? 不是则放行
    sget-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z

    # ⚠️ 调试诊断日志(保留到 debug 版): 每次 addError 被调都打印标志状态 + title 值
    #   📌 用途: RikkaHub 新版本发布后, 若压缩反馈功能失效, 构建 debug 版可直接看
    #   这里确认 addError 是否被调/标志状态/title 值 → 快速定位 hook 点是否失效
    #   ⚠️ 发布正式版时, 以下 Debug.d 调用随 strip 流程一起注释掉(不影响逻辑)
    const-string v6, "RikkaTune"
    # 
    const-string v7, "addError called, sCompressInProgress="
    # 
    # sget-boolean v3, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    # 
    # invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;
    # 
    # move-result-object v3
    # 
    # invoke-virtual {v7, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    # 
    # move-result-object v3
    # 
    invoke-static {v6, v3}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # 诊断: 打 title 值 (addError 签名: error, conversationId, title, solution → title=getArg(2))
    # const/4 v3, 0x2
    # 
    # invoke-interface {p1, v3}, Lio/github/libxposed/api/XposedInterface$Chain;->getArg(I)Ljava/lang/Object;
    # 
    # move-result-object v3
    # 
    const-string v7, "addError title="
    # 
    # invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    # 
    # move-result-object v3
    # 
    # invoke-virtual {v7, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    # 
    # move-result-object v3
    # 
    invoke-static {v6, v3}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # 📌 2026-09-02 修复: 压缩失败判定改为【只要 sCompressInProgress=true 就反馈失败】
    #   实测: RikkaHub 压缩失败 addError 的 title=null! (不传 title)
    #   → 之前按 title 含"压缩"判断 → 永不命中 → 失败反馈不触发
    #   现在: 压缩中标志=true 时, addError 必然是压缩失败(压缩成功走 saveConversation 不走 addError)
    #   → 直接反馈失败
    if-eqz v0, :proceed

    # 压缩失败 → 提示
    :is_compress_error
    # Debug.d("RikkaTune", "compress FAILED, notify")
    const-string v0, "RikkaTune"

    const-string v1, "compress FAILED, notify"
    # 
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # Context ctx = getContextFromThis(chain)
    invoke-static {p1}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->getContextFromThis(Lio/github/libxposed/api/XposedInterface$Chain;)Landroid/content/Context;

    move-result-object v0

    # MainHook.notifyCompressResult(ctx, false)
    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/MainHook;->notifyCompressResult(Landroid/content/Context;Z)V

    # 清标志
    const/4 v0, 0x0

    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z

    goto :proceed

    # ============================================================
    # kind=3: saveConversation → 若压缩中 → 成功提示
    # ============================================================
    :kind_3
    # 压缩中? 不是则放行
    sget-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z

    if-eqz v0, :proceed

    # ⚠️ 2026-09-02 修复: 发送消息 sendMessage 也会调 saveConversation!
    #    sCompressInProgress=true 期间(压缩进行中), 用户发送消息 → sendMessage 的
    #    saveConversation 被误判为"压缩成功" → 误弹成功 toast
    #    区分: 检查调用栈里是否有 "compressConversation" 帧
    #    - 压缩收尾的 saveConversation: 栈里有 compressConversation (压缩方法)
    #    - 发送消息的 saveConversation: 栈里是 sendMessage, 无 compressConversation
    #    Thread.currentThread().getStackTrace() → StackTraceElement[]
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :loop_stack
    if-ge v2, v1, :not_from_compress

    aget-object v3, v0, v2

    # StackTraceElement.getMethodName() → 判断是否含 compressConversation
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "compressConversation"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :from_compress

    add-int/lit8 v2, v2, 0x1

    goto :loop_stack

    # 栈里无 compressConversation → 不是压缩收尾(发送消息等), 不反馈
    :not_from_compress
    goto :proceed

    # 栈里有 compressConversation → 真压缩成功 → 反馈
    :from_compress
    # Debug.d("RikkaTune", "compress SUCCESS, notify")
    const-string v0, "RikkaTune"

    const-string v1, "compress SUCCESS, notify"
    # 
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    # Context ctx = getContextFromThis(chain)
    invoke-static {p1}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->getContextFromThis(Lio/github/libxposed/api/XposedInterface$Chain;)Landroid/content/Context;

    move-result-object v0

    # MainHook.notifyCompressResult(ctx, true)
    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/MainHook;->notifyCompressResult(Landroid/content/Context;Z)V

    # 清标志
    const/4 v0, 0x0

    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z

    goto :proceed

    # ============================================================
    # 放行原方法 (所有分支都必须 proceed)
    # ============================================================
    :proceed
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

# private static Context getContextFromThis(Chain chain)
#   从 hook 的 this(ChatService 实例) 反射读 context 字段(Application)
#   失败返回 null(调用方防御)
.method private static getContextFromThis(Lio/github/libxposed/api/XposedInterface$Chain;)Landroid/content/Context;
    .registers 5

    # 防御: chain.getThisObject() null → 返回 null
    invoke-interface {p0}, Lio/github/libxposed/api/XposedInterface$Chain;->getThisObject()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :fail

    # ⚠️ 不能 instance-of 直接引用 APP 类 (ChatService) — 模块/APP 不同 ClassLoader, 会 NoClassDefFoundError!
    #    直接用反射: v0.getClass() 动态拿运行时类, 再 getDeclaredField("context")
    # 反射读 ChatService.context 字段 (public final Application)
    :try_start
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "context"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    # 兼容跨类读 private? context 是 public final, 但防御性 setAccessible(true)
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v1, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    # 返回 Object → Context
    instance-of v1, v0, Landroid/content/Context;

    if-eqz v1, :fail

    check-cast v0, Landroid/content/Context;

    return-object v0
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_fail

    :catch_fail
    :fail
    const/4 v0, 0x0

    return-object v0
.end method
