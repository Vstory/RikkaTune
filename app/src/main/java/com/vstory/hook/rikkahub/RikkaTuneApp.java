package com.vstory.hook.rikkahub;

import android.app.Application;

import io.github.libxposed.service.XposedService;
import io.github.libxposed.service.XposedServiceHelper;

/**
 * 进程级 XposedService 连接器（修复死面板）。
 * <p>
 * 机制参照 AppErrors 的 AppErrorsApplication：
 * - onCreate: registerListener + init 本地 fallback prefs
 * - onServiceBind: initService(remote prefs) + 转发给 Activity
 * - onServiceDied: 回退本地 fallback
 */
public class RikkaTuneApp extends Application implements XposedServiceHelper.OnServiceListener {

    /** 当前打开的控制面板 Activity（转发 binder 用，onDestroy 清空） */
    public static RikkaTuneActivity sUi;

    /** 当前活跃的 XposedService（UI 连接状态指示） */
    public static XposedService sService;

    @Override
    public void onCreate() {
        super.onCreate();
        // ① 进程级注册 XposedService（只注册一次，覆盖所有 Activity 实例）
        XposedServiceHelper.registerListener(this);
        // ② 本地 fallback prefs 立即可用（service 未连接时 UI 也能读写，重开不丢）
        Prefs.init(this);
        Debug.d("RikkaTuneApp", "onCreate: registerListener + init(Context) 完成");
    }

    @Override
    public void onServiceBind(XposedService service) {
        sService = service;
        // 切到 RemotePreferences（跨进程同步，hook 侧读同一份）
        Prefs.initService(service);
        // 转发给当前 UI（如有）
        if (sUi != null) {
            sUi.onServiceBind(service);
        }
        Debug.d("RikkaTuneApp", "onServiceBind: 框架已连接，prefs 已切到 RemotePreferences");
    }

    @Override
    public void onServiceDied(XposedService service) {
        sService = null;
        // 回退本地（UI 仍可读写，hook 侧降级到默认值）
        Prefs.init(this);
        if (sUi != null) {
            sUi.onServiceDied(service);
        }
        Debug.d("RikkaTuneApp", "onServiceDied: 框架断开，回退本地 prefs");
    }
}
