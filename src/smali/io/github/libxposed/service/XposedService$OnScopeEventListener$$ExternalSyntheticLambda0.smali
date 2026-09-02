.class public final synthetic Lio/github/libxposed/service/XposedService$OnScopeEventListener$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"
.implements Ljava/util/function/Function;
.field public final synthetic f$0:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
.method public synthetic constructor <init>(Lio/github/libxposed/service/XposedService$OnScopeEventListener;)V
    .registers 2
    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$$ExternalSyntheticLambda0;->f$0:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    return-void
.end method
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2
    .line 0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$$ExternalSyntheticLambda0;->f$0:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    check-cast p1, Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    invoke-static {p0, p1}, Lio/github/libxposed/service/XposedService$OnScopeEventListener;->$r8$lambda$_7Kp3wDuWmiP67V4qkcgZ3pWCbw(Lio/github/libxposed/service/XposedService$OnScopeEventListener;Lio/github/libxposed/service/XposedService$OnScopeEventListener;)Lio/github/libxposed/service/IXposedScopeCallback;
    move-result-object p0
    return-object p0
.end method
