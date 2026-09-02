.class public Lcom/vstory/hook/rikkahub/Prefs;
.super Ljava/lang/Object;
.source "Prefs.java"


# static fields
.field public static final KEY_ASR_SOUND:Ljava/lang/String; = "asr_sound_muted"

.field public static final KEY_COMPRESS:Ljava/lang/String; = "compress_feedback"

.field public static final KEY_HAPTIC:Ljava/lang/String; = "haptic_boost"

.field public static final KEY_PANGU:Ljava/lang/String; = "pangu_enabled"

.field public static final PREFS_GROUP:Ljava/lang/String; = "rikka_config"

.field private static sLogAsr:Z

.field private static sLogCompress:Z

.field private static sLogHaptic:Z

.field private static sLogPangu:Z

.field private static sPrefs:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 38
    const/4 v0, 0x1

    sput-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogPangu:Z

    .line 39
    sput-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogAsr:Z

    .line 40
    sput-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogHaptic:Z

    .line 41
    sput-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogCompress:Z

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static init(Landroid/content/SharedPreferences;)V
    .registers 5

    .line 45
    sput-object p0, Lcom/vstory/hook/rikkahub/Prefs;->sPrefs:Landroid/content/SharedPreferences;

    .line 46
    nop

    .line 47
    const-string v0, "RikkaTunePrefs"

    if-nez p0, :cond_d

    .line 48
    const-string p0, "init: prefs=null (\u672a\u7ed1\u5b9a/\u8fde\u4e0d\u4e0a\u6846\u67b6) -> \u5168\u90e8\u9ed8\u8ba4\u5f00"

    #ifdef DEBUG
    invoke-static {v0, p0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    goto :goto_5a

    .line 50
    :cond_d
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "init: \u5df2\u7ed1\u5b9a prefs, \u5f53\u524d\u5f00\u5173\u503c pangu="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "pangu_enabled"

    const/4 v3, 0x1

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " asrSound="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 51
    const-string v2, "asr_sound_muted"

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " haptic="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 52
    const-string v2, "haptic_boost"

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " compress="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 53
    const-string v2, "compress_feedback"

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 50
    #ifdef DEBUG
    invoke-static {v0, p0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 55
    :goto_5a
    return-void
.end method

.method public static isAsrSoundMuted()Z
    .registers 3

    .line 72
    sget-object v0, Lcom/vstory/hook/rikkahub/Prefs;->sPrefs:Landroid/content/SharedPreferences;

    const/4 v1, 0x1

    if-eqz v0, :cond_f

    const-string v2, "asr_sound_muted"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_e

    goto :goto_f

    :cond_e
    const/4 v1, 0x0

    .line 73
    :cond_f
    :goto_f
    sget-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogAsr:Z

    if-eq v1, v0, :cond_2d

    .line 74
    sput-boolean v1, Lcom/vstory/hook/rikkahub/Prefs;->sLogAsr:Z

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "asr_sound_muted -> "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "RikkaTunePrefs"

    #ifdef DEBUG
    invoke-static {v2, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 77
    :cond_2d
    return v1
.end method

.method public static isCompressFeedback()Z
    .registers 3

    .line 90
    sget-object v0, Lcom/vstory/hook/rikkahub/Prefs;->sPrefs:Landroid/content/SharedPreferences;

    const/4 v1, 0x1

    if-eqz v0, :cond_f

    const-string v2, "compress_feedback"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_e

    goto :goto_f

    :cond_e
    const/4 v1, 0x0

    .line 91
    :cond_f
    :goto_f
    sget-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogCompress:Z

    if-eq v1, v0, :cond_2d

    .line 92
    sput-boolean v1, Lcom/vstory/hook/rikkahub/Prefs;->sLogCompress:Z

    .line 93
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "compress_feedback -> "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "RikkaTunePrefs"

    #ifdef DEBUG
    invoke-static {v2, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 95
    :cond_2d
    return v1
.end method

.method public static isHapticBoost()Z
    .registers 3

    .line 81
    sget-object v0, Lcom/vstory/hook/rikkahub/Prefs;->sPrefs:Landroid/content/SharedPreferences;

    const/4 v1, 0x1

    if-eqz v0, :cond_f

    const-string v2, "haptic_boost"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_e

    goto :goto_f

    :cond_e
    const/4 v1, 0x0

    .line 82
    :cond_f
    :goto_f
    sget-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogHaptic:Z

    if-eq v1, v0, :cond_2d

    .line 83
    sput-boolean v1, Lcom/vstory/hook/rikkahub/Prefs;->sLogHaptic:Z

    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "haptic_boost -> "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "RikkaTunePrefs"

    #ifdef DEBUG
    invoke-static {v2, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 86
    :cond_2d
    return v1
.end method

.method public static isPanguEnabled()Z
    .registers 3

    .line 63
    sget-object v0, Lcom/vstory/hook/rikkahub/Prefs;->sPrefs:Landroid/content/SharedPreferences;

    const/4 v1, 0x1

    if-eqz v0, :cond_f

    const-string v2, "pangu_enabled"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_e

    goto :goto_f

    :cond_e
    const/4 v1, 0x0

    .line 64
    :cond_f
    :goto_f
    sget-boolean v0, Lcom/vstory/hook/rikkahub/Prefs;->sLogPangu:Z

    if-eq v1, v0, :cond_2d

    .line 65
    sput-boolean v1, Lcom/vstory/hook/rikkahub/Prefs;->sLogPangu:Z

    .line 66
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "pangu_enabled -> "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "RikkaTunePrefs"

    #ifdef DEBUG
    invoke-static {v2, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 68
    :cond_2d
    return v1
.end method

.method public static prefs()Landroid/content/SharedPreferences;
    .registers 1

    .line 59
    sget-object v0, Lcom/vstory/hook/rikkahub/Prefs;->sPrefs:Landroid/content/SharedPreferences;

    return-object v0
.end method
