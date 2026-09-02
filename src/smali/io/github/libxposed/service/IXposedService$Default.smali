.class public Lio/github/libxposed/service/IXposedService$Default;
.super Ljava/lang/Object;
.source "IXposedService.java"
.implements Lio/github/libxposed/service/IXposedService;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IXposedService;
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
.method public deleteRemoteFile(Ljava/lang/String;)Z
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return p0
.end method
.method public deleteRemotePreferences(Ljava/lang/String;)V
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
.method public getApiVersion()I
    .registers 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return p0
.end method
.method public getFrameworkName()Ljava/lang/String;
    .registers 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
.end method
.method public getFrameworkProperties()J
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const-wide/16 v0, 0x0
    return-wide v0
.end method
.method public getFrameworkVersion()Ljava/lang/String;
    .registers 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
.end method
.method public getFrameworkVersionCode()J
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const-wide/16 v0, 0x0
    return-wide v0
.end method
.method public getRunningTargets()Ljava/util/List;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/github/libxposed/service/HookedProcess;",
            ">;"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
.end method
.method public getScope()Ljava/util/List;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
.end method
.method public hotReloadModule(JLandroid/os/Bundle;Lio/github/libxposed/service/IHotReloadCallback;)V
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
.method public listRemoteFiles()[Ljava/lang/String;
    .registers 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
.end method
.method public openRemoteFile(Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
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
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
.method public requestRemotePreferences(Ljava/lang/String;)Landroid/os/Bundle;
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 p0, 0x0
    return-object p0
.end method
.method public requestScope(Ljava/util/List;Lio/github/libxposed/service/IXposedScopeCallback;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lio/github/libxposed/service/IXposedScopeCallback;",
            ")V"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
.method public updateRemotePreferences(Ljava/lang/String;Landroid/os/Bundle;)V
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    return-void
.end method
