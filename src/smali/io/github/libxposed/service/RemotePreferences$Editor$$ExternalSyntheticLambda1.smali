.class public final synthetic Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/util/HashMap;


# direct methods
.method public synthetic constructor <init>(Ljava/util/HashMap;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda1;->f$0:Ljava/util/HashMap;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .registers 2

    .line 0
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences$Editor$$ExternalSyntheticLambda1;->f$0:Ljava/util/HashMap;

    check-cast p1, Ljava/lang/String;

    invoke-static {p0, p1}, Lio/github/libxposed/service/RemotePreferences$Editor;->$r8$lambda$dpA5H12ZD2CfzvgwpDUcgW3slU8(Ljava/util/HashMap;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
