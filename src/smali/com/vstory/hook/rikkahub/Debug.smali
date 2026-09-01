.class public Lcom/vstory/hook/rikkahub/Debug;
.super Ljava/lang/Object;

.method public static d(Ljava/lang/String;Ljava/lang/String;)V
    .registers 3

    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    if-eqz v0, :logcat

    invoke-virtual {v0, p0, p1}, Lcom/vstory/hook/rikkahub/MainHook;->logD(Ljava/lang/String;Ljava/lang/String;)V

    :logcat
    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5

    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;

    if-eqz v0, :logcat

    invoke-virtual {v0, p0, p1, p2}, Lcom/vstory/hook/rikkahub/MainHook;->logD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :logcat
    invoke-static {p0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method
