#
# ============================================================
# AsrSoundHooker — hook SoundEffectPlayer#play$default(SoundEffectPlayer, int)
# 用途: 去掉 ASR(语音输入) 开始/结束的提示音
#   拦截时判断参数 arg1(资源 id), 若为 asr_start(0x7f120000) / asr_stop(0x7f120001)
#   则吞掉(不 proceed), 其它声音正常放行
# 用法:
#   Object intercept(Chain chain):   # play$default 返回 void
#     Object rid = chain.getArg(1);            // 资源 id (Integer)
#     if (rid is Integer && rid == 0x7f120000) return null;   // asr_start 吞掉
#     if (rid is Integer && rid == 0x7f120001) return null;   // asr_stop 吞掉
#     return chain.proceed();                   // 其它声音正常播放
# ============================================================
# ⚠️ libxposed Chain API:
#   - getArg(int index) 返回 Object (单参读取, 不可修改)
#   - proceed() 走原方法; 改参数须用 proceed(Object[] args)
#   - play$default 是 static 方法, getThisObject()=null, 参数在 getArg(0..N-1)
#   - play$default 返回 void → intercept 返回 null 即可
# ============================================================
# ⚠️ smali 寄存器: intercept(Chain) 虚方法
#   参数: this(p0) + Chain(p1) = 2 => .registers = 4 (locals v0/v1)
# ============================================================
.class public Lcom/vstory/hook/rikkahub/MainHook$AsrSoundHooker;
.super Ljava/lang/Object;

# interfaces
.implements Lio/github/libxposed/api/XposedInterface$Hooker;

# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# virtual methods
# Object intercept(Chain chain) -> 判断 arg1 是否为 ASR 声音资源, 是则返回 null(不播), 否则 proceed()
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 5

    # Object arg1 = chain.getArg(1);   // 资源 id
    const/4 v0, 0x1

    invoke-interface {p1, v0}, Lio/github/libxposed/api/XposedInterface$Chain;->getArg(I)Ljava/lang/Object;

    move-result-object v0

    # ⚠️ 控制面板开关: 消除提示音关闭 → 正常放行(不吞任何声音)
    invoke-static {}, Lcom/vstory/hook/rikkahub/Prefs;->isAsrSoundMuted()Z

    move-result v2

    if-eqz v2, :pass

    # 防御: 非 Integer 直接放行
    instance-of v1, v0, Ljava/lang/Integer;

    if-eqz v1, :pass

    # int rid = ((Integer) arg1).intValue()
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    # if (rid == 0x7f120000) return null;   // asr_start
    const v1, 0x7f120000

    if-eq v0, v1, :swallow

    # if (rid == 0x7f120001) return null;   // asr_stop
    const v1, 0x7f120001

    if-eq v0, v1, :swallow

    # 其它声音 → 正常播放
    :pass
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;

    move-result-object v0

    return-object v0

    # ASR 声音 → 吞掉(不播放), 返回 null (play$default 返回 void, null 即可)
    :swallow
    const/4 v0, 0x0

    return-object v0
.end method
