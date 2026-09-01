#
# ============================================================
# Pangu.smali — 盘古之白（中英文之间加空格）处理工具类
# 用途: RikkaHub UI 中文文案里 中文↔英文/数字 交界处插入空格
# 原则:
#   - 只针对中文修改, 不改其它语言文本
#   - 中文(CJK) 与 英文字母/数字 之间插入空格
#   - 不处理 中文↔标点/符号（如 "200+模型" 中 +模型 不加空格, 按标准盘古之白）
# 方法:
#   - isCJK(int)Z → 判断是否中文字符(码点)
#   - isAlnum(int)Z → 判断是否英文字母/数字
#   - pangu(String)Ljava/lang/String;  → 处理入口(静态)
# ============================================================
# ⚠️ smali 寄存器规则: .registers N = locals + params
#   本方法参数 (String) 有 1 个参数寄存器 p0。
#   若 .registers = 10: locals=v0-v8 (9个), param=p0(即v9)
#   ⚠️ 严禁用 v9/v8 等会映射到 p0 的寄存器存临时值(会覆盖参数字符串!)
#   本方法统一用 v0-v4 做局部寄存器, p0 始终保留为字符串引用。
.class public Lcom/vstory/hook/rikkahub/Pangu;
.super Ljava/lang/Object;

# 判断是否中文字符(CJK 统一表意文字)
# param: int code (字符码点)
# return: Z (1=是中文, 0=否)
.method public static isCJK(I)Z
    .registers 3

    # 在范围内返回 true
    # (0x4E00 <= c <= 0x9FFF) || (0x3400 <= c <= 0x4DBF) || (0xF900 <= c <= 0xFAFF)

    # if (c >= 0x4E00 && c <= 0x9FFF) → 基本区
    const v0, 0x4E00
    if-ge p0, v0, :ck_main_lo
    goto :ck_a

    :ck_main_lo
    const v0, 0x9FFF
    if-le p0, v0, :ret_true

    :ck_a
    # A 区: 0x3400-0x4DBF
    const v0, 0x3400
    if-ge p0, v0, :ck_a_lo
    goto :ck_b

    :ck_a_lo
    const v0, 0x4DBF
    if-le p0, v0, :ret_true

    :ck_b
    # B 区(兼容): 0xF900-0xFAFF
    const v0, 0xF900
    if-ge p0, v0, :ck_b_lo
    goto :ret_false

    :ck_b_lo
    const v0, 0xFAFF
    if-le p0, v0, :ret_true
    goto :ret_false

    :ret_true
    const/4 v0, 0x1
    return v0

    :ret_false
    const/4 v0, 0x0
    return v0
.end method

# 判断是否英文字母/数字
# param: int code
# return: Z
.method public static isAlnum(I)Z
    .registers 3

    # 'a' <= c <= 'z' || 'A' <= c <= 'Z' || '0' <= c <= '9'
    # 字母小写: 0x61-0x7A
    const v0, 0x61
    if-ge p0, v0, :al_lo
    goto :al_upper

    :al_lo
    const v0, 0x7A
    if-le p0, v0, :ret_true

    :al_upper
    # 字母大写: 0x41-0x5A
    const v0, 0x41
    if-ge p0, v0, :au_lo
    goto :al_digit

    :au_lo
    const v0, 0x5A
    if-le p0, v0, :ret_true

    :al_digit
    # 数字: 0x30-0x39
    const v0, 0x30
    if-ge p0, v0, :ad_lo
    goto :ret_false

    :ad_lo
    const v0, 0x39
    if-le p0, v0, :ret_true
    goto :ret_false

    :ret_true
    const/4 v0, 0x1
    return v0

    :ret_false
    const/4 v0, 0x0
    return v0
.end method

