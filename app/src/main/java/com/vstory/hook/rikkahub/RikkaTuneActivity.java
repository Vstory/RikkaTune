package com.vstory.hook.rikkahub;

import android.app.Activity;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.Gravity;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.Switch;
import android.widget.TextView;

import io.github.libxposed.service.XposedService;

/**
 * 控制面板 Activity（纯代码 UI，无 XML）。
 * <p>
 * 设计参照 AppErrors 的 DebugActivity：先 setChecked 再注册 listener，避免代码触发误保存。
 * 本地 fallback + RemotePreferences 双保险，开关状态永不丢。
 */
public class RikkaTuneActivity extends Activity {

    private SharedPreferences mRemotePrefs;
    private TextView mStatus;
    private Switch mSwPangu, mSwAsr, mSwHaptic, mSwCompress;
    private RadioGroup mRadioNav;
    private TextView mTvModeDesc;
    private SeekBar mSeekSens;
    private LinearLayout mNavSensRow;
    private TextView mTvSensValue, mTvSensDesc;
    private boolean mRefreshing;

    private static final String[] NAV_MODE_NAMES = { "智能", "常驻", "原版" };
    private static final String[] NAV_MODE_DESCS = {
        "滚动才显示：滑过足量消息才出现，轻滑不打扰（推荐）",
        "始终显示在聊天页（尊重 RikkaHub 开关）",
        "恢复 RikkaHub 原生逻辑（不干预）"
    };
    /** 滚动显示阈值（智能模式，无级）：滑过 ≥N 条消息才显示导航按钮 */
    private static final int NAV_THRESHOLD_MIN = 1;
    private static final int NAV_THRESHOLD_MAX = 20;

    /** 连上框架后 Application 转发调用（⚠️ binder 线程回调 → UI 操作必须切主线程，否则 Switch.setChecked 动画崩） */
    public void onServiceBind(XposedService service) {
        mRemotePrefs = service.getRemotePreferences(Prefs.PREFS_GROUP);
        runOnUiThread(() -> {
            refreshSwitches();
            enableControls(true);
            showStatus("已连接框架：设置即时生效", "#4CAF50");
            Debug.d("RikkaTuneUI", "onServiceBind: 已连接，prefs=" + mRemotePrefs);
        });
    }

    /** 框架断开后 Application 转发调用 */
    public void onServiceDied(XposedService service) {
        mRemotePrefs = null;
        runOnUiThread(() -> {
            enableControls(false);
            showStatus("框架连接断开，开关已锁定", "#EF5350");
            Debug.d("RikkaTuneUI", "onServiceDied: 框架断开");
        });
    }

