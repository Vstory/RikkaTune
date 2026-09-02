.class public Lio/github/libxposed/service/HookedProcess;
.super Ljava/lang/Object;
.source "HookedProcess.java"
.implements Landroid/os/Parcelable;
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lio/github/libxposed/service/HookedProcess;",
            ">;"
        }
    .end annotation
.end field
.field public static final TARGET_STATE_FAILED:I = 0x3
.field public static final TARGET_STATE_RELOADING:I = 0x2
.field public static final TARGET_STATE_STALE:I = 0x1
.field public static final TARGET_STATE_UP_TO_DATE:I
.field public loadedVersionCode:J
.field public pid:I
.field public processName:Ljava/lang/String;
.field public state:I
.field public targetId:J
.field public uid:I
.method static constructor <clinit>()V
    .registers 1
    .line 31
    new-instance v0, Lio/github/libxposed/service/HookedProcess$1;
    invoke-direct {v0}, Lio/github/libxposed/service/HookedProcess$1;-><init>()V
    sput-object v0, Lio/github/libxposed/service/HookedProcess;->CREATOR:Landroid/os/Parcelable$Creator;
    return-void
.end method
.method public constructor <init>()V
    .registers 4
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    const-wide/16 v0, 0x0
    .line 17
    iput-wide v0, p0, Lio/github/libxposed/service/HookedProcess;->targetId:J
    const/4 v2, 0x0
    .line 19
    iput v2, p0, Lio/github/libxposed/service/HookedProcess;->uid:I
    .line 21
    iput v2, p0, Lio/github/libxposed/service/HookedProcess;->pid:I
    .line 25
    iput v2, p0, Lio/github/libxposed/service/HookedProcess;->state:I
    .line 30
    iput-wide v0, p0, Lio/github/libxposed/service/HookedProcess;->loadedVersionCode:J
    return-void
.end method
.method public describeContents()I
    .registers 1
    const/4 p0, 0x0
    return p0
.end method
.method public final readFromParcel(Landroid/os/Parcel;)V
    .registers 9
    .line 60
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v0
    .line 61
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I
    move-result v1
    const/4 v2, 0x4
    .line 63
    const-string v3, "Overflow in the size of parcelable"
    const v4, 0x7fffffff
    if-lt v1, v2, :cond_ab
    .line 64
    :try_start_10
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v2
    :try_end_14
    .catchall {:try_start_10 .. :try_end_14} :catchall_a9
    sub-int/2addr v2, v0
    if-lt v2, v1, :cond_25
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_1f
    :goto_1a
    add-int/2addr v0, v1
    .line 80
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->setDataPosition(I)V
    return-void
    .line 78
    :cond_1f
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    .line 65
    :cond_25
    :try_start_25
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J
    move-result-wide v5
    iput-wide v5, p0, Lio/github/libxposed/service/HookedProcess;->targetId:J
    .line 66
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v2
    :try_end_2f
    .catchall {:try_start_25 .. :try_end_2f} :catchall_a9
    sub-int/2addr v2, v0
    if-lt v2, v1, :cond_3c
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_36
    goto :goto_1a
    .line 78
    :cond_36
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    .line 67
    :cond_3c
    :try_start_3c
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I
    move-result v2
    iput v2, p0, Lio/github/libxposed/service/HookedProcess;->uid:I
    .line 68
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v2
    :try_end_46
    .catchall {:try_start_3c .. :try_end_46} :catchall_a9
    sub-int/2addr v2, v0
    if-lt v2, v1, :cond_53
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_4d
    goto :goto_1a
    .line 78
    :cond_4d
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    .line 69
    :cond_53
    :try_start_53
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I
    move-result v2
    iput v2, p0, Lio/github/libxposed/service/HookedProcess;->pid:I
    .line 70
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v2
    :try_end_5d
    .catchall {:try_start_53 .. :try_end_5d} :catchall_a9
    sub-int/2addr v2, v0
    if-lt v2, v1, :cond_6a
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_64
    goto :goto_1a
    .line 78
    :cond_64
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    .line 71
    :cond_6a
    :try_start_6a
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    move-result-object v2
    iput-object v2, p0, Lio/github/libxposed/service/HookedProcess;->processName:Ljava/lang/String;
    .line 72
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v2
    :try_end_74
    .catchall {:try_start_6a .. :try_end_74} :catchall_a9
    sub-int/2addr v2, v0
    if-lt v2, v1, :cond_81
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_7b
    goto :goto_1a
    .line 78
    :cond_7b
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    .line 73
    :cond_81
    :try_start_81
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I
    move-result v2
    iput v2, p0, Lio/github/libxposed/service/HookedProcess;->state:I
    .line 74
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result v2
    :try_end_8b
    .catchall {:try_start_81 .. :try_end_8b} :catchall_a9
    sub-int/2addr v2, v0
    if-lt v2, v1, :cond_98
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_92
    goto :goto_1a
    .line 78
    :cond_92
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    .line 75
    :cond_98
    :try_start_98
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J
    move-result-wide v5
    iput-wide v5, p0, Lio/github/libxposed/service/HookedProcess;->loadedVersionCode:J
    :try_end_9e
    .catchall {:try_start_98 .. :try_end_9e} :catchall_a9
    sub-int/2addr v4, v1
    if-gt v0, v4, :cond_a3
    goto/16 :goto_1a
    .line 78
    :cond_a3
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    :catchall_a9
    move-exception p0
    goto :goto_b3
    .line 63
    :cond_ab
    :try_start_ab
    new-instance p0, Landroid/os/BadParcelableException;
    const-string v2, "Parcelable too small"
    invoke-direct {p0, v2}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    :try_end_b3
    .catchall {:try_start_ab .. :try_end_b3} :catchall_a9
    :goto_b3
    sub-int/2addr v4, v1
    if-le v0, v4, :cond_bc
    .line 78
    new-instance p0, Landroid/os/BadParcelableException;
    invoke-direct {p0, v3}, Landroid/os/BadParcelableException;-><init>(Ljava/lang/String;)V
    throw p0
    :cond_bc
    add-int/2addr v0, v1
    .line 80
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->setDataPosition(I)V
    .line 81
    throw p0
.end method
.method public final writeToParcel(Landroid/os/Parcel;I)V
    .registers 5
    .line 45
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result p2
    const/4 v0, 0x0
    .line 46
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V
    .line 47
    iget-wide v0, p0, Lio/github/libxposed/service/HookedProcess;->targetId:J
    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V
    .line 48
    iget v0, p0, Lio/github/libxposed/service/HookedProcess;->uid:I
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V
    .line 49
    iget v0, p0, Lio/github/libxposed/service/HookedProcess;->pid:I
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V
    .line 50
    iget-object v0, p0, Lio/github/libxposed/service/HookedProcess;->processName:Ljava/lang/String;
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V
    .line 51
    iget v0, p0, Lio/github/libxposed/service/HookedProcess;->state:I
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V
    .line 52
    iget-wide v0, p0, Lio/github/libxposed/service/HookedProcess;->loadedVersionCode:J
    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V
    .line 53
    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I
    move-result p0
    .line 54
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->setDataPosition(I)V
    sub-int p2, p0, p2
    .line 55
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V
    .line 56
    invoke-virtual {p1, p0}, Landroid/os/Parcel;->setDataPosition(I)V
    return-void
.end method
