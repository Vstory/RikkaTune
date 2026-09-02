.class public Lio/github/libxposed/service/IXposedScopeCallback$Default;
.super Ljava/lang/Object;
.source "IXposedScopeCallback.java"
.implements Lio/github/libxposed/service/IXposedScopeCallback;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IXposedScopeCallback;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Default"
.end annotation
.method public constructor <init>()V
    .registers 1
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method public asBinder()Landroid/os/IBinder;
    .registers 1
    const/4 p0, 0x0
    return-object p0
.end method
.method public onScopeRequestApproved(Ljava/util/List;)V
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
.method public onScopeRequestFailed(Ljava/lang/String;)V
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
