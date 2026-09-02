.class public final Lio/github/libxposed/service/XposedService;
.super Ljava/lang/Object;
.source "XposedService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/XposedService$ServiceException;,
        Lio/github/libxposed/service/XposedService$OnScopeEventListener;,
        Lio/github/libxposed/service/XposedService$HotReloadCallback;
    }
.end annotation


# static fields
.field public static final API_101:I = 0x65

.field public static final API_102:I = 0x66

.field public static final PROP_CAP_REMOTE:J = 0x2L

.field public static final PROP_CAP_SYSTEM:J = 0x1L

.field public static final PROP_RT_API_PROTECTION:J = 0x4L

.field private static final hotReloadCallbacks:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lio/github/libxposed/service/IHotReloadCallback;",
            ">;"
        }
    .end annotation
.end field

.field private static final scopeCallbacks:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lio/github/libxposed/service/XposedService$OnScopeEventListener;",
            "Lio/github/libxposed/service/IXposedScopeCallback;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final mRemotePrefs:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lio/github/libxposed/service/RemotePreferences;",
            ">;"
        }
    .end annotation
.end field

.field private final mService:Lio/github/libxposed/service/IXposedService;


# direct methods
.method public static synthetic $r8$lambda$T61Hp6givnZnE4Lb5F5l4UAfaGw(Lio/github/libxposed/service/XposedService;Ljava/lang/String;)Lio/github/libxposed/service/RemotePreferences;
    .registers 2

    invoke-direct {p0, p1}, Lio/github/libxposed/service/XposedService;->lambda$getRemotePreferences$0(Ljava/lang/String;)Lio/github/libxposed/service/RemotePreferences;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$sfgethotReloadCallbacks()Ljava/util/Set;
    .registers 1

    sget-object v0, Lio/github/libxposed/service/XposedService;->hotReloadCallbacks:Ljava/util/Set;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetscopeCallbacks()Ljava/util/Map;
    .registers 1

    sget-object v0, Lio/github/libxposed/service/XposedService;->scopeCallbacks:Ljava/util/Map;

    return-object v0
.end method

.method static constructor <clinit>()V
    .registers 1

    .line 64
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lio/github/libxposed/service/XposedService;->scopeCallbacks:Ljava/util/Map;

    .line 65
    invoke-static {}, Ljava/util/concurrent/ConcurrentHashMap;->newKeySet()Ljava/util/concurrent/ConcurrentHashMap$KeySetView;

    move-result-object v0

    sput-object v0, Lio/github/libxposed/service/XposedService;->hotReloadCallbacks:Ljava/util/Set;

    return-void
.end method

.method constructor <init>(Lio/github/libxposed/service/IXposedService;)V
    .registers 3

    .line 125
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 123
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lio/github/libxposed/service/XposedService;->mRemotePrefs:Ljava/util/Map;

    .line 126
    iput-object p1, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    return-void
.end method

.method private synthetic lambda$getRemotePreferences$0(Ljava/lang/String;)Lio/github/libxposed/service/RemotePreferences;
    .registers 2

    .line 382
    :try_start_0
    invoke-static {p0, p1}, Lio/github/libxposed/service/RemotePreferences;->newInstance(Lio/github/libxposed/service/XposedService;Ljava/lang/String;)Lio/github/libxposed/service/RemotePreferences;

    move-result-object p0
    :try_end_4
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_4} :catch_5

    return-object p0

    :catch_5
    move-exception p0

    .line 384
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw p1
.end method

