.class public interface abstract Lio/github/libxposed/service/IXposedService;
.super Ljava/lang/Object;
.source "IXposedService.java"
.implements Landroid/os/IInterface;
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IXposedService$_Parcel;,
        Lio/github/libxposed/service/IXposedService$Stub;,
        Lio/github/libxposed/service/IXposedService$Default;
    }
.end annotation
.field public static final API_101:I = 0x65
.field public static final API_102:I = 0x66
.field public static final AUTHORITY_SUFFIX:Ljava/lang/String; = ".XposedService"
.field public static final DESCRIPTOR:Ljava/lang/String; = "io.github.libxposed.service.IXposedService"
.field public static final HOT_RELOAD_FAILED:I = 0x1
.field public static final HOT_RELOAD_IN_PROGRESS:I = 0x3
.field public static final HOT_RELOAD_PROCESS_DIED:I = 0x4
.field public static final HOT_RELOAD_SUCCEEDED:I = 0x0
.field public static final HOT_RELOAD_UNSUPPORTED:I = 0x2
.field public static final LIB_API:I = 0x66
.field public static final PROP_CAP_REMOTE:J = 0x2L
.field public static final PROP_CAP_SYSTEM:J = 0x1L
.field public static final PROP_RT_API_PROTECTION:J = 0x4L
.field public static final SEND_BINDER:Ljava/lang/String; = "SendBinder"
.method public abstract deleteRemoteFile(Ljava/lang/String;)Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract deleteRemotePreferences(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract getApiVersion()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract getFrameworkName()Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract getFrameworkProperties()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract getFrameworkVersion()Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract getFrameworkVersionCode()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract getRunningTargets()Ljava/util/List;
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
.end method
.method public abstract getScope()Ljava/util/List;
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
.end method
.method public abstract hotReloadModule(JLandroid/os/Bundle;Lio/github/libxposed/service/IHotReloadCallback;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract listRemoteFiles()[Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract openRemoteFile(Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract removeScope(Ljava/util/List;)V
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
.end method
.method public abstract requestRemotePreferences(Ljava/lang/String;)Landroid/os/Bundle;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
.method public abstract requestScope(Ljava/util/List;Lio/github/libxposed/service/IXposedScopeCallback;)V
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
.end method
.method public abstract updateRemotePreferences(Ljava/lang/String;Landroid/os/Bundle;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
