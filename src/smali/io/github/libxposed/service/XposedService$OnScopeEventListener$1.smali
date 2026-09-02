.class Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;
.super Lio/github/libxposed/service/IXposedScopeCallback$Stub;
.source "XposedService.java"
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/github/libxposed/service/XposedService$OnScopeEventListener;->asInterface()Lio/github/libxposed/service/IXposedScopeCallback;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation
.field final synthetic this$0:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
.field final synthetic val$listener:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
.method constructor <init>(Lio/github/libxposed/service/XposedService$OnScopeEventListener;Lio/github/libxposed/service/XposedService$OnScopeEventListener;)V
    .registers 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            null,
            null
        }
    .end annotation
    .line 88
    iput-object p1, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;->this$0:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    iput-object p2, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;->val$listener:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    invoke-direct {p0}, Lio/github/libxposed/service/IXposedScopeCallback$Stub;-><init>()V
    return-void
.end method
.method public onScopeRequestApproved(Ljava/util/List;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
    .line 91
    iget-object v0, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;->val$listener:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    invoke-interface {v0, p1}, Lio/github/libxposed/service/XposedService$OnScopeEventListener;->onScopeRequestApproved(Ljava/util/List;)V
    .line 92
    invoke-static {}, Lio/github/libxposed/service/XposedService;->-$$Nest$sfgetscopeCallbacks()Ljava/util/Map;
    move-result-object p1
    iget-object p0, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;->val$listener:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    invoke-interface {p1, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    return-void
.end method
.method public onScopeRequestFailed(Ljava/lang/String;)V
    .registers 3
    .line 97
    iget-object v0, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;->val$listener:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    invoke-interface {v0, p1}, Lio/github/libxposed/service/XposedService$OnScopeEventListener;->onScopeRequestFailed(Ljava/lang/String;)V
    .line 98
    invoke-static {}, Lio/github/libxposed/service/XposedService;->-$$Nest$sfgetscopeCallbacks()Ljava/util/Map;
    move-result-object p1
    iget-object p0, p0, Lio/github/libxposed/service/XposedService$OnScopeEventListener$1;->val$listener:Lio/github/libxposed/service/XposedService$OnScopeEventListener;
    invoke-interface {p1, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    return-void
.end method
