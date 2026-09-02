#
# ============================================================
# RikkaTuneApp.smali — 进程级 XposedService 连接器（修复死面板, 2026-09-02）
# ============================================================
# 📌 为什么存在 (registerListener 必须进程级一次, 官方注释 only be called once):
#   - 旧 RikkaTuneActivity.onCreate 里 registerListener → 每次打开面板覆盖静态
#     mListener 为新 Activity, 但框架 binder 只在 uid 首次 active 发一次 + mCache
#     第一次后清空 → 关掉再打开(同进程 Activity 重建) = 死面板(永远收不到 binder)
#   - 正确姿势(对照 AppErrors): Application.onCreate 注册一次(进程最早),
#     service/prefs 静态持有 → 任何 Activity 实例都能用, 无需框架重发 binder
#   - UI 进程: 本 Application 进程级注册; hook 进程走 MainHook(不冲突, 各进程独立)
# ============================================================
.class public Lcom/vstory/hook/rikkahub/RikkaTuneApp;
.super Landroid/app/Application;

# interfaces
.implements Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

# instance fields

# 当前连接的 Activity（转发 onServiceBind/Died 用; Activity onDestroy 清空）
.field public static sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;

# 进程级持有的 RemotePreferences（连上后常驻; Activity 重建直接读, 不需等新 binder）
.field public static sPrefs:Landroid/content/SharedPreferences;

# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

# virtual methods
.method public onCreate()V
    .registers 1

    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    # ⚠️ 进程级注册 XposedService（只在 Application 注册一次, 勿在 Activity 注册!）
    invoke-static {p0}, Lio/github/libxposed/service/XposedServiceHelper;->registerListener(Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;)V

    return-void
.end method

# 框架 binder 到达 → 存 prefs 静态 + 转发给当前 UI Activity（如有）
.method public onServiceBind(Lio/github/libxposed/service/XposedService;)V
    .registers 3

    # sPrefs = service.getRemotePreferences("rikka_config")
    const-string v0, "rikka_config"

    invoke-virtual {p1, v0}, Lio/github/libxposed/service/XposedService;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;

    move-result-object v0

    sput-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sPrefs:Landroid/content/SharedPreferences;

    # 转发给当前 UI（Activity.onCreate 里设 sUi=this）; 无 UI 就只存静态
    sget-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;

    if-eqz v0, :done

    invoke-virtual {v0, p1}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->onServiceBind(Lio/github/libxposed/service/XposedService;)V

    :done
    return-void
.end method

# 框架断开 → 清静态 + 转发给当前 UI
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
