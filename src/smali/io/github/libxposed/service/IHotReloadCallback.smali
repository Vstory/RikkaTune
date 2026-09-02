.class public interface abstract Lio/github/libxposed/service/IHotReloadCallback;
.super Ljava/lang/Object;
.source "IHotReloadCallback.java"

# interfaces
.implements Landroid/os/IInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IHotReloadCallback$Stub;,
        Lio/github/libxposed/service/IHotReloadCallback$Default;
    }
.end annotation


# static fields
.field public static final DESCRIPTOR:Ljava/lang/String; = "io.github.libxposed.service.IHotReloadCallback"


# virtual methods
.method public abstract onHotReloadResult(ILjava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
