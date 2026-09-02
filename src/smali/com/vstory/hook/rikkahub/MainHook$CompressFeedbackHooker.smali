.class public Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;
.super Ljava/lang/Object;
.implements Lio/github/libxposed/api/XposedInterface$Hooker;
.field private final kind:I
.method public constructor <init>(I)V
    .registers 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput p1, p0, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->kind:I
    return-void
.end method
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 10
    invoke-static {}, Lcom/vstory/hook/rikkahub/Prefs;->isCompressFeedback()Z
    move-result v2
    if-eqz v2, :proceed
    iget v0, p0, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->kind:I
    const/4 v1, 0x1
    if-eq v0, v1, :kind_1
    const/4 v1, 0x2
    if-eq v0, v1, :kind_2
    const/4 v1, 0x3
    if-eq v0, v1, :kind_3
    goto :proceed
    :kind_1
    const-string v0, "RikkaTune"
    const-string v1, "compress start, flag=true"
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    const/4 v0, 0x1
    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    goto :proceed
    :kind_2
    sget-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    const-string v6, "RikkaTune"
    const-string v7, "addError called, sCompressInProgress="
    sget-boolean v3, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v7, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-static {v6, v3}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    const/4 v3, 0x2
    invoke-interface {p1, v3}, Lio/github/libxposed/api/XposedInterface$Chain;->getArg(I)Ljava/lang/Object;
    move-result-object v3
    const-string v7, "addError title="
    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v7, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-static {v6, v3}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    if-eqz v0, :proceed
    :is_compress_error
    const-string v0, "RikkaTune"
    const-string v1, "compress FAILED, notify"
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {p1}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->getContextFromThis(Lio/github/libxposed/api/XposedInterface$Chain;)Landroid/content/Context;
    move-result-object v0
    const/4 v1, 0x0
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/MainHook;->notifyCompressResult(Landroid/content/Context;Z)V
    const/4 v0, 0x0
    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    goto :proceed
    :kind_3
    sget-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    if-eqz v0, :proceed
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;
    move-result-object v0
    array-length v1, v0
    const/4 v2, 0x0
    :loop_stack
    if-ge v2, v1, :not_from_compress
    aget-object v3, v0, v2
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;
    move-result-object v3
    const-string v4, "compressConversation"
    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v3
    if-nez v3, :from_compress
    add-int/lit8 v2, v2, 0x1
    goto :loop_stack
    :not_from_compress
    goto :proceed
    :from_compress
    const-string v0, "RikkaTune"
    const-string v1, "compress SUCCESS, notify"
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {p1}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;->getContextFromThis(Lio/github/libxposed/api/XposedInterface$Chain;)Landroid/content/Context;
    move-result-object v0
    const/4 v1, 0x1
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/MainHook;->notifyCompressResult(Landroid/content/Context;Z)V
    const/4 v0, 0x0
    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    goto :proceed
    :proceed
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;
    move-result-object v0
    return-object v0
.end method
.method private static getContextFromThis(Lio/github/libxposed/api/XposedInterface$Chain;)Landroid/content/Context;
    .registers 5
    invoke-interface {p0}, Lio/github/libxposed/api/XposedInterface$Chain;->getThisObject()Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :fail
    :try_start
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;
    move-result-object v1
    const-string v2, "context"
    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    invoke-virtual {v1, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v0
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
