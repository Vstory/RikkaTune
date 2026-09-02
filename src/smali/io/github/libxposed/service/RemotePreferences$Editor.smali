.class public Lio/github/libxposed/service/RemotePreferences$Editor;
.super Ljava/lang/Object;
.source "RemotePreferences.java"
.implements Landroid/content/SharedPreferences$Editor;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/RemotePreferences;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "Editor"
.end annotation
.field private mClear:Z
.field private final mDelete:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field
.field private final mPut:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field
.field final synthetic this$0:Lio/github/libxposed/service/RemotePreferences;
.method public static synthetic $r8$lambda$-3hADX60NAwN2-TvVzEHv0K-ti4(Lio/github/libxposed/service/RemotePreferences$Editor;Landroid/os/Bundle;)V
    .registers 2
    invoke-direct {p0, p1}, Lio/github/libxposed/service/RemotePreferences$Editor;->lambda$apply$0(Landroid/os/Bundle;)V
    return-void
.end method
.method public static synthetic $r8$lambda$dpA5H12ZD2CfzvgwpDUcgW3slU8(Ljava/util/HashMap;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2
    invoke-virtual {p0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object p0
    return-object p0
.end method
.method public constructor <init>(Lio/github/libxposed/service/RemotePreferences;)V
    .registers 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation
    .line 119
    iput-object p1, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    .line 121
    new-instance p1, Ljava/util/HashSet;
    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V
    iput-object p1, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    .line 122
    new-instance p1, Ljava/util/HashMap;
    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V
    iput-object p1, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    const/4 p1, 0x0
    .line 123
    iput-boolean p1, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mClear:Z
    return-void
.end method
.method private buildCommitBundle()Landroid/os/Bundle;
    .registers 4
    .line 211
    iget-boolean v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mClear:Z
    if-nez v0, :cond_16
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-virtual {v0}, Ljava/util/HashSet;->isEmpty()Z
    move-result v0
    if-eqz v0, :cond_16
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-virtual {v0}, Ljava/util/HashMap;->isEmpty()Z
    move-result v0
    if-eqz v0, :cond_16
    const/4 p0, 0x0
    return-object p0
    .line 212
    :cond_16
    new-instance v0, Landroid/os/Bundle;
    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V
    .line 213
    const-string v1, "clear"
    iget-boolean v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mClear:Z
    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V
    .line 214
    new-instance v1, Ljava/util/HashSet;
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V
    const-string v2, "delete"
    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V
    .line 215
    new-instance v1, Ljava/util/HashMap;
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-direct {v1, p0}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V
    const-string p0, "put"
    invoke-virtual {v0, p0, v1}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V
    return-object v0
.end method
.method private doCommit(Landroid/os/Bundle;)Z
    .registers 3
    if-eqz p1, :cond_20
    .line 222
    :try_start_2
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-static {v0}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$fgetmService(Lio/github/libxposed/service/RemotePreferences;)Lio/github/libxposed/service/XposedService;
    move-result-object v0
    invoke-virtual {v0}, Lio/github/libxposed/service/XposedService;->asInterface()Lio/github/libxposed/service/IXposedService;
    move-result-object v0
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-static {p0}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$fgetmGroup(Lio/github/libxposed/service/RemotePreferences;)Ljava/lang/String;
    move-result-object p0
    invoke-interface {v0, p0, p1}, Lio/github/libxposed/service/IXposedService;->updateRemotePreferences(Ljava/lang/String;Landroid/os/Bundle;)V
    :try_end_15
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_15} :catch_16
    goto :goto_20
    :catch_16
    move-exception p0
    .line 224
    const-string p1, "RemotePreferences"
    const-string v0, "Failed to commit changes to framework"
    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    const/4 p0, 0x0
    return p0
    :cond_20
    :goto_20
    const/4 p0, 0x1
    return p0
.end method
.method private doUpdate()V
    .registers 6
    .line 184
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    monitor-enter v0
    .line 185
    :try_start_3
    new-instance v1, Ljava/util/HashMap;
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-static {v2}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$fgetmMap(Lio/github/libxposed/service/RemotePreferences;)Ljava/util/Map;
    move-result-object v2
    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V
    .line 186
    iget-boolean v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mClear:Z
    if-eqz v2, :cond_15
    invoke-virtual {v1}, Ljava/util/HashMap;->clear()V
    .line 187
    :cond_15
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;
    new-instance v3, Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda1;
    invoke-direct {v3, v1}, Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda1;-><init>(Ljava/util/HashMap;)V
    invoke-virtual {v2, v3}, Ljava/util/HashSet;->forEach(Ljava/util/function/Consumer;)V
    .line 188
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-virtual {v1, v2}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V
    .line 189
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;
    move-result-object v1
    invoke-static {v2, v1}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$fputmMap(Lio/github/libxposed/service/RemotePreferences;Ljava/util/Map;)V
    .line 190
    monitor-exit v0
    :try_end_31
    .catchall {:try_start_3 .. :try_end_31} :catchall_9e
    .line 194
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-static {v0}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$fgetmListeners(Lio/github/libxposed/service/RemotePreferences;)Ljava/util/Map;
    move-result-object v1
    monitor-enter v1
    .line 195
    :try_start_38
    new-instance v0, Ljava/util/ArrayList;
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-static {v2}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$fgetmListeners(Lio/github/libxposed/service/RemotePreferences;)Ljava/util/Map;
    move-result-object v2
    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;
    move-result-object v2
    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    .line 196
    monitor-exit v1
    :try_end_48
    .catchall {:try_start_38 .. :try_end_48} :catchall_9b
    .line 197
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :cond_4c
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :cond_9a
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;
    .line 198
    iget-boolean v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mClear:Z
    if-eqz v2, :cond_66
    sget-boolean v2, Lio/github/libxposed/service/RemotePreferences;->shouldNotifyCleared:Z
    if-eqz v2, :cond_66
    .line 199
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    const/4 v3, 0x0
    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;->onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .line 201
    :cond_66
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-virtual {v2}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;
    move-result-object v2
    :goto_6c
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :cond_7e
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Ljava/lang/String;
    .line 202
    iget-object v4, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-interface {v1, v4, v3}, Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;->onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    goto :goto_6c
    .line 204
    :cond_7e
    iget-object v2, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-virtual {v2}, Ljava/util/HashMap;->keySet()Ljava/util/Set;
    move-result-object v2
    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v2
    :goto_88
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :cond_4c
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Ljava/lang/String;
    .line 205
    iget-object v4, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->this$0:Lio/github/libxposed/service/RemotePreferences;
    invoke-interface {v1, v4, v3}, Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;->onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    goto :goto_88
    :cond_9a
    return-void
    :catchall_9b
    move-exception p0
    .line 196
    :try_start_9c
    monitor-exit v1
    :try_end_9d
    .catchall {:try_start_9c .. :try_end_9d} :catchall_9b
    throw p0
    :catchall_9e
    move-exception p0
    .line 190
    :try_start_9f
    monitor-exit v0
    :try_end_a0
    .catchall {:try_start_9f .. :try_end_a0} :catchall_9e
    throw p0
.end method
.method private synthetic lambda$apply$0(Landroid/os/Bundle;)V
    .registers 2
    .line 244
    invoke-direct {p0, p1}, Lio/github/libxposed/service/RemotePreferences$Editor;->doCommit(Landroid/os/Bundle;)Z
    return-void
.end method
.method private put(Ljava/lang/String;Ljava/lang/Object;)V
    .registers 4
    .line 126
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-virtual {v0, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z
    .line 127
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-virtual {p0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    return-void
.end method
.method public apply()V
    .registers 4
    .line 241
    invoke-direct {p0}, Lio/github/libxposed/service/RemotePreferences$Editor;->buildCommitBundle()Landroid/os/Bundle;
    move-result-object v0
    if-nez v0, :cond_7
    return-void
    .line 243
    :cond_7
    invoke-direct {p0}, Lio/github/libxposed/service/RemotePreferences$Editor;->doUpdate()V
    .line 244
    invoke-static {}, Lio/github/libxposed/service/RemotePreferences;->-$$Nest$sfgetEXECUTOR()Ljava/util/concurrent/ExecutorService;
    move-result-object v1
    new-instance v2, Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda0;
    invoke-direct {v2, p0, v0}, Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda0;-><init>(Lio/github/libxposed/service/RemotePreferences$Editor;Landroid/os/Bundle;)V
    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    return-void
.end method
.method public clear()Landroid/content/SharedPreferences$Editor;
    .registers 2
    const/4 v0, 0x1
    .line 177
    iput-boolean v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mClear:Z
    .line 178
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-virtual {v0}, Ljava/util/HashSet;->clear()V
    .line 179
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V
    return-object p0
.end method
.method public commit()Z
    .registers 2
    .line 233
    invoke-direct {p0}, Lio/github/libxposed/service/RemotePreferences$Editor;->buildCommitBundle()Landroid/os/Bundle;
    move-result-object v0
    if-nez v0, :cond_8
    const/4 p0, 0x1
    return p0
    .line 235
    :cond_8
    invoke-direct {p0}, Lio/github/libxposed/service/RemotePreferences$Editor;->doUpdate()V
    .line 236
    invoke-direct {p0, v0}, Lio/github/libxposed/service/RemotePreferences$Editor;->doCommit(Landroid/os/Bundle;)Z
    move-result p0
    return p0
.end method
.method public putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    .registers 3
    .line 164
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;
    move-result-object p2
    invoke-direct {p0, p1, p2}, Lio/github/libxposed/service/RemotePreferences$Editor;->put(Ljava/lang/String;Ljava/lang/Object;)V
    return-object p0
.end method
.method public putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    .registers 3
    .line 158
    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;
    move-result-object p2
    invoke-direct {p0, p1, p2}, Lio/github/libxposed/service/RemotePreferences$Editor;->put(Ljava/lang/String;Ljava/lang/Object;)V
    return-object p0
.end method
.method public putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    .registers 3
    .line 146
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object p2
    invoke-direct {p0, p1, p2}, Lio/github/libxposed/service/RemotePreferences$Editor;->put(Ljava/lang/String;Ljava/lang/Object;)V
    return-object p0
.end method
.method public putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;
    .registers 4
    .line 152
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;
    move-result-object p2
    invoke-direct {p0, p1, p2}, Lio/github/libxposed/service/RemotePreferences$Editor;->put(Ljava/lang/String;Ljava/lang/Object;)V
    return-object p0
.end method
.method public putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    .registers 3
    if-nez p2, :cond_6
    .line 132
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/RemotePreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    return-object p0
    .line 133
    :cond_6
    invoke-direct {p0, p1, p2}, Lio/github/libxposed/service/RemotePreferences$Editor;->put(Ljava/lang/String;Ljava/lang/Object;)V
    return-object p0
.end method
.method public putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Landroid/content/SharedPreferences$Editor;"
        }
    .end annotation
    if-nez p2, :cond_6
    .line 139
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/RemotePreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    return-object p0
    .line 140
    :cond_6
    invoke-direct {p0, p1, p2}, Lio/github/libxposed/service/RemotePreferences$Editor;->put(Ljava/lang/String;Ljava/lang/Object;)V
    return-object p0
.end method
.method public remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    .registers 3
    .line 170
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mDelete:Ljava/util/HashSet;
    invoke-virtual {v0, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    .line 171
    iget-object v0, p0, Lio/github/libxposed/service/RemotePreferences$Editor;->mPut:Ljava/util/HashMap;
    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    return-object p0
.end method
