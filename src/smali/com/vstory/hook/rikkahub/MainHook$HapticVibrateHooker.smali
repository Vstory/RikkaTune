.class public Lcom/vstory/hook/rikkahub/MainHook$HapticVibrateHooker;
.super Ljava/lang/Object;
.implements Lio/github/libxposed/api/XposedInterface$Hooker;
.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 6
    const/4 v0, 0x0
    invoke-interface {p1, v0}, Lio/github/libxposed/api/XposedInterface$Chain;->getArg(I)Ljava/lang/Object;
    move-result-object v0
    instance-of v1, v0, Ljava/lang/Integer;
    if-eqz v1, :pass
    check-cast v0, Ljava/lang/Integer;
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    move-result v0
    const/16 v1, 0x17
    if-eq v0, v1, :replace
    const/16 v1, 0xd
    if-eq v0, v1, :replace
    :pass
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;
    move-result-object v0
    return-object v0
    :replace
    const/4 v0, 0x1
    new-array v0, v0, [Ljava/lang/Object;
    const/4 v1, 0x3
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v1
    const/4 v2, 0x0
    aput-object v1, v0, v2
    invoke-interface {p1, v0}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed([Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v0
    return-object v0
.end method
