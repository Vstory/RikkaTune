.class public Lcom/vstory/hook/rikkahub/MainHook;
.super Lio/github/libxposed/api/XposedModule;
.implements Lcom/vstory/hook/rikkahub/HookLogger;
.field private mAppClassLoader:Ljava/lang/ClassLoader;
.field private static sHookOk:I
.field private static sHookFail:I
.field private static sHookDetail:Ljava/lang/StringBuilder;
.field public static sCompressInProgress:Z
.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Lio/github/libxposed/api/XposedModule;-><init>()V
    return-void
.end method
.method private hookMethod(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 7
    :try_start
    const/4 v0, 0x0
    invoke-static {p2, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v0
    const/4 v1, 0x0
    new-array v1, v1, [Ljava/lang/Class;
    invoke-virtual {v0, p3, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    move-result-object v0
    invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v0
    sget-object v1, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;
    invoke-interface {v0, v1}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v0
    invoke-interface {v0, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_ignore
    :catch_ignore
    return-void
.end method
.method private hookMethodStrInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 9
    :try_start
    const/4 v0, 0x0
    invoke-static {p2, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v0
    const/4 v1, 0x2
    new-array v1, v1, [Ljava/lang/Class;
    const-class v2, Ljava/lang/String;
    const/4 v3, 0x0
    aput-object v2, v1, v3
    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;
    const/4 v3, 0x1
    aput-object v2, v1, v3
    invoke-virtual {v0, p3, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    move-result-object v0
    invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v0
    sget-object v1, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;
    invoke-interface {v0, v1}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v0
    invoke-interface {v0, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_ignore
    :catch_ignore
    return-void
.end method
.method private hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 15
    move-object v6, p2
    move-object v7, p3
    :try_start
    const/4 v0, 0x0
    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v4
    const/4 v5, 0x1
    new-array v5, v5, [Ljava/lang/Class;
    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;
    const/4 v9, 0x0
    aput-object v8, v5, v9
    invoke-virtual {v4, v7, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    move-result-object v4
    invoke-virtual {p0, v4}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v4
    sget-object v5, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;
    invoke-interface {v4, v5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v4
    invoke-interface {v4, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const-string v1, "[OK] "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "#"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log
    :catch_log
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const-string v1, "["
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "#"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "]\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :end_hook
    return-void
.end method
.method private hookMethodObjInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 15
    move-object v6, p2
    move-object v7, p3
    :try_start
    const/4 v0, 0x0
    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v4
    const/4 v5, 0x2
    new-array v5, v5, [Ljava/lang/Class;
    const-class v8, Ljava/lang/Object;
    const/4 v9, 0x0
    aput-object v8, v5, v9
    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;
    const/4 v9, 0x1
    aput-object v8, v5, v9
    invoke-virtual {v4, v7, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    move-result-object v4
    invoke-virtual {p0, v4}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v4
    sget-object v5, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;
    invoke-interface {v4, v5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v4
    invoke-interface {v4, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log
    :catch_log
    move-exception v0
    return-void
    :end_hook
    return-void
.end method
.method private hookMethodObjIntExact(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 16
    move-object v6, p2
    move-object v7, p3
    :try_start
    const/4 v0, 0x0
    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v4
    const/4 v5, 0x2
    new-array v5, v5, [Ljava/lang/Class;
    const/4 v0, 0x0
    invoke-static {p4, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v8
    const/4 v9, 0x0
    aput-object v8, v5, v9
    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;
    const/4 v9, 0x1
    aput-object v8, v5, v9
    invoke-virtual {v4, v7, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    move-result-object v4
    invoke-virtual {p0, v4}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v4
    sget-object v5, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;
    invoke-interface {v4, v5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v4
    invoke-interface {v4, p5}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const-string v1, "[OK] "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "#"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :end_hook
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log
    :catch_log
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const-string v1, "["
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "#"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "]\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :end_hook
    return-void
.end method
.method private hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    .registers 15
    move-object v6, p2
    move-object v7, p3
    :try_start
    const/4 v0, 0x0
    invoke-static {v6, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;
    move-result-object v5
    array-length v2, v5
    const/4 v3, 0x0
    :loop
    if-ge v3, v2, :not_found
    aget-object v8, v5, v3
    invoke-virtual {v8}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;
    move-result-object v9
    invoke-virtual {v9, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v9
    if-eqz v9, :next
    invoke-virtual {p0, v8}, Lio/github/libxposed/api/XposedInterfaceWrapper;->hook(Ljava/lang/reflect/Executable;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v8
    sget-object v9, Lio/github/libxposed/api/XposedInterface$ExceptionMode;->PROTECTIVE:Lio/github/libxposed/api/XposedInterface$ExceptionMode;
    invoke-interface {v8, v9}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->setExceptionMode(Lio/github/libxposed/api/XposedInterface$ExceptionMode;)Lio/github/libxposed/api/XposedInterface$HookBuilder;
    move-result-object v8
    invoke-interface {v8, p4}, Lio/github/libxposed/api/XposedInterface$HookBuilder;->intercept(Lio/github/libxposed/api/XposedInterface$Hooker;)Lio/github/libxposed/api/XposedInterface$HookHandle;
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const-string v1, "[OK] "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "#"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :end_hook
    :next
    add-int/lit8 v3, v3, 0x1
    goto :loop
    :not_found
    const/4 v0, 0x0
    throw v0
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_log
    :catch_log
    sget v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const-string v1, "["
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "#"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "]\n"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :end_hook
    return-void
.end method
.method private installHooks(Ljava/lang/ClassLoader;)V
    .registers 12
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    sput-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const/4 v0, 0x0
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;
    invoke-direct {v1}, Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;-><init>()V
    const-string v4, "android.content.res.Resources"
    const-string v5, "getString"
    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    new-instance v5, Lcom/vstory/hook/rikkahub/MainHook$AsrSoundHooker;
    invoke-direct {v5}, Lcom/vstory/hook/rikkahub/MainHook$AsrSoundHooker;-><init>()V
    move-object v0, p0
    move-object v1, p1
    const-string v2, "me.rerere.rikkahub.utils.SoundEffectPlayer"
    const-string v3, "play$default"
    const-string v4, "me.rerere.rikkahub.utils.SoundEffectPlayer"
    invoke-direct/range {v0 .. v5}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodObjIntExact(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$HapticVibrateHooker;
    invoke-direct {v1}, Lcom/vstory/hook/rikkahub/MainHook$HapticVibrateHooker;-><init>()V
    const-string v4, "androidx.compose.ui.hapticfeedback.PlatformHapticFeedback"
    const-string v5, "performHapticFeedback-CdsT49E"
    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;
    const/4 v2, 0x1
    invoke-direct {v1, v2}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;-><init>(I)V
    const-string v4, "me.rerere.rikkahub.service.ChatService"
    const-string v5, "compressConversation-hUnOzRk"
    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;
    const/4 v2, 0x2
    invoke-direct {v1, v2}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;-><init>(I)V
    const-string v4, "me.rerere.rikkahub.service.ChatService"
    const-string v5, "addError"
    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    new-instance v1, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;
    const/4 v2, 0x3
    invoke-direct {v1, v2}, Lcom/vstory/hook/rikkahub/MainHook$CompressFeedbackHooker;-><init>(I)V
    const-string v4, "me.rerere.rikkahub.service.ChatService"
    const-string v5, "saveConversation"
    invoke-direct {p0, p1, v4, v5, v1}, Lcom/vstory/hook/rikkahub/MainHook;->hookMethodByName(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Lio/github/libxposed/api/XposedInterface$Hooker;)V
    const/4 v0, 0x4
    const-string v1, "RikkaTune"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "installHooks done: "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget v3, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v3, " OK / "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget v3, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v3, " FAIL / \n"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object v3, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {p0, v0, v1, v2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V
    const/4 v0, 0x0
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookOk:I
    sput v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookFail:I
    sget-object v0, Lcom/vstory/hook/rikkahub/MainHook;->sHookDetail:Ljava/lang/StringBuilder;
    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->setLength(I)V
    return-void
.end method
.method public logD(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    const/4 v0, 0x3
    invoke-virtual {p0, v0, p1, p2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V
    return-void
.end method
.method public logD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 6
    const/4 v0, 0x3
    invoke-virtual {p0, v0, p1, p2, p3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    return-void
.end method
.method public onModuleLoaded(Lio/github/libxposed/api/XposedModuleInterface$ModuleLoadedParam;)V
    .registers 5
    sput-object p0, Lcom/vstory/hook/rikkahub/Debug;->sLogger:Lcom/vstory/hook/rikkahub/HookLogger;
    const/4 v0, 0x4
    const-string v1, "RikkaTune"
    const-string v2, "api102 module loaded"
    invoke-virtual {p0, v0, v1, v2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V
    const-string v0, "rikka_config"
    invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedInterfaceWrapper;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/Prefs;->init(Landroid/content/SharedPreferences;)V
    return-void
.end method
.method public onPackageReady(Lio/github/libxposed/api/XposedModuleInterface$PackageReadyParam;)V
    .registers 7
    invoke-interface {p1}, Lio/github/libxposed/api/XposedModuleInterface$PackageReadyParam;->getClassLoader()Ljava/lang/ClassLoader;
    move-result-object v0
    iput-object v0, p0, Lcom/vstory/hook/rikkahub/MainHook;->mAppClassLoader:Ljava/lang/ClassLoader;
    const/4 v1, 0x4
    const-string v2, "RikkaTune"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "[pkg] onPackageReady, classLoader="
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    if-eqz v0, :cl_null
    const-string v4, "non-null"
    goto :cl_log
    :cl_null
    const-string v4, "NULL!"
    :cl_log
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {p0, v1, v2, v3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V
    invoke-direct {p0, v0}, Lcom/vstory/hook/rikkahub/MainHook;->installHooks(Ljava/lang/ClassLoader;)V
    return-void
.end method
.method public onHotReloading(Lio/github/libxposed/api/XposedModuleInterface$HotReloadingParam;)Z
    .registers 3
    const/4 v0, 0x1
    return v0
.end method
.method public onHotReloaded(Lio/github/libxposed/api/XposedModuleInterface$HotReloadedParam;)V
    .registers 8
    const/4 v0, 0x0
    invoke-interface {p1}, Lio/github/libxposed/api/XposedModuleInterface$HotReloadedParam;->getOldHookHandles()Ljava/util/List;
    move-result-object v1
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z
    move-result v2
    if-nez v2, :try_handle
    const/4 v2, 0x0
    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lio/github/libxposed/api/XposedInterface$HookHandle;
    invoke-interface {v1}, Lio/github/libxposed/api/XposedInterface$HookHandle;->getExecutable()Ljava/lang/reflect/Executable;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/reflect/Executable;->getDeclaringClass()Ljava/lang/Class;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;
    move-result-object v0
    :try_handle
    invoke-interface {p1}, Lio/github/libxposed/api/XposedModuleInterface$HotReloadedParam;->getOldHookHandles()Ljava/util/List;
    move-result-object v1
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop_unhook
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done_unhook
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lio/github/libxposed/api/XposedInterface$HookHandle;
    invoke-interface {v2}, Lio/github/libxposed/api/XposedInterface$HookHandle;->unhook()V
    goto :loop_unhook
    :done_unhook
    if-nez v0, :have_cl
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/MainHook;->mAppClassLoader:Ljava/lang/ClassLoader;
    :have_cl
    if-nez v0, :install
    return-void
    :install
    invoke-direct {p0, v0}, Lcom/vstory/hook/rikkahub/MainHook;->installHooks(Ljava/lang/ClassLoader;)V
    invoke-direct {p0}, Lcom/vstory/hook/rikkahub/MainHook;->restoreModuleState()V
    const/4 v1, 0x4
    const-string v2, "RikkaTune"
    const-string v3, "hot reloaded, hooks reinstalled"
    invoke-virtual {p0, v1, v2, v3}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V
    return-void
.end method
.method private restoreModuleState()V
    .registers 2
    sput-object p0, Lcom/vstory/hook/rikkahub/Debug;->sLogger:Lcom/vstory/hook/rikkahub/HookLogger;
    const/4 v0, 0x0
    sput-boolean v0, Lcom/vstory/hook/rikkahub/MainHook;->sCompressInProgress:Z
    const-string v0, "rikka_config"
    invoke-virtual {p0, v0}, Lio/github/libxposed/api/XposedInterfaceWrapper;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/Prefs;->init(Landroid/content/SharedPreferences;)V
    return-void
.end method
.method public static notifyCompressResult(Landroid/content/Context;Z)V
    .registers 9
    if-eqz p0, :return
    const-string v0, "压缩成功"
    if-eqz p1, :toast_fail
    goto :toast_show
    :toast_fail
    const-string v0, "压缩失败"
    :toast_show
    const/4 v1, 0x0
    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_start_vib
    const-string v0, "RikkaTune"
    const-string v1, "vibrate: try Vibrator"
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    const-string v0, "vibrator"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    instance-of v1, v0, Landroid/os/Vibrator;
    if-eqz v1, :skip_vib
    check-cast v0, Landroid/os/Vibrator;
    const-wide/16 v1, 0x50
    if-eqz p1, :vib_ms_fail
    goto :vib_ms_ok
    :vib_ms_fail
    const-wide/16 v1, 0x78
    :vib_ms_ok
    const/16 v3, 0x96
    if-eqz p1, :vib_amp_fail
    goto :vib_amp_ok
    :vib_amp_fail
    const/16 v3, 0xc8
    :vib_amp_ok
    invoke-static {v1, v2, v3}, Landroid/os/VibrationEffect;->createOneShot(JI)Landroid/os/VibrationEffect;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/os/Vibrator;->vibrate(Landroid/os/VibrationEffect;)V
    :skip_vib
    :try_end_vib
    .catch Ljava/lang/Throwable; {:try_start_vib .. :try_end_vib} :catch_vib
    :catch_vib
    const-string v0, "RikkaTune"
    const-string v1, "vibrate: FAILED (no VIBRATE perm?)"
    invoke-static {v0, v1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_start_notif
    const-string v0, "notification"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    instance-of v1, v0, Landroid/app/NotificationManager;
    if-eqz v1, :skip_notif
    check-cast v0, Landroid/app/NotificationManager;
    const-string v1, "compress_feedback"
    const-string v2, "压缩反馈"
    const/4 v3, 0x3
    new-instance v4, Landroid/app/NotificationChannel;
    invoke-direct {v4, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
    const/4 v1, 0x1
    invoke-virtual {v4, v1}, Landroid/app/NotificationChannel;->enableVibration(Z)V
    const/4 v1, 0x4
    new-array v1, v1, [J
    const/4 v2, 0x0
    const-wide/16 v5, 0x0
    aput-wide v5, v1, v2
    const/4 v2, 0x1
    const-wide/16 v5, 0x50
    if-eqz p1, :pat_s1
    goto :pat_ok1
    :pat_s1
    const-wide/16 v5, 0x78
    :pat_ok1
    aput-wide v5, v1, v2
    const/4 v2, 0x2
    const-wide/16 v5, 0x28
    if-eqz p1, :pat_s2
    goto :pat_ok2
    :pat_s2
    const-wide/16 v5, 0x3c
    :pat_ok2
    aput-wide v5, v1, v2
    const/4 v2, 0x3
    const-wide/16 v5, 0x50
    if-eqz p1, :pat_s3
    goto :pat_ok3
    :pat_s3
    const-wide/16 v5, 0x78
    :pat_ok3
    aput-wide v5, v1, v2
    invoke-virtual {v4, v1}, Landroid/app/NotificationChannel;->setVibrationPattern([J)V
    invoke-virtual {v0, v4}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
    const-string v1, "RikkaTune"
    const-string v2, "notify: channel created with vibration"
    invoke-static {v1, v2}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    new-instance v4, Landroid/app/Notification$Builder;
    const-string v5, "compress_feedback"
    invoke-direct {v4, p0, v5}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    const v5, 0x1080083
    if-eqz p1, :icon_fail
    goto :icon_ok
    :icon_fail
    const v5, 0x1080078
    :icon_ok
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;
    const-string v5, "RikkaTune"
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    const-string v5, "对话历史压缩成功"
    if-eqz p1, :text_fail
    goto :text_ok
    :text_fail
    const-string v5, "对话历史压缩失败"
    :text_ok
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    const/4 v5, 0x1
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;
    invoke-virtual {v4}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v1
    const/4 v2, 0x1
    if-eqz p1, :notif_id_fail
    goto :notif_id_ok
    :notif_id_fail
    const/4 v2, 0x2
    :notif_id_ok
    invoke-virtual {v0, v2, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :skip_notif
    :try_end_notif
    .catch Ljava/lang/Throwable; {:try_start_notif .. :try_end_notif} :catch_notif
    :catch_notif
    :return
    return-void
.end method
