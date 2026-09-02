package com.vstory.hook.rikkahub;

/**
 * 盘古之白：中文与英文/数字之间自动插入空格。
 * <p>
 * 规则：
 * - CJK 基本区(0x4E00-0x9FFF) / A区(0x3400-0x4DBF) / 兼容(0xF900-0xFAFF)
 * - 只处理简体中文（Locale=zh 且地区≠TW/HK/MO）
 * - 排除 String.format 占位符（%s/%d/%1$s 等）
 */
public class Pangu {

    public static boolean isCJK(int c) {
        return (c >= 0x4E00 && c <= 0x9FFF)
            || (c >= 0x3400 && c <= 0x4DBF)
            || (c >= 0xF900 && c <= 0xFAFF);
    }

    public static boolean isAlnum(int c) {
        return (c >= 'a' && c <= 'z')
            || (c >= 'A' && c <= 'Z')
            || (c >= '0' && c <= '9');
    }

    /**
     * 判断 index 处字符是否位于 String.format 占位符的"非起点"部分。
     * 从 index 往前扫，找最近的 '%'；若其间全是允许字符（数字/＄/. ／-/+ 空格），则 true。
     */
    public static boolean inFormat(int index, String text) {
        if (index < 0 || text == null || index >= text.length() || text.length() == 0)
            return false;
        if (index == 0) return text.charAt(0) == '%';
        for (int j = index - 1; j >= 0; j--) {
            char c = text.charAt(j);
            if (c == '%') return true;
            if (Character.isDigit(c) || c == '$' || c == '.' || c == '-' || c == '+' || c == ' ')
                continue;
            return false;
        }
        return false;
    }

    /**
     * 主入口：中英文之间插入空格，null/空输入原样返回。
     */
    public static String pangu(String text) {
        if (text == null) return null;
        int len = text.length();
        if (len == 0) return text;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < len; i++) {
            char c = text.charAt(i);
            sb.append(c);
            if (i + 1 < len) {
                char nxt = text.charAt(i + 1);
                if ((isCJK(c) && isAlnum(nxt)) || (isAlnum(c) && isCJK(nxt))) {
                    if (!inFormat(i, text)) {
                        sb.append(' ');
                    }
                }
            }
        }
        return sb.toString();
    }
}
