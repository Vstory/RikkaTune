.class public interface abstract Lio/github/libxposed/service/IXposedScopeCallback;
.super Ljava/lang/Object;
.source "IXposedScopeCallback.java"
.implements Landroid/os/IInterface;
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IXposedScopeCallback$Stub;,
        Lio/github/libxposed/service/IXposedScopeCallback$Default;
    }
.end annotation
.field public static final DESCRIPTOR:Ljava/lang/String; = "io.github.libxposed.service.IXposedScopeCallback"
.method public abstract onScopeRequestApproved(Ljava/util/List;)V
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
.method public abstract onScopeRequestFailed(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
