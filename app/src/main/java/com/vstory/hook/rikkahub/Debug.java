package com.vstory.hook.rikkahub;







public class Debug {


    public static HookLogger sLogger;






    public static void d(String tag, String msg) {
        if (BuildConfig.DEBUG) {
            if (sLogger != null) sLogger.logD(tag, msg);
            android.util.Log.i(tag, msg);
        }
    }

    public static void d(String tag, String msg, Throwable tr) {
        if (BuildConfig.DEBUG) {
            if (sLogger != null) sLogger.logD(tag, msg, tr);
            android.util.Log.i(tag, msg);
        }
    }
}
