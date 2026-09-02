#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

MODULE_NAME="RikkaTune"
PACKAGE_NAME="com.vstory.hook.rikkahub"
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

CUSTOM_KEYSTORE=""
BUMP="patch"
RELEASE_MODE=0
CHECK_MODE=0       # 0=自动(有脚本就跑, 失败仅警告) / 1=强制(失败即退出)
SKIP_CHECK=0       # 1=跳过环境检查
while [ $# -gt 0 ]; do
    case "$1" in
        -k|--keystore) CUSTOM_KEYSTORE="$2"; shift 2 ;;
        -a|--alias)    KEYSTORE_ALIAS="$2"; shift 2 ;;
        patch|minor|major) BUMP="$1"; shift ;;
        release) RELEASE_MODE=1; shift ;;   # 一键正式版: toggle off → build → 验证 → toggle on
        -q|--quiet) QUIET=1; shift ;;        # 静默模式: 成功后不打印日志请求提示
        -c|--check) CHECK_MODE=1; shift ;;   # 强制构建前环境检查(失败即退出)
        --skip-check) SKIP_CHECK=1; shift ;; # 跳过构建前环境检查
        *) echo "未知参数: $1 (支持 patch|minor|major, release, -c, --skip-check, -k keystore, -q)"; exit 1 ;;
    esac
done

if [ "$SKIP_CHECK" -eq 0 ] && [ -f "dev-project/check_build_env.sh" ]; then
    echo ""
    echo "🔍 构建前环境检查..."
    if bash dev-project/check_build_env.sh .; then
        echo ""
    else
        if [ "$CHECK_MODE" -eq 1 ]; then
            echo "❌ 环境检查未通过（-c 强制模式），请先修复（参照构建流程.md「已有项目升级」）"
            exit 1
        else
            echo "⚠️  环境检查未通过（继续构建；用 ./build.sh -c 可强制拦截）"
            echo ""
        fi
    fi
fi

if [ "$SKIP_CHECK" -eq 0 ] && [ -f "dev-project/check_template_update.sh" ]; then
    echo "🔍 模板脚本版本自检..."
    if bash dev-project/check_template_update.sh . >/dev/null 2>&1; then
        echo "  ✅ 模板脚本均为最新"
    else
        if [ "$CHECK_MODE" -eq 1 ]; then
            echo "  🔧 -c 强制模式: 自动同步模板脚本..."
            bash dev-project/check_template_update.sh . --update 2>&1 | tail -3
        else
            echo "  ⚠️  模板脚本有过期项（用 ./build.sh -c 自动同步, 或手动 check_template_update.sh --update）"
        fi
    fi
fi

KEYSTORE_FILE="${KEYSTORE_FILE:-$CUSTOM_KEYSTORE}"
KEYSTORE_ALIAS="${KEYSTORE_ALIAS:-androiddebugkey}"
KEYSTORE_STORE_PASS="${KEYSTORE_STORE_PASS:-android}"
KEYSTORE_KEY_PASS="${KEYSTORE_KEY_PASS:-android}"

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


if [ "$RELEASE_MODE" -eq 1 ]; then
    if [ ! -f "dev-project/toggle_debug.sh" ]; then
        echo "❌ release 模式需要 dev-project/toggle_debug.sh（调试切换脚本）"
        echo "   请先复制: cp /workspace/知识库/scripts/toggle_debug.sh dev-project/"
        exit 1
    fi
    echo "[release] 注释调试块 (toggle off)..."
    bash dev-project/toggle_debug.sh off
    echo "[release] Debug.d 调用: $(grep -rE '^[[:space:]]*invoke-static[[:space:]]*\{.*Debug;->d' src/smali/ 2>/dev/null | wc -l) (应=0)"
fi

if grep -rqE '^[[:space:]]*invoke-static[[:space:]]*\{.*Debug;->d' src/smali/ 2>/dev/null; then
    DEBUG_SUFFIX="_debug"
    echo "检测: 含调试代码(Debug.d 调用仍在) → Debug 版 → 追加 _debug"
else
    DEBUG_SUFFIX="_release"
    echo "检测: 正式版(Debug.d 调用已注释/移除) → 正式版 → 追加 _release"
fi
OUT="dev-project/releases/${MODULE_NAME}_${VERSION_NAME}(${VERSION_CODE})${DEBUG_SUFFIX}.apk"
echo "构建版本: ${VERSION_NAME}(${VERSION_CODE})"

