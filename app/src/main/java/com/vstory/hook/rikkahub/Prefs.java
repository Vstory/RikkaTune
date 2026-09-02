package com.vstory.hook.rikkahub;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * 配置存储：UI 控制面板开关 ↔ hook 侧读取。
 * <p>
 * hook 侧: Prefs.init(getRemotePreferences("rikka_config")) — 只读 RemotePreferences。
 * UI 侧:   Prefs.initService(service) — 切到可写 RemotePreferences；
 *          若 service 未连接则 Prefs.init(context) 走本地 SharedPreferences。
 */
public class Prefs {

    public static final String PREFS_GROUP = "rikka_config";
    public static final String KEY_PANGU        = "pangu_enabled";
    public static final String KEY_ASR_SOUND    = "asr_sound_muted";
    public static final String KEY_HAPTIC       = "haptic_boost";
    public static final String KEY_COMPRESS     = "compress_feedback";

    private static final String LOCAL_PREFS_NAME = "rikka_config_local";

    /** 当前生效存储（hook 侧 = remote 只读；UI 侧 = remote 可写 或 本地） */
    private static SharedPreferences sPrefs;

    private static Context sUiContext;

    // ===== 初始化 =====

    /** hook 侧初始化（remote 只读） */
    public static void init(SharedPreferences prefs) {
        sPrefs = prefs;
        Debug.d("RikkaTunePrefs", prefs == null
            ? "init: prefs=null (未绑定/连不上框架) -> 全部默认开"
            : "init: 已绑定 prefs, 当前值 pangu=" + prefs.getBoolean(KEY_PANGU, true)
              + " asrSound=" + prefs.getBoolean(KEY_ASR_SOUND, true)
              + " haptic=" + prefs.getBoolean(KEY_HAPTIC, true)
              + " compress=" + prefs.getBoolean(KEY_COMPRESS, true));
    }

    /** UI 侧本地 fallback 初始化（service 未连接时用） */
    public static void init(Context context) {
        sUiContext = context.getApplicationContext();
        sPrefs = sUiContext.getSharedPreferences(LOCAL_PREFS_NAME, Context.MODE_PRIVATE);
        Debug.d("RikkaTunePrefs", "init(Context): 使用本地 fallback prefs");
    }

    /** UI 侧切到 RemotePreferences（service 连接后调） */
    public static void initService(io.github.libxposed.service.XposedService service) {
        sPrefs = service.getRemotePreferences(PREFS_GROUP);
        Debug.d("RikkaTunePrefs", "initService: 已切到 RemotePreferences");
    }

    // ===== 读开关 =====

    private static boolean get(String key, boolean def) {
        return sPrefs != null ? sPrefs.getBoolean(key, def) : def;
    }

    public static boolean isPanguEnabled()     { return get(KEY_PANGU,    true); }
    public static boolean isAsrSoundMuted()    { return get(KEY_ASR_SOUND, true); }
    public static boolean isHapticBoost()      { return get(KEY_HAPTIC,   true); }
    public static boolean isCompressFeedback() { return get(KEY_COMPRESS,  true); }

    /** UI 侧写入 */
    public static void putBoolean(String key, boolean value) {
        if (sPrefs != null) {
            sPrefs.edit().putBoolean(key, value).apply();
        }
    }

    /** UI 侧读取（用于开关初始状态刷新） */
    public static SharedPreferences current() { return sPrefs; }
}
