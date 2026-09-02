.class public Lcom/vstory/hook/rikkahub/RikkaTuneActivity;
.super Landroid/app/Activity;
.source "RikkaTuneActivity.java"

# interfaces
.implements Lio/github/libxposed/service/XposedServiceHelper$OnServiceListener;


# static fields
.field private static final TAG:Ljava/lang/String; = "RikkaTuneUI"


# instance fields
.field private final mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

.field private mRefreshing:Z

.field private mRemotePrefs:Landroid/content/SharedPreferences;

.field private mStatus:Landroid/widget/TextView;

.field private mSwAsr:Landroid/widget/Switch;

.field private mSwCompress:Landroid/widget/Switch;

.field private mSwHaptic:Landroid/widget/Switch;

.field private mSwPangu:Landroid/widget/Switch;


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 34
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 48
    new-instance v0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;

    invoke-direct {v0, p0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity$1;-><init>(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)V

    iput-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    return-void
.end method

.method static synthetic access$000(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)Z
    .registers 1

    .line 34
    iget-boolean p0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRefreshing:Z

    return p0
.end method

.method static synthetic access$100(Lcom/vstory/hook/rikkahub/RikkaTuneActivity;)Landroid/content/SharedPreferences;
    .registers 1

    .line 34
    iget-object p0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    return-object p0
.end method

.method private addSwitchRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/Switch;
    .registers 11

    .line 118
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 119
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 120
    const/16 v2, 0x10

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 121
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 123
    const/16 v3, 0x12

    invoke-direct {p0, v3}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->dp(I)I

    move-result v3

    iput v3, v2, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 124
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 126
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 127
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 128
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v3, v1, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 129
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 131
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 132
    invoke-virtual {v1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 133
    const/high16 p2, 0x41800000    # 16.0f

    invoke-virtual {v1, p2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 134
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 136
    new-instance p2, Landroid/widget/TextView;

    invoke-direct {p2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 137
    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 138
    const p3, -0x777778

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 139
    const/high16 p3, 0x41400000    # 12.0f

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 140
    invoke-virtual {v2, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 142
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 144
    new-instance p2, Landroid/widget/Switch;

    invoke-direct {p2, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V

    .line 145
    invoke-virtual {p2, p4}, Landroid/widget/Switch;->setTag(Ljava/lang/Object;)V

    .line 146
    iget-object p3, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    invoke-virtual {p2, p3}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 147
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 148
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 149
    return-object p2
.end method

.method private buildUi()V
    .registers 6

    .line 74
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 75
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 76
    const/16 v2, 0x14

    invoke-direct {p0, v2}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->dp(I)I

    move-result v2

    .line 77
    const/16 v3, 0xc

    invoke-direct {p0, v3}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->dp(I)I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v2, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 79
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 80
    const-string v3, "RikkaTune"

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 81
    const/high16 v3, 0x41c00000    # 24.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 82
    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 83
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 85
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 86
    const-string v2, "RikkaHub UI \u8c03\u6821 \u00b7 \u5f00\u5173\u5373\u5b58\u5373\u751f\u6548\uff08\u65e0\u9700\u91cd\u542f\uff09"

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 87
    const v2, -0x777778

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 88
    const/high16 v2, 0x41500000    # 13.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 89
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 92
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    .line 93
    const-string v3, "\u6b63\u5728\u8fde\u63a5 LSPosed \u6846\u67b6\u2026"

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 94
    iget-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v3, "#FF9800"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 95
    iget-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 96
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 98
    const/16 v2, 0x8

    invoke-direct {p0, v2}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->dp(I)I

    move-result v2

    iput v2, v1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 99
    iget-object v2, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 100
    iget-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 102
    const-string v1, "UI \u4e2d\u6587\u6587\u6848 \u4e2d\u6587\u2194\u82f1\u6587/\u6570\u5b57 \u4ea4\u754c\u5904\u81ea\u52a8\u63d2\u5165\u7a7a\u683c"

    const-string v2, "pangu_enabled"

    const-string v3, "\u76d8\u53e4\u4e4b\u767d\uff08\u4e2d\u6587\u6392\u7248\uff09"

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->addSwitchRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/Switch;

    move-result-object v1

    iput-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwPangu:Landroid/widget/Switch;

    .line 104
    const-string v1, "\u53bb\u6389\u8bed\u97f3\u8f93\u5165 \u5f00\u59cb/\u7ed3\u675f \u7684\u63d0\u793a\u97f3"

    const-string v2, "asr_sound_muted"

    const-string v3, "\u6d88\u9664\u8bed\u97f3\u8f93\u5165\u63d0\u793a\u97f3"

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->addSwitchRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/Switch;

    move-result-object v1

    iput-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwAsr:Landroid/widget/Switch;

    .line 106
    const-string v1, "\u8bed\u97f3\u8f93\u5165 \u5f00\u59cb/\u7ed3\u675f \u7684\u5f31\u632f\u52a8\u66ff\u6362\u6210\u5f3a\u632f\u52a8\u53cd\u9988"

    const-string v2, "haptic_boost"

    const-string v3, "\u8bed\u97f3\u632f\u52a8\u589e\u5f3a"

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->addSwitchRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/Switch;

    move-result-object v1

    iput-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwHaptic:Landroid/widget/Switch;

    .line 108
    const-string v1, "\u538b\u7f29\u5bf9\u8bdd\u5386\u53f2 \u6210\u529f/\u5931\u8d25 \u65f6 Toast + \u901a\u77e5 + \u632f\u52a8\u63d0\u793a"

    const-string v2, "compress_feedback"

    const-string v3, "\u538b\u7f29\u5bf9\u8bdd\u53cd\u9988"

    invoke-direct {p0, v0, v3, v1, v2}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->addSwitchRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/Switch;

    move-result-object v1

    iput-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwCompress:Landroid/widget/Switch;

    .line 111
    new-instance v1, Landroid/widget/ScrollView;

    invoke-direct {v1, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 112
    invoke-virtual {v1, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 113
    invoke-virtual {p0, v1}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->setContentView(Landroid/view/View;)V

    .line 114
    return-void
.end method

.method private dp(I)I
    .registers 3

    .line 196
    invoke-virtual {p0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    int-to-float p1, p1

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private refreshSwitches()V
    .registers 9

    .line 154
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    const-string v1, "RikkaTuneUI"

    if-nez v0, :cond_c

    .line 155
    const-string v0, "refreshSwitches: prefs=null, \u8df3\u8fc7\u5237\u65b0"

    #ifdef DEBUG
    invoke-static {v1, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 156
    return-void

    .line 158
    :cond_c
    const-string v2, "pangu_enabled"

    const/4 v3, 0x1

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 159
    iget-object v2, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    const-string v4, "asr_sound_muted"

    invoke-interface {v2, v4, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    .line 160
    iget-object v4, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    const-string v5, "haptic_boost"

    invoke-interface {v4, v5, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    .line 161
    iget-object v5, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    const-string v6, "compress_feedback"

    invoke-interface {v5, v6, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v5

    .line 162
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u4ece\u6846\u67b6\u8bfb\u5230\u5f00\u5173: pangu="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " asr="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " haptic="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " compress="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    #ifdef DEBUG
    invoke-static {v1, v6}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 163
    iput-boolean v3, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRefreshing:Z

    .line 164
    iget-object v1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwPangu:Landroid/widget/Switch;

    invoke-virtual {v1, v0}, Landroid/widget/Switch;->setChecked(Z)V

    .line 165
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwAsr:Landroid/widget/Switch;

    invoke-virtual {v0, v2}, Landroid/widget/Switch;->setChecked(Z)V

    .line 166
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwHaptic:Landroid/widget/Switch;

    invoke-virtual {v0, v4}, Landroid/widget/Switch;->setChecked(Z)V

    .line 167
    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mSwCompress:Landroid/widget/Switch;

    invoke-virtual {v0, v5}, Landroid/widget/Switch;->setChecked(Z)V

    .line 168
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRefreshing:Z

    .line 169
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .registers 5

    .line 65
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 66
    const-string p1, "RikkaTuneUI"

    const-string v0, "onCreate: 控制面板启动 (Application 进程级连接)"

    #ifdef DEBUG
    invoke-static {p1, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 67
    invoke-direct {p0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->buildUi()V

    # ⚠️ 2026-09-02 死面板修复: 不再在这 registerListener (会覆盖 Application 的进程级 listener)
    #    改为: ① 设 sUi=this (Application 收到 binder 转发给我) ② 读 Application 静态 prefs
    #          (已连过/进程内 Activity 重建 → 直接复用, 不需框架重发 binder)
    sput-object p0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;

    sget-object p1, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sPrefs:Landroid/content/SharedPreferences;

    if-eqz p1, :not_connected

    # Application 已持有 prefs (曾连上框架) → 直接用 + 刷新开关 + 已连接状态
    iput-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    invoke-direct {p0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->refreshSwitches()V

    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "已连接框架：设置即时生效"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "#2E7D32"

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :done

    :not_connected
    # Application 还没有 prefs (进程首次/框架 binder 未到) → 状态行"正在连接"等待转发
    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "正在连接 LSPosed 框架…"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "#FF9800"

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    :done
    return-void
.end method

.method protected onDestroy()V
    .registers 2

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    # 清空 Application 转发指向(防止 binder 后到转发给已销毁 Activity)
    sget-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;

    if-eq v0, p0, :clear

    goto :done

    :clear
    const/4 v0, 0x0

    sput-object v0, Lcom/vstory/hook/rikkahub/RikkaTuneApp;->sUi:Lcom/vstory/hook/rikkahub/RikkaTuneActivity;

    :done
    return-void
.end method

.method public onServiceBind(Lio/github/libxposed/service/XposedService;)V
    .registers 5

    .line 174
    const-string v0, "onServiceBind: \u8fde\u4e0a\u6846\u67b6!"

    const-string v1, "RikkaTuneUI"

    #ifdef DEBUG
    invoke-static {v1, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 176
    :try_start_7
    const-string v0, "rikka_config"

    invoke-virtual {p1, v0}, Lio/github/libxposed/service/XposedService;->getRemotePreferences(Ljava/lang/String;)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    .line 177
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "getRemotePreferences(rikka_config) -> "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object v0, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    #ifdef DEBUG
    invoke-static {v1, p1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif
    :try_end_27
    .catchall {:try_start_7 .. :try_end_27} :catchall_28

    .line 181
    goto :goto_42

    .line 178
    :catchall_28
    move-exception p1

    .line 179
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getRemotePreferences \u5f02\u5e38: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    #ifdef DEBUG
    invoke-static {v1, p1}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 180
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    .line 182
    :goto_42
    invoke-direct {p0}, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->refreshSwitches()V

    .line 183
    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "\u5df2\u8fde\u63a5\u6846\u67b6\uff1a\u8bbe\u7f6e\u5373\u65f6\u751f\u6548"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 184
    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "#2E7D32"

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 185
    return-void
.end method

.method public onServiceDied(Lio/github/libxposed/service/XposedService;)V
    .registers 3

    .line 189
    const-string p1, "RikkaTuneUI"

    const-string v0, "onServiceDied: \u6846\u67b6\u65ad\u5f00"

    #ifdef DEBUG
    invoke-static {p1, v0}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V
    #endif

    .line 190
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mRemotePrefs:Landroid/content/SharedPreferences;

    .line 191
    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const-string v0, "\u6846\u67b6\u8fde\u63a5\u65ad\u5f00"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 192
    iget-object p1, p0, Lcom/vstory/hook/rikkahub/RikkaTuneActivity;->mStatus:Landroid/widget/TextView;

    const/high16 v0, -0x10000

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 193
    return-void
.end method
