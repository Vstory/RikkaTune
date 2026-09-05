package com.vstory.hook.rikkahub;

import android.content.Context;
import android.content.SharedPreferences;








public class Prefs {

    public static final String PREFS_GROUP = "rikka_config";
    public static final String KEY_PANGU        = "pangu_enabled";
    public static final String KEY_ASR_SOUND    = "asr_sound_muted";
    public static final String KEY_HAPTIC       = "haptic_boost";
    public static final String KEY_COMPRESS     = "compress_feedback";
    public static final String KEY_NAV_MODE        = "nav_btn_mode";
    public static final String KEY_NAV_SENSITIVITY = "nav_btn_sensitivity";

    private static final String LOCAL_PREFS_NAME = "rikka_config_local";


    private static SharedPreferences sPrefs;

    private static Context sUiContext;




    public static void init(SharedPreferences prefs) {
        sPrefs = prefs;
        Debug.d("RikkaTunePrefs", prefs == null
            ? "init: prefs=null (未绑定/连不上框架) -> 全部默认开"
            : "init: 已绑定 prefs, 当前值 pangu=" + prefs.getBoolean(KEY_PANGU, true)
              + " asrSound=" + prefs.getBoolean(KEY_ASR_SOUND, true)
              + " haptic=" + prefs.getBoolean(KEY_HAPTIC, true)
              + " compress=" + prefs.getBoolean(KEY_COMPRESS, true)
              + " navMode=" + prefs.getInt(KEY_NAV_MODE, 0)
              + " navThresh=" + prefs.getInt(KEY_NAV_SENSITIVITY, 5));
    }


    public static void init(Context context) {
        sUiContext = context.getApplicationContext();
        sPrefs = sUiContext.getSharedPreferences(LOCAL_PREFS_NAME, Context.MODE_PRIVATE);
        Debug.d("RikkaTunePrefs", "init(Context): 使用本地 fallback prefs");
    }


    public static void initService(io.github.libxposed.service.XposedService service) {
        sPrefs = service.getRemotePreferences(PREFS_GROUP);
        Debug.d("RikkaTunePrefs", "initService: 已切到 RemotePreferences");
    }



    private static boolean get(String key, boolean def) {
        return sPrefs != null ? sPrefs.getBoolean(key, def) : def;
    }

    private static int getInt(String key, int def) {
        return sPrefs != null ? sPrefs.getInt(key, def) : def;
    }

    public static boolean isPanguEnabled()     { return get(KEY_PANGU,    true); }
    public static boolean isAsrSoundMuted()    { return get(KEY_ASR_SOUND, true); }
    public static boolean isHapticBoost()      { return get(KEY_HAPTIC,   true); }
    public static boolean isCompressFeedback() { return get(KEY_COMPRESS,  true); }


    public static int navMode() { return getInt(KEY_NAV_MODE, 0); }


    public static int navSensitivity() { return getInt(KEY_NAV_SENSITIVITY, 5); }


    public static void putBoolean(String key, boolean value) {
        if (sPrefs != null) {
            sPrefs.edit().putBoolean(key, value).apply();
        }
    }


    public static void putInt(String key, int value) {
        if (sPrefs != null) {
            sPrefs.edit().putInt(key, value).apply();
        }
    }


    public static SharedPreferences current() { return sPrefs; }
}
