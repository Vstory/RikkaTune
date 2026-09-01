#!/bin/bash
# ============================================================
# libxposed API 102 模块通用构建脚本
# 来源: 懒饭模块 + 钱迹模块 实战沉淀
# ============================================================
# 依赖: aapt, smali, zipalign, apksigner, keytool
# 用法:
#   ./build.sh                     # patch: versionCode+1, versionName 不变
#   ./build.sh minor               # minor: 次版本+1, code+1
#   ./build.sh major               # major: 主版本+1, code+1
#   ./build.sh -k my.keystore patch   # 自定义 keystore 签名
#
# 环境变量 (或 -k/-a 参数):
#   KEYSTORE_FILE / KEYSTORE_ALIAS / KEYSTORE_STORE_PASS / KEYSTORE_KEY_PASS
#
# 签名策略:
#   - 默认 debug 签名 (CN=Android Debug): 任何人 clone 后无需证书即可构建安装
#   - 自定义 keystore: 发布者用自己的私钥签名, 私钥永不公开
#
# 产物命名 (release/debug 标识):
#   - 含未注释 Debug.d 调用 → Debug 版 → 产物名追加 _debug (如 RikkaTune_1.0.0(15)_debug.apk)
#   - 注释/移除所有 Debug.d 调用 → 正式版 → 产物名追加 _release (如 RikkaTune_1.0.0(15)_release.apk)
#   - 判断依据: 扫 src/smali/**/*.smali 是否有未注释的 invoke-static .*Debug;->d 调用
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 📌 新项目修改点 1: 模块名（输出 APK 文件名）
MODULE_NAME="RikkaTune"
# 📌 新项目修改点 2: 包名（必须与 smali 目录/AndroidManifest 一致）
PACKAGE_NAME="com.vstory.hook.rikkahub"
# 📌 新项目修改点 3: 初始版本
INIT_VERSION_NAME="1.0.0"
INIT_VERSION_CODE=1

AAPT="/usr/bin/aapt"
ANDROID_JAR="/workspace/tools/android-sdk/platforms/android-34/android.jar"
if [ ! -f "$ANDROID_JAR" ]; then
    ANDROID_JAR="/usr/lib/android-sdk/platforms/android-23/android.jar"
fi
ZIPALIGN="/usr/bin/zipalign"
APKSIGNER="/usr/bin/apksigner"
SMALI="/usr/bin/smali"

# ---------- 解析参数 ----------
CUSTOM_KEYSTORE=""
BUMP="patch"
while [ $# -gt 0 ]; do
    case "$1" in
        -k|--keystore) CUSTOM_KEYSTORE="$2"; shift 2 ;;
        -a|--alias)    KEYSTORE_ALIAS="$2"; shift 2 ;;
        patch|minor|major) BUMP="$1"; shift ;;
        *) echo "未知参数: $1 (支持 patch|minor|major 和 -k keystore)"; exit 1 ;;
    esac
done

# ---------- 签名配置 (默认 debug) ----------
KEYSTORE_FILE="${KEYSTORE_FILE:-$CUSTOM_KEYSTORE}"
KEYSTORE_ALIAS="${KEYSTORE_ALIAS:-androiddebugkey}"
KEYSTORE_STORE_PASS="${KEYSTORE_STORE_PASS:-android}"
KEYSTORE_KEY_PASS="${KEYSTORE_KEY_PASS:-android}"

# ---------- 版本管理 ----------
VERSION_FILE="version.properties"
if [ ! -f "$VERSION_FILE" ]; then
    printf 'versionName=%s\nversionCode=%s\n' "$INIT_VERSION_NAME" "$INIT_VERSION_CODE" > "$VERSION_FILE"
fi
VERSION_NAME=$(grep '^versionName=' "$VERSION_FILE" | cut -d= -f2)
VERSION_CODE=$(grep '^versionCode=' "$VERSION_FILE" | cut -d= -f2)

case "$BUMP" in
    patch) VERSION_CODE=$((VERSION_CODE + 1)) ;;
    minor) VERSION_NAME=$(echo "$VERSION_NAME" | awk -F. '{print $1"."$2+1".0"}'); VERSION_CODE=$((VERSION_CODE + 1)) ;;
    major) VERSION_NAME=$(echo "$VERSION_NAME" | awk -F. '{print $1+1".0.0"}'); VERSION_CODE=$((VERSION_CODE + 1)) ;;
esac
printf 'versionName=%s\nversionCode=%s\n' "$VERSION_NAME" "$VERSION_CODE" > "$VERSION_FILE"

# ---------- 产物命名标识 (release/debug) ----------
# 规则: 扫 src/smali/**/*.smali 里是否有【未注释的】 invoke-static .*Debug;->d 调用
#   - 存在(非注释行首是 invoke-static) → Debug 版 → 产物名追加 _debug
#   - 全部注释/移除 → 正式版 → 产物名追加 _release
# 产物名: release/${MODULE_NAME}_${VERSION_NAME}(${VERSION_CODE})_${release|debug}.apk
DEBUG_SUFFIX=""
if grep -rqE '^[[:space:]]*invoke-static[[:space:]]*\{.*Debug;->d' src/smali/ 2>/dev/null; then
    DEBUG_SUFFIX="_debug"
    echo "检测: 含调试代码(Debug.d 调用仍在) → Debug 版 → 追加 _debug"
else
    DEBUG_SUFFIX="_release"
    echo "检测: 正式版(Debug.d 调用已注释/移除) → 正式版 → 追加 _release"
fi

