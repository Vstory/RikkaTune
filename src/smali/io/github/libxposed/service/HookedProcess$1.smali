.class Lio/github/libxposed/service/HookedProcess$1;
.super Ljava/lang/Object;
.source "HookedProcess.java"
.implements Landroid/os/Parcelable$Creator;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/HookedProcess;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator<",
        "Lio/github/libxposed/service/HookedProcess;",
        ">;"
    }
.end annotation
.method constructor <init>()V
    .registers 1
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method public createFromParcel(Landroid/os/Parcel;)Lio/github/libxposed/service/HookedProcess;
    .registers 2
    .line 34
    new-instance p0, Lio/github/libxposed/service/HookedProcess;
    invoke-direct {p0}, Lio/github/libxposed/service/HookedProcess;-><init>()V
    .line 35
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/HookedProcess;->readFromParcel(Landroid/os/Parcel;)V
    return-object p0
.end method
.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .registers 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation
    .line 31
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/HookedProcess$1;->createFromParcel(Landroid/os/Parcel;)Lio/github/libxposed/service/HookedProcess;
    move-result-object p0
    return-object p0
.end method
.method public newArray(I)[Lio/github/libxposed/service/HookedProcess;
    .registers 2
    .line 40
    new-array p0, p1, [Lio/github/libxposed/service/HookedProcess;
    return-object p0
.end method
.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .registers 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation
    .line 31
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/HookedProcess$1;->newArray(I)[Lio/github/libxposed/service/HookedProcess;
    move-result-object p0
    return-object p0
.end method
