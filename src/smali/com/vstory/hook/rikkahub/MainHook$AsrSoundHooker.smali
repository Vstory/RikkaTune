.class public Lcom/vstory/hook/rikkahub/MainHook$AsrSoundHooker;
.super Ljava/lang/Object;
.implements Lio/github/libxposed/api/XposedInterface$Hooker;
.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 5
    const/4 v0, 0x1
    invoke-interface {p1, v0}, Lio/github/libxposed/api/XposedInterface$Chain;->getArg(I)Ljava/lang/Object;
    move-result-object v0
    invoke-static {}, Lcom/vstory/hook/rikkahub/Prefs;->isAsrSoundMuted()Z
    move-result v2
    if-eqz v2, :pass
    instance-of v1, v0, Ljava/lang/Integer;
    if-eqz v1, :pass
    check-cast v0, Ljava/lang/Integer;
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    move-result v0
    const v1, 0x7f120000
    if-eq v0, v1, :swallow
    const v1, 0x7f120001
    if-eq v0, v1, :swallow
    :pass
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;
    move-result-object v0
    return-object v0
    :swallow
    const/4 v0, 0x0
    return-object v0
.end method