.method private requireApi(I)V
    .registers 4

    .line 134
    invoke-virtual {p0}, Lio/github/libxposed/service/XposedService;->getApiVersion()I

    move-result p0

    if-lt p0, p1, :cond_7

    return-void

    .line 135
    :cond_7
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Requires Xposed service API "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static toHookedTarget(Lio/github/libxposed/service/HookedProcess;)Lio/github/libxposed/service/HookedTarget;
    .registers 11

    .line 347
    iget-object v0, p0, Lio/github/libxposed/service/HookedProcess;->processName:Ljava/lang/String;

    if-eqz v0, :cond_1a

    .line 350
    new-instance v1, Lio/github/libxposed/service/HookedTarget;

    iget-wide v2, p0, Lio/github/libxposed/service/HookedProcess;->targetId:J

    iget v4, p0, Lio/github/libxposed/service/HookedProcess;->uid:I

    iget v5, p0, Lio/github/libxposed/service/HookedProcess;->pid:I

    iget-object v6, p0, Lio/github/libxposed/service/HookedProcess;->processName:Ljava/lang/String;

    iget v0, p0, Lio/github/libxposed/service/HookedProcess;->state:I

    .line 355
    invoke-static {v0}, Lio/github/libxposed/service/XposedService;->toHookedTargetState(I)Lio/github/libxposed/service/HookedTarget$State;

    move-result-object v7

    iget-wide v8, p0, Lio/github/libxposed/service/HookedProcess;->loadedVersionCode:J

    invoke-direct/range {v1 .. v9}, Lio/github/libxposed/service/HookedTarget;-><init>(JIILjava/lang/String;Lio/github/libxposed/service/HookedTarget$State;J)V

    return-object v1

    .line 348
    :cond_1a
    new-instance p0, Lio/github/libxposed/service/XposedService$ServiceException;

    const-string v0, "Framework returns target with null processName"

    invoke-direct {p0, v0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static toHookedTargetState(I)Lio/github/libxposed/service/HookedTarget$State;
    .registers 4

    if-eqz p0, :cond_29

    const/4 v0, 0x1

    if-eq p0, v0, :cond_26

    const/4 v0, 0x2

    if-eq p0, v0, :cond_23

    const/4 v0, 0x3

    if-ne p0, v0, :cond_e

    .line 365
    sget-object p0, Lio/github/libxposed/service/HookedTarget$State;->FAILED:Lio/github/libxposed/service/HookedTarget$State;

    return-object p0

    .line 366
    :cond_e
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Invalid hooked target state: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 364
    :cond_23
    sget-object p0, Lio/github/libxposed/service/HookedTarget$State;->RELOADING:Lio/github/libxposed/service/HookedTarget$State;

    return-object p0

    .line 363
    :cond_26
    sget-object p0, Lio/github/libxposed/service/HookedTarget$State;->STALE:Lio/github/libxposed/service/HookedTarget$State;

    return-object p0

    .line 362
    :cond_29
    sget-object p0, Lio/github/libxposed/service/HookedTarget$State;->UP_TO_DATE:Lio/github/libxposed/service/HookedTarget$State;

    return-object p0
.end method


# virtual methods
.method asInterface()Lio/github/libxposed/service/IXposedService;
    .registers 1

    .line 130
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    return-object p0
.end method

.method public deleteRemoteFile(Ljava/lang/String;)Z
    .registers 2

    .line 453
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0, p1}, Lio/github/libxposed/service/IXposedService;->deleteRemoteFile(Ljava/lang/String;)Z

    move-result p0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return p0

    :catch_7
    move-exception p0

    .line 455
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw p1
.end method

.method public declared-synchronized deleteRemotePreferences(Ljava/lang/String;)V
    .registers 3

    monitor-enter p0

    .line 398
    :try_start_1
    iget-object v0, p0, Lio/github/libxposed/service/XposedService;->mRemotePrefs:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/github/libxposed/service/RemotePreferences;

    if-eqz v0, :cond_e

    .line 399
    invoke-virtual {v0}, Lio/github/libxposed/service/RemotePreferences;->onDelete()V

    .line 400
    :cond_e
    iget-object v0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {v0, p1}, Lio/github/libxposed/service/IXposedService;->deleteRemotePreferences(Ljava/lang/String;)V
    :try_end_13
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_13} :catch_17
    .catchall {:try_start_1 .. :try_end_13} :catchall_15

    .line 404
    monitor-exit p0

    return-void

    :catchall_15
    move-exception p1

    goto :goto_1e

    :catch_17
    move-exception p1

    .line 402
    :try_start_18
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p1}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0

    :goto_1e
    monitor-exit p0
    :try_end_1f
    .catchall {:try_start_18 .. :try_end_1f} :catchall_15

    throw p1
