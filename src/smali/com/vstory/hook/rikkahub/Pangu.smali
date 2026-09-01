.class public Lcom/vstory/hook/rikkahub/Pangu;
.super Ljava/lang/Object;
.method public static isCJK(I)Z
    .registers 3
    const v0, 0x4E00
    if-ge p0, v0, :ck_main_lo
    goto :ck_a
    :ck_main_lo
    const v0, 0x9FFF
    if-le p0, v0, :ret_true
    :ck_a
    const v0, 0x3400
    if-ge p0, v0, :ck_a_lo
    goto :ck_b
    :ck_a_lo
    const v0, 0x4DBF
    if-le p0, v0, :ret_true
    :ck_b
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
.method public static isAlnum(I)Z
    .registers 3
    const v0, 0x61
    if-ge p0, v0, :al_lo
    goto :al_upper
    :al_lo
    const v0, 0x7A
    if-le p0, v0, :ret_true
    :al_upper
    const v0, 0x41
    if-ge p0, v0, :au_lo
    goto :al_digit
    :au_lo
    const v0, 0x5A
    if-le p0, v0, :ret_true
    :al_digit
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
.method public static inFormat(ILjava/lang/String;)Z
    .registers 8
    if-ltz p0, :ret_false
    invoke-virtual {p1}, Ljava/lang/String;->length()I
    move-result v1
    if-ge p0, v1, :ret_false
    if-eqz v1, :ret_false
    const/16 v4, 0x25
    const/16 v5, 0x20
    move v0, p0
    if-eqz v0, :check_self
    add-int/lit8 v0, v0, -0x1
    :scan_loop
    if-ltz v0, :ret_false
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C
    move-result v2
    if-eq v2, v4, :ret_true
    const/16 v3, 0x30
    if-ge v2, v3, :chk_digit_lo
    goto :chk_special
    :chk_digit_lo
    const/16 v3, 0x39
    if-le v2, v3, :continue_scan
    :chk_special
    const/16 v3, 0x24
    if-eq v2, v3, :continue_scan
    const/16 v3, 0x2E
    if-eq v2, v3, :continue_scan
    const/16 v3, 0x2D
    if-eq v2, v3, :continue_scan
    const/16 v3, 0x2B
    if-eq v2, v3, :continue_scan
    if-eq v2, v5, :continue_scan
    goto :ret_false
    :continue_scan
    add-int/lit8 v0, v0, -0x1
    goto :scan_loop
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
.method public static pangu(Ljava/lang/String;)Ljava/lang/String;
    .registers 10
    if-eqz p0, :ret_null
    invoke-virtual {p0}, Ljava/lang/String;->length()I
    move-result v1
    if-eqz v1, :ret_orig
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const/16 v7, 0x20
    const/4 v3, 0x0
    :loop
    if-ge v3, v1, :done
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C
    move-result v4
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    add-int/lit8 v8, v3, 0x1
    if-ge v8, v1, :continue
    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C
    move-result v5
    invoke-static {v4}, Lcom/vstory/hook/rikkahub/Pangu;->isCJK(I)Z
    move-result v6
    if-eqz v6, :check_reverse
    invoke-static {v5}, Lcom/vstory/hook/rikkahub/Pangu;->isAlnum(I)Z
    move-result v6
    if-eqz v6, :check_reverse
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :continue
    :check_reverse
    invoke-static {v4}, Lcom/vstory/hook/rikkahub/Pangu;->isAlnum(I)Z
    move-result v6
    if-eqz v6, :continue
    invoke-static {v5}, Lcom/vstory/hook/rikkahub/Pangu;->isCJK(I)Z
    move-result v6
    if-eqz v6, :continue
    invoke-static {v3, p0}, Lcom/vstory/hook/rikkahub/Pangu;->inFormat(ILjava/lang/String;)Z
    move-result v6
    if-nez v6, :continue
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :continue
    add-int/lit8 v3, v3, 0x1
    goto :loop
    :done
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
    :ret_orig
    return-object p0
    :ret_null
    const/4 v0, 0x0
    return-object v0
.end method
