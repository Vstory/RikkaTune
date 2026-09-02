.class public final Lio/github/libxposed/service/HotReloadResult;
.super Lcom/android/tools/r8/RecordTag;
.source "HotReloadResult.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/HotReloadResult$Status;
    }
.end annotation


# instance fields
.field private final message:Ljava/lang/String;

.field private final status:Lio/github/libxposed/service/HotReloadResult$Status;


# direct methods
.method private synthetic $record$equals(Ljava/lang/Object;)Z
    .registers 4

    instance-of v0, p1, Lio/github/libxposed/service/HotReloadResult;

    if-eqz v0, :cond_1c

    check-cast p1, Lio/github/libxposed/service/HotReloadResult;

    iget-object v0, p0, Lio/github/libxposed/service/HotReloadResult;->status:Lio/github/libxposed/service/HotReloadResult$Status;

    iget-object v1, p1, Lio/github/libxposed/service/HotReloadResult;->status:Lio/github/libxposed/service/HotReloadResult$Status;

    invoke-static {v0, v1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    iget-object p0, p0, Lio/github/libxposed/service/HotReloadResult;->message:Ljava/lang/String;

    iget-object p1, p1, Lio/github/libxposed/service/HotReloadResult;->message:Ljava/lang/String;

    invoke-static {p0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1c

    const/4 p0, 0x1

    return p0

    :cond_1c
    const/4 p0, 0x0

    return p0
.end method

.method private synthetic $record$getFieldsAsObjects()[Ljava/lang/Object;
    .registers 2

    iget-object v0, p0, Lio/github/libxposed/service/HotReloadResult;->status:Lio/github/libxposed/service/HotReloadResult$Status;

    iget-object p0, p0, Lio/github/libxposed/service/HotReloadResult;->message:Ljava/lang/String;

    filled-new-array {v0, p0}, [Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>(Lio/github/libxposed/service/HotReloadResult$Status;Ljava/lang/String;)V
    .registers 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "status",
            "message"
        }
    .end annotation

    .line 17
    invoke-direct {p0}, Lcom/android/tools/r8/RecordTag;-><init>()V

    iput-object p1, p0, Lio/github/libxposed/service/HotReloadResult;->status:Lio/github/libxposed/service/HotReloadResult$Status;

    iput-object p2, p0, Lio/github/libxposed/service/HotReloadResult;->message:Ljava/lang/String;

    return-void
.end method

.method static from(ILjava/lang/String;)Lio/github/libxposed/service/HotReloadResult;
    .registers 4

    if-eqz p0, :cond_2f

    const/4 v0, 0x1

    if-eq p0, v0, :cond_2c

    const/4 v0, 0x2

    if-eq p0, v0, :cond_29

    const/4 v0, 0x3

    if-eq p0, v0, :cond_26

    const/4 v0, 0x4

    if-ne p0, v0, :cond_11

    .line 64
    sget-object p0, Lio/github/libxposed/service/HotReloadResult$Status;->PROCESS_DIED:Lio/github/libxposed/service/HotReloadResult$Status;

    goto :goto_31

    .line 65
    :cond_11
    new-instance p1, Lio/github/libxposed/service/XposedService$ServiceException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Invalid hot reload status code: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, p0}, Lio/github/libxposed/service/XposedService$ServiceException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 63
    :cond_26
    sget-object p0, Lio/github/libxposed/service/HotReloadResult$Status;->IN_PROGRESS:Lio/github/libxposed/service/HotReloadResult$Status;

    goto :goto_31

    .line 62
    :cond_29
    sget-object p0, Lio/github/libxposed/service/HotReloadResult$Status;->UNSUPPORTED:Lio/github/libxposed/service/HotReloadResult$Status;

    goto :goto_31

    .line 61
    :cond_2c
    sget-object p0, Lio/github/libxposed/service/HotReloadResult$Status;->FAILED:Lio/github/libxposed/service/HotReloadResult$Status;

    goto :goto_31

    .line 60
    :cond_2f
    sget-object p0, Lio/github/libxposed/service/HotReloadResult$Status;->SUCCEEDED:Lio/github/libxposed/service/HotReloadResult$Status;

    .line 67
    :goto_31
    new-instance v0, Lio/github/libxposed/service/HotReloadResult;

    invoke-direct {v0, p0, p1}, Lio/github/libxposed/service/HotReloadResult;-><init>(Lio/github/libxposed/service/HotReloadResult$Status;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .registers 2

    .line 16
    invoke-direct {p0, p1}, Lio/github/libxposed/service/HotReloadResult;->$record$equals(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public final hashCode()I
    .registers 2

    .line 16
    iget-object v0, p0, Lio/github/libxposed/service/HotReloadResult;->status:Lio/github/libxposed/service/HotReloadResult$Status;

    iget-object p0, p0, Lio/github/libxposed/service/HotReloadResult;->message:Ljava/lang/String;

    invoke-static {v0, p0}, Landroidx/core/provider/FontRequestWorker$$ExternalSyntheticBackport0;->m(Ljava/lang/Object;Ljava/lang/Object;)I

    move-result p0

    return p0
.end method

.method public message()Ljava/lang/String;
    .registers 1

    .line 16
    iget-object p0, p0, Lio/github/libxposed/service/HotReloadResult;->message:Ljava/lang/String;

    return-object p0
.end method

.method public status()Lio/github/libxposed/service/HotReloadResult$Status;
    .registers 1

    .line 16
    iget-object p0, p0, Lio/github/libxposed/service/HotReloadResult;->status:Lio/github/libxposed/service/HotReloadResult$Status;

    return-object p0
.end method

.method public final toString()Ljava/lang/String;
    .registers 3

    .line 16
    invoke-direct {p0}, Lio/github/libxposed/service/HotReloadResult;->$record$getFieldsAsObjects()[Ljava/lang/Object;

    move-result-object p0

    const-class v0, Lio/github/libxposed/service/HotReloadResult;

    const-string v1, "status;message"

    invoke-static {p0, v0, v1}, Landroidx/core/provider/FontRequestWorker$$ExternalSyntheticBackport0;->m([Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
