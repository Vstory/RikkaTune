#
# ============================================================
# PanguHooker — hook android.content.res.Resources#getString(int)
# 在返回前对中英文之间插入空格(盘古之白)
# 用法:
#   Object intercept(Chain chain):
#     Object raw = chain.proceed();
#     if (raw == null) return null;
#     if (!(raw instanceof String)) return raw;   // 非 String 不处理
#     String orig = (String) raw;
#     String result = Pangu.pangu(orig);
#     if (!result.equals(orig)) Log.d(TAG, "PANGU: [orig] -> [result]");
#     return result;
# ============================================================
# ⚠️ smali 寄存器规则: .registers N = locals + params
#   intercept(Chain) 是 this 上的虚方法, 非静态
#   参数: this(p0) + Chain(p1) = 2 个参数寄存器
#   .registers = 6: locals = v0-v3 (4个), params = p0=this, p1=chain
#   v0 = proceed() 原始返回值(Object)
#   v1 = pangu 处理结果(String)
#   v2/v3 = 临时
# ⚠️ 类型安全(踩坑): proceed() 返回 Object, 调用 pangu(String) 前
#   必须 check-cast 成 String, 否则 ART VerifyError(本类曾因此加载失败)
# ============================================================
.class public Lcom/vstory/hook/rikkahub/MainHook$PanguHooker;
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
# Object intercept(Chain chain) -> 简体中文判断 -> Pangu.pangu((String) chain.proceed())
.method public intercept(Lio/github/libxposed/api/XposedInterface$Chain;)Ljava/lang/Object;
    .registers 12

    # Object raw = chain.proceed();
    invoke-interface {p1}, Lio/github/libxposed/api/XposedInterface$Chain;->proceed()Ljava/lang/Object;

    move-result-object v0

    # if (raw == null) return null;
    if-eqz v0, :ret_orig

    # 安全防护: 若非 String 直接返回原值(不处理非字符串)
    instance-of v2, v0, Ljava/lang/String;

    if-eqz v2, :ret_orig

    # ⚠️ 简体中文判断(方案A): 只有语言=zh 且 地区!=TW/HK/MO 才处理(繁体/英文不处理)
    #   zh / zh-CN / zh-SG 等无繁体地区 → 处理; zh-TW/HK/MO → 不处理; 英文 → 本就不变
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    # String lang = locale.getLanguage();
    invoke-virtual {v2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    # if (!lang.equals("zh")) return orig;  (非中文不处理)
    const-string v4, "zh"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :ret_orig

    # String country = locale.getCountry();  (排除繁体地区)
    invoke-virtual {v2}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    # if (country.equals("TW")) return orig;
    const-string v4, "TW"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :ret_orig

    # if (country.equals("HK")) return orig;
    const-string v4, "HK"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :ret_orig

    # if (country.equals("MO")) return orig;
    const-string v4, "MO"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :ret_orig

    # String orig = (String) raw;
    check-cast v0, Ljava/lang/String;

    # String result = Pangu.pangu(orig);
    invoke-static {v0}, Lcom/vstory/hook/rikkahub/Pangu;->pangu(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    #ifdef DEBUG
    # ============================================================
    # 盘古拦截值 debug 日志 (equals 判断 + 拼串 + Debug.d)
    #   ⚠️ 规范调试块: toggle_debug.sh off 整块注释 / on 恢复, 零遗漏
    #   每次盘古改文案都打 "PANGU: [orig] -> [result]"
    # ============================================================
    # if (!result.equals(orig)) Log.d(TAG, "PANGU: [orig] -> [result]")
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :skip_log

    # Log.i("RikkaTune", "PANGU: " + orig + " -> " + result)
    const-string v2, "RikkaTune"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "PANGU: ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "] -> ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    # ⚠️ 调试值日志(拦截结果) — 双通道: LSPosed 框架 + logcat 都可见
    invoke-static {v2, v3}, Lcom/vstory/hook/rikkahub/Debug;->d(Ljava/lang/String;Ljava/lang/String;)V

    #endif
    :skip_log
    return-object v1

    :ret_orig
    return-object v0
.end method
