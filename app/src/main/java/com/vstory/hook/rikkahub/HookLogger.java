package com.vstory.hook.rikkahub;








public interface HookLogger {
    void logD(String tag, String msg);
    void logD(String tag, String msg, Throwable tr);
}
