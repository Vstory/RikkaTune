import android.app.Activity;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
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
    private boolean mRefreshing;

    /** 连上框架后 Application 转发调用 */
    public void onServiceBind(XposedService service) {
        mRemotePrefs = service.getRemotePreferences(Prefs.PREFS_GROUP);
        refreshSwitches();
        showStatus("已连接框架：设置即时生效", "#2E7D32");
        Debug.d("RikkaTuneUI", "onServiceBind: 已连接，prefs=" + mRemotePrefs);
    }

    /** 框架断开后 Application 转发调用 */
    public void onServiceDied(XposedService service) {
        mRemotePrefs = null;
        showStatus("框架连接断开", "#F44336");
        Debug.d("RikkaTuneUI", "onServiceDied: 框架断开");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Debug.d("RikkaTuneUI", "onCreate: 控制面板启动");
        buildUi();
        // 注册到 Application（binder 到达时转发给我）
        RikkaTuneApp.sUi = this;
        // 读 Application 静态 prefs（进程级，Activity 重建直接复用）
        SharedPreferences sp = Prefs.current();
        if (sp != null) {
            mRemotePrefs = sp;
            refreshSwitches();
            showStatus("已连接框架：设置即时生效", "#2E7D32");
        } else {
            // Application 还没收到 binder（进程首次/框架未到）→ 本地 fallback 已就绪
            showStatus("正在连接 LSPosed 框架…", "#FF9800");
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

        // 标题
        TextView tvTitle = new TextView(this);
        tvTitle.setText("RikkaTune");
        tvTitle.setTextSize(24f);
        tvTitle.setTypeface(null, Typeface.BOLD);
        root.addView(tvTitle);

        // 副标题
        TextView tvSub = new TextView(this);
        tvSub.setText("RikkaHub UI 调校 · 开关即存即生效（无需重启）");
        tvSub.setTextColor(0xFF888888);
        tvSub.setTextSize(13f);
        root.addView(tvSub);

        // 状态行
        mStatus = new TextView(this);
        mStatus.setText("正在连接 LSPosed 框架…");
        mStatus.setTextColor(Color.parseColor("#FF9800"));
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
        textCol.addView(tvTitle);

        TextView tvDesc = new TextView(this);
        tvDesc.setText(desc);
        tvDesc.setTextColor(0xFF888888);
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
        Debug.d("RikkaTuneUI", "从框架读到开关: pangu=" + pangu + " asr=" + asr
            + " haptic=" + haptic + " compress=" + compress);
        mRefreshing = true;
        mSwPangu.setChecked(pangu);
        mSwAsr.setChecked(asr);
        mSwHaptic.setChecked(haptic);
        mSwCompress.setChecked(compress);
        mRefreshing = false;
    }

    // ===== 开关监听器 =====

    private final CompoundButton.OnCheckedChangeListener mSwitchListener =
        (buttonView, isChecked) -> {
            if (mRefreshing) return;
            String key = (String) buttonView.getTag();
            Debug.d("RikkaTuneUI", "开关 " + key + " -> " + isChecked + " 已写入");
            Prefs.putBoolean(key, isChecked);
        };

    // ===== 工具 =====

    private void showStatus(String text, String color) {
        if (mStatus != null) {
            mStatus.setText(text);
            mStatus.setTextColor(Color.parseColor(color));
        }
    }

    private int dp(int dp) {
        return Math.round(dp * getResources().getDisplayMetrics().density);
    }
}
