.class public interface abstract Lio/github/libxposed/service/XposedService$OnScopeEventListener;
.super Ljava/lang/Object;
.source "XposedService.java"
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/XposedService;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "OnScopeEventListener"
.end annotation
.method public static synthetic $r8$lambda$_7Kp3wDuWmiP67V4qkcgZ3pWCbw(Lio/github/libxposed/service/XposedService$OnScopeEventListener;Lio/github/libxposed/service/XposedService$OnScopeEventListener;)Lio/github/libxposed/service/IXposedScopeCallback;
    .registers 2
    invoke-direct {p0, p1}, Lio/github/libxposed/service/XposedService$OnScopeEventListener;->lambda$asInterface$0(Lio/github/libxposed/service/XposedService$OnScopeEventListener;)Lio/github/libxposed/service/IXposedScopeCallback;
    move-result-object p0
    return-object p0
.end method
.method public static bridge synthetic -$$Nest$masInterface(Lio/github/libxposed/service/XposedService$OnScopeEventListener;)Lio/github/libxposed/service/IXposedScopeCallback;
    .registers 1
    invoke-direct {p0}, Lio/github/libxposed/service/XposedService$OnScopeEventListener;->asInterface()Lio/github/libxposed/service/IXposedScopeCallback;
    move-result-object p0
    return-object p0
.end method
.method private asInterface()Lio/github/libxposed/service/IXposedScopeCallback;
    .registers 3
    .line 88
    invoke-static {}, Lio/github/libxposed/service/XposedService;->-$$Nest$sfgetscopeCallbacks()Ljava/util/Map;
    move-result-object v0
    new-instance v1, Lio/github/libxposed/service/XposedService$OnScopeEventListener$$ExternalSyntheticLambda0;
    invoke-direct {v1, p0}, Lio/github/libxposed/service/XposedService$OnScopeEventListener$$ExternalSyntheticLambda0;-><init>(Lio/github/libxposed/service/XposedService$OnScopeEventListener;)V
    invoke-interface {v0, p0, v1}, Ljava/util/Map;->computeIfAbsent(Ljava/lang/Object;Ljava/util/function/Function;)Ljava/lang/Object;
    move-result-object p0
    check-cast p0, Lio/github/libxposed/service/IXposedScopeCallback;
    return-object p0
.end method
.method private synthetic lambda$asInterface$0(Lio/github/libxposed/service/XposedService$OnScopeEventListener;)Lio/github/libxposed/service/IXposedScopeCallback;
    .registers 3
    .line 88
    new-instance v0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;
    invoke-direct {v0, p0, p1}, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;-><init>(Lio/github/libxposed/service/XposedService$OnScopeEventListener;Lio/github/libxposed/service/XposedService$OnScopeEventListener;)V
    return-object v0
.end method
.method public onScopeRequestApproved(Ljava/util/List;)V
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
    return-void
.end method
.method public onScopeRequestFailed(Ljava/lang/String;)V
    .registers 2
    return-void
.end method
