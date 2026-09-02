.class public abstract Lio/github/libxposed/service/IXposedScopeCallback$Stub;
.super Landroid/os/Binder;
.source "IXposedScopeCallback.java"

# interfaces
.implements Lio/github/libxposed/service/IXposedScopeCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IXposedScopeCallback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IXposedScopeCallback$Stub$Proxy;
    }
.end annotation


# static fields
.field static final TRANSACTION_onScopeRequestApproved:I = 0x2

.field static final TRANSACTION_onScopeRequestFailed:I = 0x3


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 32
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 33
    const-string v0, "io.github.libxposed.service.IXposedScopeCallback"

    invoke-virtual {p0, p0, v0}, Lio/github/libxposed/service/IXposedScopeCallback$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lio/github/libxposed/service/IXposedScopeCallback;
    .registers 3

    if-nez p0, :cond_4

    const/4 p0, 0x0

    return-object p0

    .line 44
    :cond_4
    const-string v0, "io.github.libxposed.service.IXposedScopeCallback"

    invoke-interface {p0, v0}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    if-eqz v0, :cond_13

    .line 45
    instance-of v1, v0, Lio/github/libxposed/service/IXposedScopeCallback;

    if-eqz v1, :cond_13

    .line 46
    check-cast v0, Lio/github/libxposed/service/IXposedScopeCallback;

    return-object v0

    .line 48
    :cond_13
    new-instance v0, Lio/github/libxposed/service/IXposedScopeCallback$Stub$Proxy;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/IXposedScopeCallback$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    return-object v0
.end method


# virtual methods
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

    .line 57
    const-string v1, "io.github.libxposed.service.IXposedScopeCallback"

    invoke-virtual {p2, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    :cond_d
    const/4 v1, 0x2

    if-eq p1, v1, :cond_20

    const/4 v1, 0x3

    if-eq p1, v1, :cond_18

    .line 77
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result p0

    return p0

    .line 71
    :cond_18
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    .line 72
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedScopeCallback$Stub;->onScopeRequestFailed(Ljava/lang/String;)V

    goto :goto_27

    .line 64
    :cond_20
    invoke-virtual {p2}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;

    move-result-object p1

    .line 65
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedScopeCallback$Stub;->onScopeRequestApproved(Ljava/util/List;)V

    :goto_27
    return v0
.end method
