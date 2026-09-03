# RikkaTune

RikkaHub 增强模块（LSPosed / Xposed）。

针对 [RikkaHub](https://github.com/rikkahub/rikkahub)（Android 开源 AI 聊天客户端）的功能增强与体验优化。

## 功能

- **盘古之白**：中英文混排时自动插入空格，让 UI 文案更整齐（hook `Resources.getString`）。
- **去除语音输入提示音**：去掉语音输入的开始 / 结束提示音。
- **增强语音输入振动**：语音输入开始 / 结束的振动调强到与消息生成触觉反馈一致，更明显可感知。
- **对话压缩反馈增强**：压缩对话、添加错误、保存对话时提供更清晰的操作反馈。

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
