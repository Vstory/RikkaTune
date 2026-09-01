.class public Lcom/vstory/hook/rikkahub/MainHook;
.super Lio/github/libxposed/api/XposedModule;
.field private mAppClassLoader:Ljava/lang/ClassLoader;
.field public static sDebug:Lcom/vstory/hook/rikkahub/MainHook;
.field private static sHookOk:I
.field private static sHookFail:I
.field private static sHookDetail:Ljava/lang/StringBuilder;
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
    sput-object p0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;
    const/4 v0, 0x4
    const-string v1, "RikkaTune"
    const-string v2, "api102 module loaded"
    invoke-virtual {p0, v0, v1, v2}, Lio/github/libxposed/api/XposedInterfaceWrapper;->log(ILjava/lang/String;Ljava/lang/String;)V
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
    .registers 1
    sput-object p0, Lcom/vstory/hook/rikkahub/MainHook;->sDebug:Lcom/vstory/hook/rikkahub/MainHook;
    return-void
.end method
