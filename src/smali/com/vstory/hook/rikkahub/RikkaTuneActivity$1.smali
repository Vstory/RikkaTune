.class Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;
.super Ljava/lang/Object;
.source "RikkaTuneActivity.java"
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation
.field final synthetic this$0:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
.method constructor <init>(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)V
    .registers 2
    .line 49
    iput-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;->this$0:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .registers 7
    .line 52
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;->this$0:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->access$000(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)Z
    move-result v0
    if-eqz v0, :cond_9
    return-void
    .line 53
    :cond_9
    invoke-virtual {p1}, Landroid/widget/CompoundButton;->getTag()Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Ljava/lang/String;
    .line 54
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;->this$0:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->access$100(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, " -> "
    const-string v2, "\u5f00\u5173 "
    const-string v3, "RikkaTuneUI"
    if-nez v0, :cond_40
    .line 55
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string p2, " \u4f46 prefs=null! \u672a\u5199\u5165(\u8fde\u4e0d\u4e0a\u6846\u67b6)"
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static {v3, p1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    .line 56
    return-void
    .line 58
    :cond_40
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, " \u5df2\u5199\u5165 RemotePreferences"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v3, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    .line 59
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;->this$0:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->access$100(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    move-result-object p1
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V
    .line 60
    return-void
.end method
