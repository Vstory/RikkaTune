.class public final Lio/github/libxposed/service/RemotePreferences;
.super Ljava/lang/Object;
.source "RemotePreferences.java"

# interfaces
.implements Landroid/content/SharedPreferences;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/RemotePreferences$Editor;
    }
.end annotation


# static fields
.field private static final CONTENT:Ljava/lang/Object;

.field private static final EXECUTOR:Ljava/util/concurrent/ExecutorService;

.field private static final TAG:Ljava/lang/String; = "RemotePreferences"

.field static volatile shouldNotifyCleared:Z


# instance fields
.field private final mGroup:Ljava/lang/String;

.field private final mListeners:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private volatile mMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private final mService:Lio/github/libxposed/service/XposedService;


# direct methods
.method static bridge synthetic -$$Nest$fgetmGroup(Lio/github/libxposed/service/RemotePreferences;)Ljava/lang/String;
    .registers 1

    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mGroup:Ljava/lang/String;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetmListeners(Lio/github/libxposed/service/RemotePreferences;)Ljava/util/Map;
    .registers 1

    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mListeners:Ljava/util/Map;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetmMap(Lio/github/libxposed/service/RemotePreferences;)Ljava/util/Map;
    .registers 1

    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetmService(Lio/github/libxposed/service/RemotePreferences;)Lio/github/libxposed/service/XposedService;
    .registers 1

    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mService:Lio/github/libxposed/service/XposedService;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputmMap(Lio/github/libxposed/service/RemotePreferences;Ljava/util/Map;)V
    .registers 2

    iput-object p1, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    return-void
.end method

.method static bridge synthetic -$$Nest$sfgetEXECUTOR()Ljava/util/concurrent/ExecutorService;
    .registers 1

    sget-object v0, Lio/github/libxposed/service/RemotePreferences;->EXECUTOR:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method static constructor <clinit>()V
    .registers 1

    .line 27
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lio/github/libxposed/service/RemotePreferences;->CONTENT:Ljava/lang/Object;

    .line 28
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lio/github/libxposed/service/RemotePreferences;->EXECUTOR:Ljava/util/concurrent/ExecutorService;

    const/4 v0, 0x0

    .line 30
    sput-boolean v0, Lio/github/libxposed/service/RemotePreferences;->shouldNotifyCleared:Z

    return-void
.end method

.method private constructor <init>(Lio/github/libxposed/service/XposedService;Ljava/lang/String;)V
    .registers 4

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lio/github/libxposed/service/RemotePreferences;->mListeners:Ljava/util/Map;

    .line 39
    iput-object p1, p0, Lio/github/libxposed/service/RemotePreferences;->mService:Lio/github/libxposed/service/XposedService;

    .line 40
    iput-object p2, p0, Lio/github/libxposed/service/RemotePreferences;->mGroup:Ljava/lang/String;

    return-void
.end method

.method static newInstance(Lio/github/libxposed/service/XposedService;Ljava/lang/String;)Lio/github/libxposed/service/RemotePreferences;
    .registers 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 45
    invoke-virtual {p0}, Lio/github/libxposed/service/XposedService;->asInterface()Lio/github/libxposed/service/IXposedService;

    move-result-object v0

    invoke-interface {v0, p1}, Lio/github/libxposed/service/IXposedService;->requestRemotePreferences(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    if-eqz v0, :cond_27

    .line 47
    new-instance v1, Lio/github/libxposed/service/RemotePreferences;

    invoke-direct {v1, p0, p1}, Lio/github/libxposed/service/RemotePreferences;-><init>(Lio/github/libxposed/service/XposedService;Ljava/lang/String;)V

    .line 48
    const-string p0, "map"

    invoke-virtual {v0, p0}, Landroid/os/Bundle;->getSerializable(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p0

    check-cast p0, Ljava/util/Map;

    if-eqz p0, :cond_20

    .line 49
    invoke-static {p0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p0

    iput-object p0, v1, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    return-object v1

    .line 50
    :cond_20
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object p0

    iput-object p0, v1, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    return-object v1

    .line 46
    :cond_27
    new-instance p0, Landroid/os/RemoteException;

    const-string p1, "Framework returns null"

    invoke-direct {p0, p1}, Landroid/os/RemoteException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method public contains(Ljava/lang/String;)Z
    .registers 2

    .line 101
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public bridge synthetic edit()Landroid/content/SharedPreferences$Editor;
    .registers 1

    .line 23
    invoke-virtual {p0}, Lio/github/libxposed/service/RemotePreferences;->edit()Lio/github/libxposed/service/RemotePreferences$Editor;

    move-result-object p0

    return-object p0
.end method

.method public edit()Lio/github/libxposed/service/RemotePreferences$Editor;
    .registers 2

    .line 116
    new-instance v0, Lio/github/libxposed/service/RemotePreferences$Editor;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/RemotePreferences$Editor;-><init>(Lio/github/libxposed/service/RemotePreferences;)V

    return-object v0
.end method

.method public getAll()Ljava/util/Map;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "*>;"
        }
    .end annotation

    .line 60
    new-instance v0, Ljava/util/TreeMap;

    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-direct {v0, p0}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    return-object v0
.end method

.method public getBoolean(Ljava/lang/String;Z)Z
    .registers 3

    .line 95
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_f

    .line 96
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    return p0

    :cond_f
    return p2
.end method

.method public getFloat(Ljava/lang/String;F)F
    .registers 3

    .line 89
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_f

    .line 90
    check-cast p0, Ljava/lang/Float;

    invoke-virtual {p0}, Ljava/lang/Float;->floatValue()F

    move-result p0

    return p0

    :cond_f
    return p2
.end method

.method public getInt(Ljava/lang/String;I)I
    .registers 3

    .line 77
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_f

    .line 78
    check-cast p0, Ljava/lang/Integer;

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0

    return p0

    :cond_f
    return p2
.end method

.method public getLong(Ljava/lang/String;J)J
    .registers 4

    .line 83
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_f

    .line 84
    check-cast p0, Ljava/lang/Long;

    invoke-virtual {p0}, Ljava/lang/Long;->longValue()J

    move-result-wide p0

    return-wide p0

    :cond_f
    return-wide p2
.end method

.method public getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .line 66
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1, p2}, Ljava/util/Map;->getOrDefault(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    return-object p0
.end method

.method public getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 72
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;

    invoke-interface {p0, p1, p2}, Ljava/util/Map;->getOrDefault(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/util/Set;

    return-object p0
.end method

.method declared-synchronized onDelete()V
    .registers 2

    monitor-enter p0

    .line 55
    :try_start_1
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lio/github/libxposed/service/RemotePreferences;->mMap:Ljava/util/Map;
    :try_end_7
    .catchall {:try_start_1 .. :try_end_7} :catchall_9

    .line 56
    monitor-exit p0

    return-void

    :catchall_9
    move-exception v0

    :try_start_a
    monitor-exit p0
    :try_end_b
    .catchall {:try_start_a .. :try_end_b} :catchall_9

    throw v0
.end method

.method public registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    .registers 3

    .line 106
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mListeners:Ljava/util/Map;

    sget-object v0, Lio/github/libxposed/service/RemotePreferences;->CONTENT:Ljava/lang/Object;

    invoke-interface {p0, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    .registers 2

    .line 111
    iget-object p0, p0, Lio/github/libxposed/service/RemotePreferences;->mListeners:Ljava/util/Map;

    invoke-interface {p0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
