.class public interface abstract Lio/github/libxposed/service/IHotReloadCallback;
.super Ljava/lang/Object;
.source "IHotReloadCallback.java"
.implements Landroid/os/IInterface;
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IHotReloadCallback$Stub;,
        Lio/github/libxposed/service/IHotReloadCallback$Default;
    }
.end annotation
.field public static final DESCRIPTOR:Ljava/lang/String; = "io.github.libxposed.service.IHotReloadCallback"
.method public abstract onHotReloadResult(ILjava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