# 判断 index 处字符是否位于 String.format 格式占位符的"非起点"部分
# 用途: 排除 %s/%d/%1$s/%.2f 等占位符，避免在 占位符<->中文 之间误加空格
# 规则: 从 index 往前扫，找离它最近的 '%'
#   若 '%' 与 index 之间全是允许的占位符组成字符(数字 0-9 / '$' / '.' / '-' / '+' / 空格)
#   则 index 属于该占位符 -> true；否则 false
#   若 index 本身越界 -> false；若 findIndex<=0 时即为 '%' 附近 -> 处理
# param: int index, String text
# return: Z
.method public static inFormat(ILjava/lang/String;)Z
    .registers 8

    # 寄存器: p0=index, p1=text
    #   v0 = 扫描位置 j
    #   v1 = text 长度
    #   v2 = 当前字符 c
    #   v3 = 常量/临时
    #   v4 = '%' (0x25)
    #   v5 = 空格 (0x20)

    # if (index < 0) return false
    if-ltz p0, :ret_false

    # len = text.length()
    invoke-virtual {p1}, Ljava/lang/String;->length()I
    move-result v1

    # if (index >= len) return false
    if-ge p0, v1, :ret_false

    # if (len == 0) return false
    if-eqz v1, :ret_false

    const/16 v4, 0x25    # '%'
    const/16 v5, 0x20    # ' '

    # 起点: j = index ; 先判断 index 处本身
    move v0, p0

    # 若 index==0: 只有 text[0]=='%' 才算占位符起点（此时 index 在 % 上，后续转换符才会加空格）
    #   但这里 index==0 若为 '%'，说明这是占位符起点，属于"占位符内"
    if-eqz v0, :check_self

    # 从 j=index-1 开始往前扫描
    add-int/lit8 v0, v0, -0x1

    :scan_loop
    # if (j < 0) -> 没找到 '%'，false
    if-ltz v0, :ret_false

    # char c = text.charAt(j)
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C
    move-result v2

    # if (c == '%') return true   找到占位符起点
    if-eq v2, v4, :ret_true

    # 判断 c 是否"允许作为占位符内部字符"
    #   允许: 数字 0x30-0x39, '$' 0x24, '.' 0x2E, '-' 0x2D, '+' 0x2B, 空格 0x20
    #   若允许 -> 继续往前扫
    #   若不允许 -> 说明 index 不属于这个 % 占位符，返回 false

    # 数字
    const/16 v3, 0x30
    if-ge v2, v3, :chk_digit_lo
    goto :chk_special
    :chk_digit_lo
    const/16 v3, 0x39
    if-le v2, v3, :continue_scan

    :chk_special
    const/16 v3, 0x24   # '$'
    if-eq v2, v3, :continue_scan
    const/16 v3, 0x2E   # '.'
    if-eq v2, v3, :continue_scan
    const/16 v3, 0x2D   # '-'
    if-eq v2, v3, :continue_scan
    const/16 v3, 0x2B   # '+'
    if-eq v2, v3, :continue_scan
    if-eq v2, v5, :continue_scan   # 空格

    # 遇到不允许字符 -> 不是占位符
    goto :ret_false

    :continue_scan
    add-int/lit8 v0, v0, -0x1
    goto :scan_loop

    # 检查 index==0 自身上下文（此时只需看 charAt(0)）
    :check_self
    invoke-virtual {p1, p0}, Ljava/lang/String;->charAt(I)C
    move-result v2
    if-eq v2, v4, :ret_true
    goto :ret_false

    :ret_true
    const/4 v0, 0x1
    return v0

    :ret_false
    const/4 v0, 0x0
    return v0
.end method


# 主入口: 盘古之白处理
# param: String text (可能 null)
# return: String (处理后的文本, null 输入返回 null)
.method public static pangu(Ljava/lang/String;)Ljava/lang/String;
    .registers 10

    # 寄存器分配 (.registers 10, 1 个参数寄存器 p0=String):
    #   v0 = 返回值/StringBuilder 结果
    #   v1 = len (字符串长度)
    #   v2 = StringBuilder 实例
    #   v3 = 循环计数器 i
    #   v4 = 当前字符 c
    #   v5 = 下一个字符 nxt
    #   v6 = isCJK/isAlnum 结果
    #   v7 = 空格常量 (0x20)
    #   v8 = 临时（偏移/辅助）
    #   p0 = 参数字符串 (⚠️ 全程不覆盖!)

    # if (text == null) return null
    if-eqz p0, :ret_null

    # int len = text.length();
    invoke-virtual {p0}, Ljava/lang/String;->length()I
    move-result v1

    # if (len == 0) return text
    if-eqz v1, :ret_orig

    # StringBuilder sb = new StringBuilder();
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    # 空格常量 0x20 (ASCII space)
    const/16 v7, 0x20

    # for (int i = 0; i < len; i++)
    const/4 v3, 0x0
    :loop
    if-ge v3, v1, :done

    # char c = text.charAt(i);
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C
    move-result v4

    # sb.append(c);
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    # if (i + 1 < len)
    add-int/lit8 v8, v3, 0x1
    if-ge v8, v1, :continue

    # char nxt = text.charAt(i+1);
    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C
    move-result v5

    # if (isCJK(c) && isAlnum(nxt)) sb.append(' ');
    invoke-static {v4}, Lcom/vstory/hook/rikkahub/Pangu;->isCJK(I)Z
    move-result v6
    if-eqz v6, :check_reverse

    invoke-static {v5}, Lcom/vstory/hook/rikkahub/Pangu;->isAlnum(I)Z
    move-result v6
    if-eqz v6, :check_reverse

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :continue

    :check_reverse
    # else if (isAlnum(c) && isCJK(nxt)) sb.append(' ');
    invoke-static {v4}, Lcom/vstory/hook/rikkahub/Pangu;->isAlnum(I)Z
    move-result v6
    if-eqz v6, :continue

    invoke-static {v5}, Lcom/vstory/hook/rikkahub/Pangu;->isCJK(I)Z
    move-result v6
    if-eqz v6, :continue

    # ⚠️ 排除 String.format 格式占位符: 若 c(当前字符 index=i) 处于 %s/%d/%1$s 等占位符内,
    #    则不加空格(否则 %1$s无法访问 会误处理成 %1$s 无法访问)
    invoke-static {v3, p0}, Lcom/vstory/hook/rikkahub/Pangu;->inFormat(ILjava/lang/String;)Z
    move-result v6
    if-nez v6, :continue

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :continue
    add-int/lit8 v3, v3, 0x1
    goto :loop

    :done
    # return sb.toString();
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0

    :ret_orig
    return-object p0

    :ret_null
    const/4 v0, 0x0
    return-object v0
.end method
