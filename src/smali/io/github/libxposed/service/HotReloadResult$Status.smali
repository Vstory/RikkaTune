.class public final enum Lio/github/libxposed/service/HotReloadResult$Status;
.super Ljava/lang/Enum;
.source "HotReloadResult.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/HotReloadResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Status"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/github/libxposed/service/HotReloadResult$Status;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/github/libxposed/service/HotReloadResult$Status;

.field public static final enum FAILED:Lio/github/libxposed/service/HotReloadResult$Status;

.field public static final enum IN_PROGRESS:Lio/github/libxposed/service/HotReloadResult$Status;

.field public static final enum PROCESS_DIED:Lio/github/libxposed/service/HotReloadResult$Status;

.field public static final enum SUCCEEDED:Lio/github/libxposed/service/HotReloadResult$Status;

.field public static final enum UNSUPPORTED:Lio/github/libxposed/service/HotReloadResult$Status;


# direct methods
.method private static synthetic $values()[Lio/github/libxposed/service/HotReloadResult$Status;
    .registers 5

    .line 21
    sget-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->SUCCEEDED:Lio/github/libxposed/service/HotReloadResult$Status;

    sget-object v1, Lio/github/libxposed/service/HotReloadResult$Status;->FAILED:Lio/github/libxposed/service/HotReloadResult$Status;

    sget-object v2, Lio/github/libxposed/service/HotReloadResult$Status;->UNSUPPORTED:Lio/github/libxposed/service/HotReloadResult$Status;

    sget-object v3, Lio/github/libxposed/service/HotReloadResult$Status;->IN_PROGRESS:Lio/github/libxposed/service/HotReloadResult$Status;

    sget-object v4, Lio/github/libxposed/service/HotReloadResult$Status;->PROCESS_DIED:Lio/github/libxposed/service/HotReloadResult$Status;

    filled-new-array {v0, v1, v2, v3, v4}, [Lio/github/libxposed/service/HotReloadResult$Status;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .registers 3

    .line 25
    new-instance v0, Lio/github/libxposed/service/HotReloadResult$Status;

    const-string v1, "SUCCEEDED"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HotReloadResult$Status;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->SUCCEEDED:Lio/github/libxposed/service/HotReloadResult$Status;

    .line 35
    new-instance v0, Lio/github/libxposed/service/HotReloadResult$Status;

    const-string v1, "FAILED"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HotReloadResult$Status;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->FAILED:Lio/github/libxposed/service/HotReloadResult$Status;

    .line 45
    new-instance v0, Lio/github/libxposed/service/HotReloadResult$Status;

    const-string v1, "UNSUPPORTED"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HotReloadResult$Status;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->UNSUPPORTED:Lio/github/libxposed/service/HotReloadResult$Status;

    .line 50
    new-instance v0, Lio/github/libxposed/service/HotReloadResult$Status;

    const-string v1, "IN_PROGRESS"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HotReloadResult$Status;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->IN_PROGRESS:Lio/github/libxposed/service/HotReloadResult$Status;

    .line 55
    new-instance v0, Lio/github/libxposed/service/HotReloadResult$Status;

    const-string v1, "PROCESS_DIED"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HotReloadResult$Status;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->PROCESS_DIED:Lio/github/libxposed/service/HotReloadResult$Status;

    .line 21
    invoke-static {}, Lio/github/libxposed/service/HotReloadResult$Status;->$values()[Lio/github/libxposed/service/HotReloadResult$Status;

    move-result-object v0

    sput-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->$VALUES:[Lio/github/libxposed/service/HotReloadResult$Status;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .registers 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000,
            0x1000
        }
        names = {
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 21
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/github/libxposed/service/HotReloadResult$Status;
    .registers 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            null
        }
    .end annotation

    .line 21
    const-class v0, Lio/github/libxposed/service/HotReloadResult$Status;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lio/github/libxposed/service/HotReloadResult$Status;

    return-object p0
.end method

.method public static values()[Lio/github/libxposed/service/HotReloadResult$Status;
    .registers 1

    .line 21
    sget-object v0, Lio/github/libxposed/service/HotReloadResult$Status;->$VALUES:[Lio/github/libxposed/service/HotReloadResult$Status;

    invoke-virtual {v0}, [Lio/github/libxposed/service/HotReloadResult$Status;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/github/libxposed/service/HotReloadResult$Status;

    return-object v0
.end method
