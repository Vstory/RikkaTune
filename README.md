# RikkaTune

RikkaHub 增强模块（LSPosed / Xposed）。

## 功能

- **盘古之白**：中英文混排时自动插入空格，让 UI 文案更整齐。
- **去除语音输入提示音**：去掉语音输入的开始 / 结束提示音。
- **增强语音输入振动**：语音输入开始 / 结束的振动太弱，调强到与消息生成触觉反馈一致（更明显可感知）。

## 日志

- hook 注册结果聚合为一条日志，每条 hook 独立换行显示，方便查看。
- 调试日志通过双通道输出（框架日志 + logcat）。

## 版本

- 当前版本：`v1.3.0`（versionCode 32）

基于 [RikkaHub](https://github.com/rikkahub/rikkahub)（Android 开源 AI 聊天客户端）。

> 更多功能增强与界面调整正在开发中。
