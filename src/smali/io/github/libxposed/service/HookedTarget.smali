.class public final Lio/github/libxposed/service/HookedTarget;
.super Ljava/lang/Object;
.source "HookedTarget.java"
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/HookedTarget$State;
    }
.end annotation
.field private final mLoadedVersionCode:J
.field private final mPid:I
.field private final mProcessName:Ljava/lang/String;
.field private final mState:Lio/github/libxposed/service/HookedTarget$State;
.field final mTargetId:J
.field private final mUid:I
.method constructor <init>(JIILjava/lang/String;Lio/github/libxposed/service/HookedTarget$State;J)V
    .registers 9
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    .line 51
    iput-wide p1, p0, Lio/github/libxposed/service/HookedTarget;->mTargetId:J
    .line 52
    iput p3, p0, Lio/github/libxposed/service/HookedTarget;->mUid:I
    .line 53
    iput p4, p0, Lio/github/libxposed/service/HookedTarget;->mPid:I
    .line 54
    invoke-static {p5}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Ljava/lang/String;
    iput-object p1, p0, Lio/github/libxposed/service/HookedTarget;->mProcessName:Ljava/lang/String;
    .line 55
    invoke-static {p6}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Lio/github/libxposed/service/HookedTarget$State;
    iput-object p1, p0, Lio/github/libxposed/service/HookedTarget;->mState:Lio/github/libxposed/service/HookedTarget$State;
    .line 56
    iput-wide p7, p0, Lio/github/libxposed/service/HookedTarget;->mLoadedVersionCode:J
    return-void
.end method
.method public getLoadedVersionCode()J
    .registers 3
    .line 96
    iget-wide v0, p0, Lio/github/libxposed/service/HookedTarget;->mLoadedVersionCode:J
    return-wide v0
.end method
.method public getPid()I
    .registers 1
    .line 71
    iget p0, p0, Lio/github/libxposed/service/HookedTarget;->mPid:I
    return p0
.end method
.method public getProcessName()Ljava/lang/String;
    .registers 1
    .line 79
    iget-object p0, p0, Lio/github/libxposed/service/HookedTarget;->mProcessName:Ljava/lang/String;
    return-object p0
.end method
.method public getState()Lio/github/libxposed/service/HookedTarget$State;
    .registers 1
    .line 87
    iget-object p0, p0, Lio/github/libxposed/service/HookedTarget;->mState:Lio/github/libxposed/service/HookedTarget$State;
    return-object p0
.end method
.method public getUid()I
    .registers 1
    .line 63
    iget p0, p0, Lio/github/libxposed/service/HookedTarget;->mUid:I
    return p0
.end method
