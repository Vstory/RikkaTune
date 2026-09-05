package com.vstory.hook.rikkahub;









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