OUT="release/${MODULE_NAME}_${VERSION_NAME}(${VERSION_CODE})${DEBUG_SUFFIX}.apk"
echo "构建版本: ${VERSION_NAME}(${VERSION_CODE})"

# ---------- 写回 Manifest 版本号 (必须带 android: 前缀, 系统才能读到) ----------
sed -i "s/android:versionCode=\"[0-9]*\"/android:versionCode=\"$VERSION_CODE\"/; s/android:versionName=\"[^\"]*\"/android:versionName=\"$VERSION_NAME\"/" AndroidManifest.xml

# ---------- 编译 ----------
echo "[1/5] smali 编译..."
rm -rf build
mkdir -p build/dex
"$SMALI" assemble src/smali -o build/dex/classes.dex
echo "      classes.dex: $(wc -c < build/dex/classes.dex) bytes"

echo "[2/5] aapt 编译资源(生成二进制AXML)..."
mkdir -p build/clean
"$AAPT" package -f -M AndroidManifest.xml -S res \
    -I "$ANDROID_JAR" -F build/base.apk
cd build/clean
unzip -o ../base.apk
# api102 模块配置: META-INF/xposed/{java_init.list, module.prop, scope.list}
cp -r ../../src/meta-inf/META-INF .
cp ../dex/classes.dex .
rm -rf META-INF/*.SF META-INF/*.RSA META-INF/*.MF 2>/dev/null || true
cd ../..

# ---------- 打包（resources.arsc 必须未压缩+对齐）----------
echo "[3/5] 打包 (resources.arsc store 模式)..."
mkdir -p release
rm -f "$OUT" release/tmp_unsigned.apk release/aligned.apk
cd build/clean
zip -r ../../release/tmp_unsigned.apk \
    AndroidManifest.xml resources.arsc classes.dex \
    META-INF/xposed/java_init.list META-INF/xposed/module.prop META-INF/xposed/scope.list
# resources.arsc 重压为未压缩(store)
zip -d ../../release/tmp_unsigned.apk resources.arsc
zip -0 ../../release/tmp_unsigned.apk resources.arsc
cd ../..

echo "[4/5] zipalign 对齐..."
"$ZIPALIGN" -f 4 release/tmp_unsigned.apk release/aligned.apk

echo "[5/5] apksigner 签名..."
if [ -n "$KEYSTORE_FILE" ] && [ -f "$KEYSTORE_FILE" ]; then
    echo "      使用自定义 keystore: $KEYSTORE_FILE (alias=$KEYSTORE_ALIAS)"
else
    KEYSTORE_FILE="build/debug.keystore"
    if [ ! -f "$KEYSTORE_FILE" ]; then
        echo "      生成 debug keystore (CN=Android Debug)..."
        keytool -genkeypair -v -keystore "$KEYSTORE_FILE" -storepass android \
            -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 \
            -validity 10000 -dname "CN=Android Debug,O=Android,C=US" 2>/dev/null
    fi
    echo "      使用 debug keystore: $KEYSTORE_FILE"
fi
"$APKSIGNER" sign --ks "$KEYSTORE_FILE" --ks-pass pass:"$KEYSTORE_STORE_PASS" \
    --key-pass pass:"$KEYSTORE_KEY_PASS" --ks-key-alias "$KEYSTORE_ALIAS" \
    --out "$OUT" release/aligned.apk

rm -f release/tmp_unsigned.apk release/aligned.apk
echo ""
echo "✅ 完成: $OUT"
echo ""

echo "[验证] 自动运行 verify.sh..."
"$SCRIPT_DIR/verify.sh" "$OUT" || {
    echo ""
    echo "⚠️  验证未通过！请修复后重新构建（不要分发未验证的 APK）"
    exit 1
}
echo ""
echo "⚠️⚠️⚠️  重要：请提供【日志】给我验证（提供哪个，看代码日志输出在哪）⚠️⚠️⚠️"
echo ""
echo "  📌 要提供哪个日志，由代码里日志输出的【通道】决定："
echo "  · 如果代码日志走 LSPosed 框架日志（如 PANGU hook OK）→ 提供【LSPosed 框架日志】"
echo "  · 如果代码日志走 app 进程 logcat（如 PANGU: [原]->[改]）→ 提供【logcat】"
echo "  · 两处都打 → 两个都提供"
echo ""
echo "  ⚠️ LSPosed 框架日志(verbose_*.log) 不含 app 进程 Log.i 拦截输出(那是 logcat 通道)"
echo "  ⚠️ 构建成功提示知识沉淀时，请确认调试日志代码已按项目规范维护（正式版注释/移除不删，按需加回）"
echo ""
echo "签名信息:"
"$APKSIGNER" verify --print-certs "$OUT" 2>/dev/null | grep -E "Signer #1 certificate DN|Signer #1 certificate SHA-256" || true
echo ""
echo "验证:"
echo "  aapt dump badging $OUT | grep version"
echo "  zipalign -c 4 $OUT && apksigner verify $OUT"
echo "  unzip -l $OUT | grep META-INF/xposed"
echo ""
echo "📝 构建成功知识沉淀提示："
echo "  1. 本次版本改了什么（版本流水）→ 追加 $DEST/dev-project/CHANGELOG.md"
echo "  2. 本次开发的知识点（混淆映射/hook点清单/项目踩坑）→ 及时写入"
echo "     /workspace/知识库/dev-guide/项目开发记录/<包名>.md"
echo "  3. 可通用化的知识 → 同步写入 dev-guide/实战/api102开发实战.md"
echo "  4. 检索用到的关键词 → 记入 知识库管理/查询日志.md（供高频直达表统计）"
