.class public final enum Lio/github/libxposed/service/HookedTarget$State;
.super Ljava/lang/Enum;
.source "HookedTarget.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/HookedTarget;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "State"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/github/libxposed/service/HookedTarget$State;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/github/libxposed/service/HookedTarget$State;

.field public static final enum FAILED:Lio/github/libxposed/service/HookedTarget$State;

.field public static final enum RELOADING:Lio/github/libxposed/service/HookedTarget$State;

.field public static final enum STALE:Lio/github/libxposed/service/HookedTarget$State;

.field public static final enum UP_TO_DATE:Lio/github/libxposed/service/HookedTarget$State;


# direct methods
.method private static synthetic $values()[Lio/github/libxposed/service/HookedTarget$State;
    .registers 4

    .line 19
    sget-object v0, Lio/github/libxposed/service/HookedTarget$State;->UP_TO_DATE:Lio/github/libxposed/service/HookedTarget$State;

    sget-object v1, Lio/github/libxposed/service/HookedTarget$State;->STALE:Lio/github/libxposed/service/HookedTarget$State;

    sget-object v2, Lio/github/libxposed/service/HookedTarget$State;->RELOADING:Lio/github/libxposed/service/HookedTarget$State;

    sget-object v3, Lio/github/libxposed/service/HookedTarget$State;->FAILED:Lio/github/libxposed/service/HookedTarget$State;

    filled-new-array {v0, v1, v2, v3}, [Lio/github/libxposed/service/HookedTarget$State;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .registers 3

    .line 23
    new-instance v0, Lio/github/libxposed/service/HookedTarget$State;

    const-string v1, "UP_TO_DATE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HookedTarget$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HookedTarget$State;->UP_TO_DATE:Lio/github/libxposed/service/HookedTarget$State;

    .line 28
    new-instance v0, Lio/github/libxposed/service/HookedTarget$State;

    const-string v1, "STALE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HookedTarget$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HookedTarget$State;->STALE:Lio/github/libxposed/service/HookedTarget$State;

    .line 33
    new-instance v0, Lio/github/libxposed/service/HookedTarget$State;

    const-string v1, "RELOADING"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HookedTarget$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HookedTarget$State;->RELOADING:Lio/github/libxposed/service/HookedTarget$State;

    .line 39
    new-instance v0, Lio/github/libxposed/service/HookedTarget$State;

    const-string v1, "FAILED"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lio/github/libxposed/service/HookedTarget$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/github/libxposed/service/HookedTarget$State;->FAILED:Lio/github/libxposed/service/HookedTarget$State;

    .line 19
    invoke-static {}, Lio/github/libxposed/service/HookedTarget$State;->$values()[Lio/github/libxposed/service/HookedTarget$State;

    move-result-object v0

    sput-object v0, Lio/github/libxposed/service/HookedTarget$State;->$VALUES:[Lio/github/libxposed/service/HookedTarget$State;

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

    .line 19
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/github/libxposed/service/HookedTarget$State;
    .registers 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            null
        }
    .end annotation

    .line 19
    const-class v0, Lio/github/libxposed/service/HookedTarget$State;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lio/github/libxposed/service/HookedTarget$State;

    return-object p0
.end method

.method public static values()[Lio/github/libxposed/service/HookedTarget$State;
    .registers 1

    .line 19
    sget-object v0, Lio/github/libxposed/service/HookedTarget$State;->$VALUES:[Lio/github/libxposed/service/HookedTarget$State;

    invoke-virtual {v0}, [Lio/github/libxposed/service/HookedTarget$State;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/github/libxposed/service/HookedTarget$State;

    return-object v0
.end method
