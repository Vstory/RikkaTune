.class public final Lio/github/libxposed/service/XposedServiceHelper;
.super Ljava/lang/Object;
.source "XposedServiceHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "XposedServiceHelper"

.field private static final mCache:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lio/github/libxposed/service/XposedService;",
            ">;"
        }
    .end annotation
.end field

.field private static mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 33
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lio/github/libxposed/service/XposedServiceHelper;->mCache:Ljava/util/Set;

    const/4 v0, 0x0

    .line 34
    sput-object v0, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic lambda$onBinderReceived$0(Lio/github/libxposed/service/XposedService;)V
    .registers 2

    .line 44
    sget-object v0, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    invoke-interface {v0, p0}, Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;->onServiceDied(Lio/github/libxposed/service/XposedService;)V

    return-void
.end method

.method static synthetic lambda$registerListener$1(Lio/github/libxposed/service/XposedService;)V
    .registers 2

    .line 66
    sget-object v0, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    invoke-interface {v0, p0}, Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;->onServiceDied(Lio/github/libxposed/service/XposedService;)V

    return-void
.end method

.method static onBinderReceived(Landroid/os/IBinder;)V
    .registers 5

    if-nez p0, :cond_3

    goto :goto_2f

    .line 38
    :cond_3
    sget-object v0, Lio/github/libxposed/service/XposedServiceHelper;->mCache:Ljava/util/Set;

    monitor-enter v0

    .line 40
    :try_start_6
    new-instance v1, Lio/github/libxposed/service/XposedService;

    invoke-static {p0}, Lio/github/libxposed/service/IXposedService$Stub;->asInterface(Landroid/os/IBinder;)Lio/github/libxposed/service/IXposedService;

    move-result-object v2

    invoke-direct {v1, v2}, Lio/github/libxposed/service/XposedService;-><init>(Lio/github/libxposed/service/IXposedService;)V

    .line 41
    sget-object v2, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    if-nez v2, :cond_17

    .line 42
    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_2e

    .line 44
    :cond_17
    new-instance v2, Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda1;

    invoke-direct {v2, v1}, Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda1;-><init>(Lio/github/libxposed/service/XposedService;)V

    const/4 v3, 0x0

    invoke-interface {p0, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V

    .line 45
    sget-object p0, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    invoke-interface {p0, v1}, Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;->onServiceBind(Lio/github/libxposed/service/XposedService;)V
    :try_end_25
    .catchall {:try_start_6 .. :try_end_25} :catchall_26

    goto :goto_2e

    :catchall_26
    move-exception p0

    .line 48
    :try_start_27
    const-string v1, "XposedServiceHelper"

    const-string v2, "onBinderReceived"

    invoke-static {v1, v2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 50
    :goto_2e
    monitor-exit v0

    :goto_2f
    return-void

    :catchall_30
    move-exception p0

    monitor-exit v0
    :try_end_32
    .catchall {:try_start_27 .. :try_end_32} :catchall_30

    throw p0
.end method

.method public static registerListener(Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;)V
    .registers 6

    .line 60
    sget-object v0, Lio/github/libxposed/service/XposedServiceHelper;->mCache:Ljava/util/Set;

    monitor-enter v0

    .line 61
    :try_start_3
    sput-object p0, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    .line 62
    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result p0

    if-nez p0, :cond_43

    .line 63
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_f
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1
    :try_end_13
    .catchall {:try_start_3 .. :try_end_13} :catchall_45

    if-eqz v1, :cond_3e

    .line 65
    :try_start_15
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/github/libxposed/service/XposedService;

    .line 66
    invoke-virtual {v1}, Lio/github/libxposed/service/XposedService;->asInterface()Lio/github/libxposed/service/IXposedService;

    move-result-object v2

    invoke-interface {v2}, Lio/github/libxposed/service/IXposedService;->asBinder()Landroid/os/IBinder;

    move-result-object v2

    new-instance v3, Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda0;

    invoke-direct {v3, v1}, Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda0;-><init>(Lio/github/libxposed/service/XposedService;)V

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V

    .line 67
    sget-object v2, Lio/github/libxposed/service/XposedServiceHelper;->mListener:Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;

    invoke-interface {v2, v1}, Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;->onServiceBind(Lio/github/libxposed/service/XposedService;)V
    :try_end_31
    .catchall {:try_start_15 .. :try_end_31} :catchall_32

    goto :goto_f

    :catchall_32
    move-exception v1

    .line 69
    :try_start_33
    const-string v2, "XposedServiceHelper"

    const-string v3, "registerListener"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 70
    invoke-interface {p0}, Ljava/util/Iterator;->remove()V

    goto :goto_f

    .line 73
    :cond_3e
    sget-object p0, Lio/github/libxposed/service/XposedServiceHelper;->mCache:Ljava/util/Set;

    invoke-interface {p0}, Ljava/util/Set;->clear()V

    .line 75
    :cond_43
    monitor-exit v0

    return-void

    :catchall_45
    move-exception p0

    monitor-exit v0
    :try_end_47
    .catchall {:try_start_33 .. :try_end_47} :catchall_45

    throw p0
.end method
