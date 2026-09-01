.class public Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;
.super Ljava/lang/Object;
.implements Lio/github/libxposed/api/XposedInterface$Hooker;
.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 12
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :ret_orig
    instance-of v2, v0, Ljava/lang/String;
    if-eqz v2, :ret_orig
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;
    move-result-object v2
    invoke-virtual {v2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;
    move-result-object v3
    const-string v4, "zh"
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :ret_orig
    invoke-virtual {v2}, Ljava/util/Locale;->getCountry()Ljava/lang/String;
    move-result-object v3
    const-string v4, "TW"
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-nez v5, :ret_orig
    const-string v4, "HK"
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-nez v5, :ret_orig
    const-string v4, "MO"
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-nez v5, :ret_orig
    check-cast v0, Ljava/lang/String;
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/Pangu;->pangu(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    return-object v1
    :ret_orig
    return-object v0
.end method
