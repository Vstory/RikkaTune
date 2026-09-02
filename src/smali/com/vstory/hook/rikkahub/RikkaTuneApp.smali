.class public Lcom/vstory/hook/rikkahub/RikkaTuneApp;
.super Landroid/app/Application;
.implements Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;
.field public static sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
.field public static sPrefs:Landroid/content/SharedPreferences;
.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Application;-><init>()V
    return-void
.end method
.method public onCreate()V
    .registers 1
    invoke-super {p0}, Landroid/app/Application;->onCreate()V
    invoke-static {p0}, Lio/github/libxposed/service/XposedServiceHelper;->registerListener(Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;)V
    return-void
.end method
.method public onServiceBind(Lio/github/libxposed/service/XposedService;)V
    .registers 3
    const-string v0, "rikka_config"
    invoke-virtual {p1, v0}, Lio/github/libxposed/service/XposedService;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;
    move-result-object v0
    sput-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sPrefs:Landroid/content/SharedPreferences;
    sget-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
    if-eqz v0, :done
    invoke-virtual {v0, p1}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->onServiceBind(Lio/github/libxposed/service/XposedService;)V
    :done
    return-void
.end method
.method public onServiceDied(Lio/github/libxposed/service/XposedService;)V
    .registers 2
    const/4 v0, 0x0
    sput-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sPrefs:Landroid/content/SharedPreferences;
    sget-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
    if-eqz v0, :done
    invoke-virtual {v0, p1}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->onServiceDied(Lio/github/libxposed/service/XposedService;)V
    :done
    return-void
.end method
