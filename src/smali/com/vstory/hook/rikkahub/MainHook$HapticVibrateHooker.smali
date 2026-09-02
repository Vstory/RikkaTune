#
# ============================================================
# HapticVibrateHooker — hook PlatformHapticFeedback#performHapticFeedback-CdsT49E(int)
# 用途: 把 ASR(语音输入) 开始/结束的振动从小到大调强
#   RikkaHub 语音输入振动用的是 Android 13+ 的"微妙"反馈常量:
#     Listening(开始) = 0x17(23) 太弱
#     Stopping(结束)  = 0xd(13)  太弱
#   "消息生成触觉反馈"(流式AI输出) 用的是 0x3(Confirm), 较强可感
#   所以把语音输入的两个常量替换成 0x3, 让开始/结束都能明显感觉到
# 用法:
#   Object intercept(Chain chain):   # performHapticFeedback 返回 void
#     Object htype = chain.getArg(0);        // 振动常量 (Integer)
#     if (htype is Integer && (htype == 0x17 || htype == 0xd))
#         return chain.proceed(new Object[]{ Integer.valueOf(0x3) });   // 换成强振
#     return chain.proceed();                // 其它振动正常
# ============================================================
# ⚠️ libxposed Chain API:
#   - getArg(int index) 返回 Object (只读)
#   - 改参数必须用 proceed(Object[] args) 传新参数数组
#   - performHapticFeedback-CdsT49E 是实例方法, getThisObject()=this(PlatformHapticFeedback)
#   - 返回 void → proceed 返回 null
# ============================================================
# ⚠️ smali 寄存器: intercept(Chain) 虚方法
#   参数: this(p0) + Chain(p1) = 2 => .registers = 6 (locals v0-v3 = 4)
# ============================================================
.class public Lcom/vstory/hook/rikkahub/MainHook$HapticVibrateHooker;
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
# Object intercept(Chain chain) -> 若 arg0=0x17/0xd(语音) 用 0x3 重调, 否则 proceed()
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 6

    # Object arg0 = chain.getArg(0);   // 振动常量
    const/4 v0, 0x0

    invoke-interface {p1, v0}, Lio/github/libxposed/api/XposedInterface$Chain;->getArg(I)Ljava/lang/Object;

    move-result-object v0

    # 防御: 非 Integer 直接放行
    instance-of v1, v0, Ljava/lang/Integer;

    if-eqz v1, :pass

    # int htype = ((Integer) arg0).intValue()
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    # if (htype == 0x17) goto :replace   // 语音开始
    const/16 v1, 0x17

    if-eq v0, v1, :replace

    # if (htype == 0xd) goto :replace    // 语音结束
    const/16 v1, 0xd

    if-eq v0, v1, :replace

    # 其它振动(文本选区/菜单/消息生成等) → 正常放行
    :pass
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;

    move-result-object v0

    return-object v0

    # 换成强振动常量 0x3 (Confirm, 跟消息生成触觉反馈一致)
    :replace
    # Object[] newArgs = new Object[]{ Integer.valueOf(0x3) };
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x3

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    # return chain.proceed(newArgs);   // void 方法 → 返回 null
    invoke-interface {p1, v0}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