    /**
     * 连接态总闸：框架未连接时控件禁用（防"点了没写/显示与生效不符"的假状态），
     * 连接后启用并刷新为框架真实值。SeekBar 额外受智能模式子控制（applyNavModeUi）。
     */
    private void enableControls(boolean on) {
        mSwPangu.setEnabled(on);
        mSwAsr.setEnabled(on);
        mSwHaptic.setEnabled(on);
        mSwCompress.setEnabled(on);
        mRadioNav.setEnabled(on);
        mSeekSens.setEnabled(on);
        if (on) applyNavModeUi(mRadioNav.getCheckedRadioButtonId()); // 再按模式收口 SeekBar
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Debug.d("RikkaTuneUI", "onCreate: 控制面板启动");
        buildUi();
        // 注册到 Application（binder 到达时转发给我）
        RikkaTuneApp.sUi = this;
        // 只有 onServiceBind 真正到达后 mRemotePrefs 才有效
        // 如果 Application 已经收到过 binder（Activity 重建），直接复用
        if (RikkaTuneApp.sService != null) {
            onServiceBind(RikkaTuneApp.sService);
        } else {
            enableControls(false);           // 未连框架：控件锁定，防假状态
            showStatus("正在连接 LSPosed 框架…", "#FFA726");
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // 清空 Application 转发指向（防止 binder 后到转发给已销毁 Activity）
        if (RikkaTuneApp.sUi == this) RikkaTuneApp.sUi = null;
    }

    // ===== UI 构建 =====

    private void buildUi() {
        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        int pad = dp(20);
        root.setPadding(pad, dp(12), pad, 0);

        // 标题（与各功能标题统一主题主色）
        TextView tvTitle = new TextView(this);
        tvTitle.setText("RikkaTune");
        tvTitle.setTextSize(24f);
        tvTitle.setTypeface(null, Typeface.BOLD);
        tvTitle.setTextColor(textPrimary());
        root.addView(tvTitle);

        // 副标题
        TextView tvSub = new TextView(this);
        tvSub.setText("RikkaHub UI 调校 · 开关即存即生效（无需重启）");
        tvSub.setTextColor(textSecondary());
        tvSub.setTextSize(13f);
        root.addView(tvSub);

        // 状态行
        mStatus = new TextView(this);
        mStatus.setText("正在连接 LSPosed 框架…");
        mStatus.setTextColor(Color.parseColor("#FFA726"));
        mStatus.setTextSize(13f);
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        lp.topMargin = dp(8);
        mStatus.setLayoutParams(lp);
        root.addView(mStatus);

        // 开关行
        mSwPangu   = addSwitchRow(root, "盘古之白（中文排版）", "UI 中文文案 中文↔英文/数字 交界处自动插入空格", Prefs.KEY_PANGU);
        mSwAsr     = addSwitchRow(root, "消除语音输入提示音", "去掉语音输入 开始/结束 的提示音", Prefs.KEY_ASR_SOUND);
        mSwHaptic  = addSwitchRow(root, "语音振动增强", "语音输入 开始/结束 的弱振动替换成强振动反馈", Prefs.KEY_HAPTIC);
        mSwCompress= addSwitchRow(root, "压缩对话反馈", "压缩对话历史 成功/失败 时 Toast+通知+振动提示", Prefs.KEY_COMPRESS);

        // ---------- 消息导航按钮控制（⑦ Kelivo 式显隐） ----------
        addSectionTitle(root, "消息导航按钮控制");
        addHintText(root, "控制聊天页右缘滚动导航按钮（回顶/上一条/下一条/回底）的显示时机。"
            + "RikkaHub 自身设置仍为总开关");

        mRadioNav = new RadioGroup(this);
        mRadioNav.setOrientation(LinearLayout.HORIZONTAL);
        LinearLayout.LayoutParams rgLp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        rgLp.topMargin = dp(8);
        mRadioNav.setLayoutParams(rgLp);
        for (int i = 0; i < NAV_MODE_NAMES.length; i++) {
            RadioButton rb = new RadioButton(this);
            rb.setId(i);
            rb.setText(NAV_MODE_NAMES[i]);
            rb.setTextSize(14f);
            mRadioNav.addView(rb, new RadioGroup.LayoutParams(0,
                RadioGroup.LayoutParams.WRAP_CONTENT, 1f));
        }
        root.addView(mRadioNav);
        mRadioNav.setOnCheckedChangeListener(mNavModeListener);

        // 当前模式说明
        mTvModeDesc = new TextView(this);
        mTvModeDesc.setTextColor(textSecondary());
        mTvModeDesc.setTextSize(12f);
        mTvModeDesc.setLayoutParams(new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
        root.addView(mTvModeDesc);

        // 灵敏度行（仅"滚动"模式生效）
        mNavSensRow = new LinearLayout(this);
        mNavSensRow.setOrientation(LinearLayout.VERTICAL);
        LinearLayout.LayoutParams sensLp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        sensLp.topMargin = dp(14);
        mNavSensRow.setLayoutParams(sensLp);

        LinearLayout sensHead = new LinearLayout(this);
        sensHead.setOrientation(LinearLayout.HORIZONTAL);
        sensHead.setGravity(Gravity.CENTER_VERTICAL);
        sensHead.setLayoutParams(new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
        TextView tvSensTitle = new TextView(this);
        tvSensTitle.setText("滚动显示阈值");
        tvSensTitle.setTextSize(15f);
        sensHead.addView(tvSensTitle, new LinearLayout.LayoutParams(
            0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f));
        mTvSensValue = new TextView(this);
        mTvSensValue.setTextColor(textPrimary());
        mTvSensValue.setTextSize(13f);
        mTvSensValue.setTypeface(null, Typeface.BOLD);
        sensHead.addView(mTvSensValue);
        mNavSensRow.addView(sensHead);

        mTvSensDesc = new TextView(this);
        mTvSensDesc.setTextColor(textSecondary());
        mTvSensDesc.setTextSize(12f);
        LinearLayout.LayoutParams dLp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        dLp.topMargin = dp(2);
        mTvSensDesc.setLayoutParams(dLp);
        mNavSensRow.addView(mTvSensDesc);

        mSeekSens = new SeekBar(this);
        mSeekSens.setMax(NAV_THRESHOLD_MAX - 1);   // 无级 1..20 条
        mNavSensRow.addView(mSeekSens, new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
        mSeekSens.setOnSeekBarChangeListener(mSeekListener);
        root.addView(mNavSensRow);

        // 默认选中"智能 / 5 条"（所有控件已创建；连接后 refreshSwitches 覆盖为框架真实值）
        mRefreshing = true;
        mRadioNav.check(0);
        mSeekSens.setProgress(4);
        mRefreshing = false;
        updateModeDesc(0);
        updateSensText(4);           // 默认阈值 5 条 → progress=4

        ScrollView sv = new ScrollView(this);
        sv.addView(root);
        setContentView(sv);
    }

    private Switch addSwitchRow(LinearLayout parent, String title, String desc, String key) {
        LinearLayout row = new LinearLayout(this);
        row.setOrientation(LinearLayout.HORIZONTAL);
        row.setGravity(Gravity.CENTER_VERTICAL);
        LinearLayout.LayoutParams rowLp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        rowLp.topMargin = dp(18);
        row.setLayoutParams(rowLp);

        LinearLayout textCol = new LinearLayout(this);
        textCol.setOrientation(LinearLayout.VERTICAL);
        textCol.setLayoutParams(new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f));

        TextView tvTitle = new TextView(this);
        tvTitle.setText(title);
        tvTitle.setTextSize(16f);
        tvTitle.setTextColor(textPrimary());
        textCol.addView(tvTitle);

        TextView tvDesc = new TextView(this);
        tvDesc.setText(desc);
        tvDesc.setTextColor(textSecondary());
        tvDesc.setTextSize(12f);
        textCol.addView(tvDesc);

        row.addView(textCol);

        Switch sw = new Switch(this);
        sw.setTag(key);
        // ⚠️ 先 setChecked 后注册 listener，避免代码触发误保存（参照 AppErrors DebugActivity）
        sw.setOnCheckedChangeListener(mSwitchListener);
        row.addView(sw);
        parent.addView(row);
        return sw;
    }

    // ===== 开关刷新 =====

    private void refreshSwitches() {
        SharedPreferences sp = mRemotePrefs;
        if (sp == null) {
            Debug.d("RikkaTuneUI", "refreshSwitches: prefs=null, 跳过刷新");
            return;
        }
        boolean pangu   = sp.getBoolean(Prefs.KEY_PANGU,   true);
        boolean asr     = sp.getBoolean(Prefs.KEY_ASR_SOUND, true);
        boolean haptic  = sp.getBoolean(Prefs.KEY_HAPTIC,  true);
        boolean compress= sp.getBoolean(Prefs.KEY_COMPRESS, true);
        int navMode = sp.getInt(Prefs.KEY_NAV_MODE, 0);
        int sens    = sp.getInt(Prefs.KEY_NAV_SENSITIVITY, 5);   // 无级阈值 1..20，默认 5 条
        // clamp（兼容旧 1..3 档数据 / 脏值）
        if (sens < NAV_THRESHOLD_MIN) sens = NAV_THRESHOLD_MIN;
        if (sens > NAV_THRESHOLD_MAX) sens = NAV_THRESHOLD_MAX;
        Debug.d("RikkaTuneUI", "从框架读到开关: pangu=" + pangu + " asr=" + asr
            + " haptic=" + haptic + " compress=" + compress
            + " navMode=" + navMode + " navThresh=" + sens);
        mRefreshing = true;
        mSwPangu.setChecked(pangu);
        mSwAsr.setChecked(asr);
        mSwHaptic.setChecked(haptic);
        mSwCompress.setChecked(compress);
        mRadioNav.check(navMode);
        mSeekSens.setProgress(sens - 1);
        mRefreshing = false;
        applyNavModeUi(navMode);
        updateModeDesc(navMode);
        updateSensText(sens - 1);
    }

    // ===== 开关监听器 =====

    private final CompoundButton.OnCheckedChangeListener mSwitchListener =
        (buttonView, isChecked) -> {
            if (mRefreshing) return;
            String key = (String) buttonView.getTag();
            if (mRemotePrefs == null) {
                // 双保险：控件已禁用不应触发；万一触发则回弹，绝不留下"视觉翻/实际没写"的假状态
                mRefreshing = true;
                buttonView.setChecked(!isChecked);
                mRefreshing = false;
                Debug.d("RikkaTuneUI", "开关 " + key + " 未连接框架，回弹");
                return;
            }
            Debug.d("RikkaTuneUI", "开关 " + key + " -> " + isChecked + " 已写入");
            Prefs.putBoolean(key, isChecked);
        };

    // ===== 消息导航按钮控制 =====

    private final RadioGroup.OnCheckedChangeListener mNavModeListener = (group, checkedId) -> {
        if (mRefreshing) return;
        if (mRemotePrefs == null) return;
        if (checkedId < 0 || checkedId >= NAV_MODE_NAMES.length) return;
        Prefs.putInt(Prefs.KEY_NAV_MODE, checkedId);
        applyNavModeUi(checkedId);
        updateModeDesc(checkedId);
        Debug.d("RikkaTuneUI", "导航按钮模式 -> " + NAV_MODE_NAMES[checkedId] + "(" + checkedId + ")");
    };

    private final SeekBar.OnSeekBarChangeListener mSeekListener =
        new SeekBar.OnSeekBarChangeListener() {
            @Override public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (!fromUser || mRefreshing || mRemotePrefs == null) return;
                Prefs.putInt(Prefs.KEY_NAV_SENSITIVITY, progress + 1);
                updateSensText(progress);
                Debug.d("RikkaTuneUI", "导航显示阈值 -> " + (progress + 1) + " 条");
            }
            @Override public void onStartTrackingTouch(SeekBar seekBar) {}
            @Override public void onStopTrackingTouch(SeekBar seekBar) {}
        };

    /** 灵敏度控件仅在"智能"模式可调 */
    private void applyNavModeUi(int mode) {
        boolean sensEnabled = (mode == 0);
        mSeekSens.setEnabled(sensEnabled);
        mNavSensRow.setAlpha(sensEnabled ? 1f : 0.35f);
    }

    /** 刷新当前模式说明文字 */
    private void updateModeDesc(int mode) {
        if (mode < 0 || mode >= NAV_MODE_DESCS.length) return;
        mTvModeDesc.setText(NAV_MODE_DESCS[mode]);
    }

    /** 刷新阈值文字（progress=条数-1，范围 0..NAV_THRESHOLD_MAX-1） */
    private void updateSensText(int progress) {
        if (progress < 0) progress = 0;
        if (progress > NAV_THRESHOLD_MAX - 1) progress = NAV_THRESHOLD_MAX - 1;
        int n = progress + 1;
        mTvSensValue.setText(n + " 条");
        mTvSensDesc.setText("滑过 ≥" + n + " 条消息才显示导航按钮（调大更不易误触）");
    }

    // ===== 工具 =====

    /** 解析主题属性颜色（兼容引用/直色，自动适配亮/暗主题） */
    private int themeColor(int attr) {
        TypedValue tv = new TypedValue();
        if (getTheme().resolveAttribute(attr, tv, true)) {
            if (tv.resourceId != 0) return getColor(tv.resourceId);
            return tv.data;
        }
        return 0xFF000000;
    }

    private int textPrimary()   { return themeColor(android.R.attr.textColorPrimary); }
    private int textSecondary() { return themeColor(android.R.attr.textColorSecondary); }

    private void showStatus(String text, String color) {
        if (mStatus != null) {
            mStatus.setText(text);
            mStatus.setTextColor(Color.parseColor(color));
        }
    }

    /** 小节标题（粗体加大，段前留白；跟随主题主色） */
    private void addSectionTitle(LinearLayout parent, String title) {
        TextView tv = new TextView(this);
        tv.setText(title);
        tv.setTextSize(17f);
        tv.setTypeface(null, Typeface.BOLD);
        tv.setTextColor(textPrimary());
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        lp.topMargin = dp(26);
        tv.setLayoutParams(lp);
        parent.addView(tv);
    }

    /** 小节说明文字（跟随主题次色） */
    private void addHintText(LinearLayout parent, String hint) {
        TextView tv = new TextView(this);
        tv.setText(hint);
        tv.setTextColor(textSecondary());
        tv.setTextSize(12f);
        tv.setLineSpacing(dp(2), 1f);
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        lp.topMargin = dp(4);
        tv.setLayoutParams(lp);
        parent.addView(tv);
    }

    private int dp(int dp) {
        return Math.round(dp * getResources().getDisplayMetrics().density);
    }
}