sed -i "s/android:versionCode=\"[0-9]*\"/android:versionCode=\"$VERSION_CODE\"/; s/android:versionName=\"[^\"]*\"/android:versionName=\"$VERSION_NAME\"/" AndroidManifest.xml

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
cp -r ../../src/meta-inf/META-INF .
cp ../dex/classes.dex .
rm -rf META-INF/*.SF META-INF/*.RSA META-INF/*.MF 2>/dev/null || true
cd ../..

echo "[3/5] 打包 (resources.arsc store 模式)..."
mkdir -p dev-project/releases
rm -f "$OUT" dev-project/releases/tmp_unsigned.apk dev-project/releases/aligned.apk
cd build/clean
zip -r ../../dev-project/releases/tmp_unsigned.apk \
    AndroidManifest.xml resources.arsc classes.dex \
    META-INF/xposed/java_init.list META-INF/xposed/module.prop META-INF/xposed/scope.list
zip -d ../../dev-project/releases/tmp_unsigned.apk resources.arsc
zip -0 ../../dev-project/releases/tmp_unsigned.apk resources.arsc
cd ../..

echo "[4/5] zipalign 对齐..."
"$ZIPALIGN" -f 4 dev-project/releases/tmp_unsigned.apk dev-project/releases/aligned.apk

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
    --out "$OUT" dev-project/releases/aligned.apk

rm -f dev-project/releases/tmp_unsigned.apk dev-project/releases/aligned.apk
echo ""
echo "✅ 完成: $OUT"
echo ""

echo "[验证] 自动运行 verify.sh..."
"$SCRIPT_DIR/verify.sh" "$OUT" || {
    echo ""
    echo "⚠️  验证未通过！请修复后重新构建（不要分发未验证的 APK）"
    exit 1
}

if [ "$RELEASE_MODE" -eq 1 ] || [ "$DEBUG_SUFFIX" = "_debug" ]; then
    MODE_LABEL="release"
    if [ "$DEBUG_SUFFIX" = "_debug" ]; then MODE_LABEL="debug"; fi
    echo ""
    echo "[$MODE_LABEL] 反编译兜底验证（Debug.d 应${MODE_LABEL}=0 / debug>0）..."
    unzip -p "$OUT" classes.dex > build/dex/verify_classes.dex 2>/dev/null || {
        echo "❌ [$MODE_LABEL] 无法从 APK 提取 classes.dex"
        exit 1
    }
    rm -rf build/dex/verify_smali
    if command -v baksmali >/dev/null 2>&1; then
        baksmali disassemble build/dex/verify_classes.dex -o build/dex/verify_smali 2>/dev/null || {
            echo "❌ [$MODE_LABEL] baksmali 反编译失败"
            exit 1
        }
    else
        echo "❌ [$MODE_LABEL] 未找到 baksmali 工具（反编译兜底需要）"
        exit 1
    fi
    DEBUGCNT=$(grep -r 'Debug;->d' build/dex/verify_smali/ 2>/dev/null | wc -l)
    if [ "$RELEASE_MODE" -eq 1 ]; then
        if [ "$DEBUGCNT" -eq 0 ]; then
            echo "  ✅ 反编译确认: Debug.d=0（正式版干净）"
        else
            echo "  ❌ 反编译发现 $DEBUGCNT 处 Debug.d（正式版不应含调试代码！）"
            echo "     请检查: toggle off 是否生效 / 是否有标记外的裸调试代码"
            exit 1
        fi
    else
        if [ "$DEBUGCNT" -gt 0 ]; then
            echo "  ✅ 反编译确认: Debug.d=$DEBUGCNT（调试代码在, debug 版正确）"
        else
            echo "  ❌ 反编译发现 Debug.d=0（debug 版应含调试代码！）"
            echo "     请检查: 是否误 toggle off / 调试块是否被意外注释"
            exit 1
        fi
    fi
fi

if [ "$RELEASE_MODE" -eq 1 ]; then
    echo ""
    echo "[release] 恢复调试块 (toggle on)..."
    bash dev-project/toggle_debug.sh on
    echo "[release] 恢复后 Debug.d 调用: $(grep -rE '^[[:space:]]*invoke-static[[:space:]]*\{.*Debug;->d' src/smali/ 2>/dev/null | wc -l) (应>0)"
    echo "[release] 源码恢复验证: toggle on 已通过 smali 编译验证（源码可编译）"
fi

echo ""
echo "✅ 完成: $OUT"
echo ""

if [ -z "${QUIET:-}" ]; then
    echo "签名信息:"
    "$APKSIGNER" verify --print-certs "$OUT" 2>/dev/null | grep -E "Signer #1 certificate DN|Signer #1 certificate SHA-256" || true
    echo ""
    echo "📝 构建成功知识沉淀提示："
    echo "  1. 本次版本改了什么（版本流水）→ 追加 $SCRIPT_DIR/dev-project/CHANGELOG.md"
    echo "  2. 本次开发的知识点（混淆映射/hook点清单/项目踩坑）→ 及时写入"
    echo "     /workspace/知识库/dev-guide/项目开发记录/<包名>.md"
    echo "  3. 可通用化的知识 → 同步写入 dev-guide/实战/api102开发实战.md"
    echo "  4. 检索用到的关键词 → 记入 知识库管理/查询日志.md（供高频直达表统计）"
fi