.end method

.method public getApiVersion()I
    .registers 2

    .line 147
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getApiVersion()I

    move-result p0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return p0

    :catch_7
    move-exception p0

    .line 149
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public getFrameworkName()Ljava/lang/String;
    .registers 2

    .line 162
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getFrameworkName()Ljava/lang/String;

    move-result-object p0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return-object p0

    :catch_7
    move-exception p0

    .line 164
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public getFrameworkProperties()J
    .registers 3

    .line 206
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getFrameworkProperties()J

    move-result-wide v0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return-wide v0

    :catch_7
    move-exception p0

    .line 208
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public getFrameworkVersion()Ljava/lang/String;
    .registers 2

    .line 177
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getFrameworkVersion()Ljava/lang/String;

    move-result-object p0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return-object p0

    :catch_7
    move-exception p0

    .line 179
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public getFrameworkVersionCode()J
    .registers 3

    .line 191
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getFrameworkVersionCode()J

    move-result-wide v0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return-wide v0

    :catch_7
    move-exception p0

    .line 193
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public declared-synchronized getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;
    .registers 4

    monitor-enter p0

    .line 380
    :try_start_1
    iget-object v0, p0, Lio/github/libxposed/service/XposedService;->mRemotePrefs:Ljava/util/Map;

    new-instance v1, Lio/github/libxposed/service/XposedService$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lio/github/libxposed/service/XposedService$$ExternalSyntheticLambda0;-><init>(Lio/github/libxposed/service/XposedService;)V

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->computeIfAbsent(Ljava/lang/Object;Ljava/util/function/Function;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/content/SharedPreferences;
    :try_end_e
    .catchall {:try_start_1 .. :try_end_e} :catchall_10

    monitor-exit p0

    return-object p1

    :catchall_10
    move-exception p1

    :try_start_11
    monitor-exit p0
    :try_end_12
    .catchall {:try_start_11 .. :try_end_12} :catchall_10

    throw p1
.end method

.method public getRunningTargets()Ljava/util/List;
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/github/libxposed/service/HookedTarget;",
            ">;"
        }
    .end annotation

    const/16 v0, 0x66

    .line 271
    invoke-direct {p0, v0}, Lio/github/libxposed/service/XposedService;->requireApi(I)V

    .line 273
    :try_start_5
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getRunningTargets()Ljava/util/List;

    move-result-object p0

    if-eqz p0, :cond_3d

    .line 275
    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 276
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_1a
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_38

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/github/libxposed/service/HookedProcess;

    if-eqz v1, :cond_30

    .line 278
    invoke-static {v1}, Lio/github/libxposed/service/XposedService;->toHookedTarget(Lio/github/libxposed/service/HookedProcess;)Lio/github/libxposed/service/HookedTarget;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1a

    .line 277
    :cond_30
    new-instance p0, Lio/github/libxposed/service/XposedService$ServiceException;

    const-string v0, "Framework returns null target"

    invoke-direct {p0, v0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 280
    :cond_38
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p0

    return-object p0

    .line 274
    :cond_3d
    new-instance p0, Lio/github/libxposed/service/XposedService$ServiceException;

    const-string v0, "Framework returns null"

    invoke-direct {p0, v0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_45
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_45} :catch_45

    :catch_45
    move-exception p0

    .line 282
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public getScope()Ljava/util/List;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 221
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->getScope()Ljava/util/List;

    move-result-object p0
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_6} :catch_7

    return-object p0

    :catch_7
    move-exception p0

    .line 223
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public hotReloadModule(Lio/github/libxposed/service/HookedTarget;Landroid/os/Bundle;Lio/github/libxposed/service/XposedService$HotReloadCallback;)V
    .registers 7

    const/16 v0, 0x66

    .line 321
    invoke-direct {p0, v0}, Lio/github/libxposed/service/XposedService;->requireApi(I)V

    .line 322
    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 323
    invoke-static {p3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 324
    new-instance v0, Lio/github/libxposed/service/XposedService$1;

    invoke-direct {v0, p0, p3, p1}, Lio/github/libxposed/service/XposedService$1;-><init>(Lio/github/libxposed/service/XposedService;Lio/github/libxposed/service/XposedService$HotReloadCallback;Lio/github/libxposed/service/HookedTarget;)V

    .line 334
    sget-object p3, Lio/github/libxposed/service/XposedService;->hotReloadCallbacks:Ljava/util/Set;

    invoke-interface {p3, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 336
    :try_start_15
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    iget-wide v1, p1, Lio/github/libxposed/service/HookedTarget;->mTargetId:J

    invoke-interface {p0, v1, v2, p2, v0}, Lio/github/libxposed/service/IXposedService;->hotReloadModule(JLandroid/os/Bundle;Lio/github/libxposed/service/IHotReloadCallback;)V
    :try_end_1c
    .catch Landroid/os/RemoteException; {:try_start_15 .. :try_end_1c} :catch_24
    .catch Ljava/lang/RuntimeException; {:try_start_15 .. :try_end_1c} :catch_1d

    return-void

    :catch_1d
    move-exception p0

    .line 341
    sget-object p1, Lio/github/libxposed/service/XposedService;->hotReloadCallbacks:Ljava/util/Set;

    invoke-interface {p1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 342
    throw p0

    :catch_24
    move-exception p0

    .line 338
    sget-object p1, Lio/github/libxposed/service/XposedService;->hotReloadCallbacks:Ljava/util/Set;

    invoke-interface {p1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 339
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw p1
.end method

.method public listRemoteFiles()[Ljava/lang/String;
    .registers 2

    .line 416
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0}, Lio/github/libxposed/service/IXposedService;->listRemoteFiles()[Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_9

    return-object p0

    .line 417
    :cond_9
    new-instance p0, Lio/github/libxposed/service/XposedService$ServiceException;

    const-string v0, "Framework returns null"

    invoke-direct {p0, v0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_11
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_11} :catch_11

    :catch_11
    move-exception p0

    .line 420
    new-instance v0, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw v0
.end method

.method public openRemoteFile(Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .registers 2

    .line 435
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0, p1}, Lio/github/libxposed/service/IXposedService;->openRemoteFile(Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object p0

    if-eqz p0, :cond_9

    return-object p0

    .line 436
    :cond_9
    new-instance p0, Lio/github/libxposed/service/XposedService$ServiceException;

    const-string p1, "Framework returns null"

    invoke-direct {p0, p1}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_11
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_11} :catch_11

    :catch_11
    move-exception p0

    .line 439
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw p1
.end method

.method public removeScope(Ljava/util/List;)V
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 250
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-interface {p0, p1}, Lio/github/libxposed/service/IXposedService;->removeScope(Ljava/util/List;)V
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_5} :catch_6

    return-void

    :catch_6
    move-exception p0

    .line 252
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw p1
.end method

.method public requestScope(Ljava/util/List;Lio/github/libxposed/service/XposedService$OnScopeEventListener;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lio/github/libxposed/service/XposedService$OnScopeEventListener;",
            ")V"
        }
    .end annotation

    .line 236
    :try_start_0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService;->mService:Lio/github/libxposed/service/IXposedService;

    invoke-static {p2}, Lio/github/libxposed/service/XposedService$OnScopeEventListener;->-$$Nest$masInterface(Lio/github/libxposed/service/XposedService$OnScopeEventListener;)Lio/github/libxposed/service/IXposedScopeCallback;

    move-result-object p2

    invoke-interface {p0, p1, p2}, Lio/github/libxposed/service/IXposedService;->requestScope(Ljava/util/List;Lio/github/libxposed/service/IXposedScopeCallback;)V
    :try_end_9
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_9} :catch_a

    return-void

    :catch_a
    move-exception p0

    .line 238
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Landroid/os/RemoteException;)V

    throw p1
.end method
