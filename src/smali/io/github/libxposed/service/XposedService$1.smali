.class Lio/github/libxposed/service/XposedService$1;
.super Lio/github/libxposed/service/IHotReloadCallback$Stub;
.source "XposedService.java"
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/github/libxposed/service/XposedService;->hotReloadModule(Lio/github/libxposed/service/HookedTarget;Landroid/os/Bundle;Lio/github/libxposed/service/XposedService$HotReloadCallback;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation
.field final synthetic this$0:Lio/github/libxposed/service/XposedService;
.field final synthetic val$callback:Lio/github/libxposed/service/XposedService$HotReloadCallback;
.field final synthetic val$target:Lio/github/libxposed/service/HookedTarget;
.method constructor <init>(Lio/github/libxposed/service/XposedService;Lio/github/libxposed/service/XposedService$HotReloadCallback;Lio/github/libxposed/service/HookedTarget;)V
    .registers 4
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            null,
            null,
            null
        }
    .end annotation
    .line 324
    iput-object p1, p0, Lio/github/libxposed/service/XposedService$1;->this$0:Lio/github/libxposed/service/XposedService;
    iput-object p2, p0, Lio/github/libxposed/service/XposedService$1;->val$callback:Lio/github/libxposed/service/XposedService$HotReloadCallback;
    iput-object p3, p0, Lio/github/libxposed/service/XposedService$1;->val$target:Lio/github/libxposed/service/HookedTarget;
    invoke-direct {p0}, Lio/github/libxposed/service/IHotReloadCallback$Stub;-><init>()V
    return-void
.end method
.method public onHotReloadResult(ILjava/lang/String;)V
    .registers 5
    .line 328
    :try_start_0
    iget-object v0, p0, Lio/github/libxposed/service/XposedService$1;->val$callback:Lio/github/libxposed/service/XposedService$HotReloadCallback;
    iget-object v1, p0, Lio/github/libxposed/service/XposedService$1;->val$target:Lio/github/libxposed/service/HookedTarget;
    invoke-static {p1, p2}, Lio/github/libxposed/service/HotReloadResult;->from(ILjava/lang/String;)Lio/github/libxposed/service/HotReloadResult;
    move-result-object p1
    invoke-interface {v0, v1, p1}, Lio/github/libxposed/service/XposedService$HotReloadCallback;->onHotReloadResult(Lio/github/libxposed/service/HookedTarget;Lio/github/libxposed/service/HotReloadResult;)V
    :try_end_b
    .catchall {:try_start_0 .. :try_end_b} :catchall_13
    .line 330
    invoke-static {}, Lio/github/libxposed/service/XposedService;->-$$Nest$sfgethotReloadCallbacks()Ljava/util/Set;
    move-result-object p1
    invoke-interface {p1, p0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    return-void
    :catchall_13
    move-exception p1
    invoke-static {}, Lio/github/libxposed/service/XposedService;->-$$Nest$sfgethotReloadCallbacks()Ljava/util/Set;
    move-result-object p2
    invoke-interface {p2, p0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    .line 331
    throw p1
.end method
