.class public abstract Lio/github/libxposed/service/IHotReloadCallback$Stub;
.super Landroid/os/Binder;
.source "IHotReloadCallback.java"
.implements Lio/github/libxposed/service/IHotReloadCallback;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IHotReloadCallback;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IHotReloadCallback$Stub$Proxy;
    }
.end annotation
.field static final TRANSACTION_onHotReloadResult:I = 0x2
.method public constructor <init>()V
    .registers 2
    .line 36
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V
    .line 37
    const-string v0, "io.github.libxposed.service.IHotReloadCallback"
    invoke-virtual {p0, p0, v0}, Lio/github/libxposed/service/IHotReloadCallback$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V
    return-void
.end method
.method public static asInterface(Landroid/os/IBinder;)Lio/github/libxposed/service/IHotReloadCallback;
    .registers 3
    if-nez p0, :cond_4
    const/4 p0, 0x0
    return-object p0
    .line 48
    :cond_4
    const-string v0, "io.github.libxposed.service.IHotReloadCallback"
    invoke-interface {p0, v0}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;
    move-result-object v0
    if-eqz v0, :cond_13
    .line 49
    instance-of v1, v0, Lio/github/libxposed/service/IHotReloadCallback;
    if-eqz v1, :cond_13
    .line 50
    check-cast v0, Lio/github/libxposed/service/IHotReloadCallback;
    return-object v0
    .line 52
    :cond_13
    new-instance v0, Lio/github/libxposed/service/IHotReloadCallback$Stub$Proxy;
    invoke-direct {v0, p0}, Lio/github/libxposed/service/IHotReloadCallback$Stub$Proxy;-><init>(Landroid/os/IBinder;)V
    return-object v0
.end method
.method public asBinder()Landroid/os/IBinder;
    .registers 1
    return-object p0
.end method
.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .registers 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    const/4 v0, 0x1
    if-lt p1, v0, :cond_d
    const v1, 0xffffff
    if-gt p1, v1, :cond_d
    .line 61
    const-string v1, "io.github.libxposed.service.IHotReloadCallback"
    invoke-virtual {p2, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V
    :cond_d
    const/4 v1, 0x2
    if-eq p1, v1, :cond_15
    .line 76
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    move-result p0
    return p0
    .line 68
    :cond_15
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I
    move-result p1
    .line 70
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    move-result-object p2
    .line 71
    invoke-virtual {p0, p1, p2}, Lio/github/libxposed/service/IHotReloadCallback$Stub;->onHotReloadResult(ILjava/lang/String;)V
    return v0
.end method
