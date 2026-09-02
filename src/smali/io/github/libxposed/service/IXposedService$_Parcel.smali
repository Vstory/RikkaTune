.class public Lio/github/libxposed/service/IXposedService$_Parcel;
.super Ljava/lang/Object;
.source "IXposedService.java"
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IXposedService;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "_Parcel"
.end annotation
.method static bridge synthetic -$$Nest$smreadTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;
    .registers 2
    invoke-static {p0, p1}, Lio/github/libxposed/service/IXposedService$_Parcel;->readTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;
    move-result-object p0
    return-object p0
.end method
.method static bridge synthetic -$$Nest$smwriteTypedList(Landroid/os/Parcel;Ljava/util/List;I)V
    .registers 3
    invoke-static {p0, p1, p2}, Lio/github/libxposed/service/IXposedService$_Parcel;->writeTypedList(Landroid/os/Parcel;Ljava/util/List;I)V
    return-void
.end method
.method static bridge synthetic -$$Nest$smwriteTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V
    .registers 3
    invoke-static {p0, p1, p2}, Lio/github/libxposed/service/IXposedService$_Parcel;->writeTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V
    return-void
.end method
.method public constructor <init>()V
    .registers 1
    .line 641
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method private static readTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Landroid/os/Parcel;",
            "Landroid/os/Parcelable$Creator<",
            "TT;>;)TT;"
        }
    .end annotation
    .line 645
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I
    move-result v0
    if-eqz v0, :cond_b
    .line 646
    invoke-interface {p1, p0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    move-result-object p0
    return-object p0
    :cond_b
    const/4 p0, 0x0
    return-object p0
.end method
.method private static writeTypedList(Landroid/os/Parcel;Ljava/util/List;I)V
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T::",
            "Landroid/os/Parcelable;",
            ">(",
            "Landroid/os/Parcel;",
            "Ljava/util/List<",
            "TT;>;I)V"
        }
    .end annotation
    if-nez p1, :cond_7
    const/4 p1, -0x1
    .line 663
    invoke-virtual {p0, p1}, Landroid/os/Parcel;->writeInt(I)V
    return-void
    .line 665
    :cond_7
    invoke-interface {p1}, Ljava/util/List;->size()I
    move-result v0
    .line 667
    invoke-virtual {p0, v0}, Landroid/os/Parcel;->writeInt(I)V
    const/4 v1, 0x0
    :goto_f
    if-ge v1, v0, :cond_1d
    .line 669
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/os/Parcelable;
    invoke-static {p0, v2, p2}, Lio/github/libxposed/service/IXposedService$_Parcel;->writeTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V
    add-int/lit8 v1, v1, 0x1
    goto :goto_f
    :cond_1d
    return-void
.end method
.method private static writeTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T::",
            "Landroid/os/Parcelable;",
            ">(",
            "Landroid/os/Parcel;",
            "TT;I)V"
        }
    .end annotation
    if-eqz p1, :cond_a
    const/4 v0, 0x1
    .line 654
    invoke-virtual {p0, v0}, Landroid/os/Parcel;->writeInt(I)V
    .line 655
    invoke-interface {p1, p0, p2}, Landroid/os/Parcelable;->writeToParcel(Landroid/os/Parcel;I)V
    return-void
    :cond_a
    const/4 p1, 0x0
    .line 657
    invoke-virtual {p0, p1}, Landroid/os/Parcel;->writeInt(I)V
    return-void
.end method
