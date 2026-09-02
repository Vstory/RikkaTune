.class public final synthetic Lio/github/libxposed/service/XposedService$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"
.implements Ljava/util/function/Function;
.field public final synthetic f$0:Lio/github/libxposed/service/XposedService;
.method public synthetic constructor <init>(Lio/github/libxposed/service/XposedService;)V
    .registers 2
    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lio/github/libxposed/service/XposedService$$ExternalSyntheticLambda0;->f$0:Lio/github/libxposed/service/XposedService;
    return-void
.end method
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2
    .line 0
    iget-object p0, p0, Lio/github/libxposed/service/XposedService$$ExternalSyntheticLambda0;->f$0:Lio/github/libxposed/service/XposedService;
    check-cast p1, Ljava/lang/String;
    invoke-static {p0, p1}, Lio/github/libxposed/service/XposedService;->$r8$lambda$T61Hp6givnZnE4Lb5F5l4UAfaGw(Lio/github/libxposed/service/XposedService;Ljava/lang/String;)Lio/github/libxposed/service/RemotePreferences;
    move-result-object p0
    return-object p0
.end method
