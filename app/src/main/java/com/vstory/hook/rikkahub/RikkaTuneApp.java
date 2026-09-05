package com.vstory.hook.rikkahub;

import android.app.Application;

import io.github.libxposed.service.XposedService;
import io.github.libxposed.service.XposedServiceHelper;









public class RikkaTuneApp extends Application implements XposedServiceHelper.OnServiceListener {


    public static RikkaTuneActivity sUi;


    public static XposedService sService;

    @Override
    public void onCreate() {
        super.onCreate();

        XposedServiceHelper.registerListener(this);

        Prefs.init(this);
        Debug.d("RikkaTuneApp", "onCreate: registerListener + init(Context) 完成");
    }

    @Override
    public void onServiceBind(XposedService service) {
        sService = service;

        Prefs.initService(service);

        if (sUi != null) {
            sUi.onServiceBind(service);
        }
        Debug.d("RikkaTuneApp", "onServiceBind: 框架已连接，prefs 已切到 RemotePreferences");
    }

    @Override
    public void onServiceDied(XposedService service) {
        sService = null;

        Prefs.init(this);
        if (sUi != null) {
            sUi.onServiceDied(service);
        }
        Debug.d("RikkaTuneApp", "onServiceDied: 框架断开，回退本地 prefs");
    }
}
