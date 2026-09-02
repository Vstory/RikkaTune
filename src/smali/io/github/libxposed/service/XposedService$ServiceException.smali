.class public final Lio/github/libxposed/service/XposedService$ServiceException;
.super Ljava/lang/RuntimeException;
.source "XposedService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/XposedService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ServiceException"
.end annotation


# direct methods
.method constructor <init>(Landroid/os/RemoteException;)V
    .registers 3

    .line 60
    const-string v0, "Xposed service error"

    invoke-direct {p0, v0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;)V
    .registers 2

    .line 56
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    return-void
.end method
