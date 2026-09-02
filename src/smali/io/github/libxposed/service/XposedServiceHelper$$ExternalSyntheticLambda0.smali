.class public final synthetic Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# instance fields
.field public final synthetic f$0:Lio/github/libxposed/service/XposedService;


# direct methods
.method public synthetic constructor <init>(Lio/github/libxposed/service/XposedService;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda0;->f$0:Lio/github/libxposed/service/XposedService;

    return-void
.end method


# virtual methods
.method public final binderDied()V
    .registers 1

    .line 0
    iget-object p0, p0, Lio/github/libxposed/service/XposedServiceHelper$$ExternalSyntheticLambda0;->f$0:Lio/github/libxposed/service/XposedService;

    invoke-static {p0}, Lio/github/libxposed/service/XposedServiceHelper;->lambda$registerListener$1(Lio/github/libxposed/service/XposedService;)V

    return-void
.end method
