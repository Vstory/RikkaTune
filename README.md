# RikkaTune

RikkaHub 增强模块（LSPosed / Xposed）。

针对 [RikkaHub](https://github.com/rikkahub/rikkahub)（Android 开源 AI 聊天客户端）的功能增强与体验优化。

## 功能

所有功能均可在模块控制面板中独立开关（默认全部开启），通过 RemotePreferences 与 LSPosed 框架实时同步，开关切换后**立即生效**，无需重启。

> ⚠️ **盘古之白**例外：由于字符串缓存机制，切换后需重启 RikkaHub 进程才能生效。

- **盘古之白**：RikkaHub UI 文案中英文混排时自动插入空格，让界面文字更整齐。
- **去除语音输入提示音**：静音语音输入的开始 / 结束提示音（`asr_start` / `asr_stop` 音效）。
- **增强语音输入振动**：将语音输入开始 / 结束的弱振动（类型 `0x17` / `0xd`）替换为强振动（类型 `0x3`），与消息生成触觉反馈一致。
- **压缩对话反馈增强**：对话压缩成功或失败时弹出 Toast + 系统通知 + 振动反馈，让用户明确知道操作结果。

## 版本

- 当前版本：`v2.0.0`（versionCode 70）
- Xposed API：v96
- minSdkVersion：31（Android 12）
- targetSdkVersion：35

## 安装

1. 安装 [LSPosed](https://github.com/LSPosed/LSPosed)
2. 安装本模块 APK
3. 在 LSPosed 管理器中启用模块，勾选 RikkaHub 作用域
4. 重启 RikkaHub 生效

## 许可证

本项目采用 **GNU AGPL-3.0** 许可证，与 RikkaHub 保持一致。详见 [LICENSE](LICENSE)。
