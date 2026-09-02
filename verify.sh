#!/bin/bash
# TEMPLATE_VERSION=1.0.0    # 模板版本号(项目复制时记录此值, 对比模板是否更新)
# SCRIPT_VERSION=1.0.0      # 脚本自身版本号(项目定制后可更高)
# ============================================================
# libxposed API 102 模块构建后验证清单（每个版本必查）
# 用法: ./verify.sh <apk路径>
# 检查: 版本号 / zipalign / apksigner / META-INF三件套 / AXML头 / arsc Stored / dex
# build.sh 构建完成后自动调用; 也可单独手动验证
# ============================================================
set -u
APK="${1:-}"
if [ -z "$APK" ] || [ ! -f "$APK" ]; then
    echo "❌ 用法: verify.sh <apk路径>"
    exit 1
fi
APK="$(realpath "$APK")"
AAPT="${AAPT:-/usr/bin/aapt}"
ZIPALIGN="${ZIPALIGN:-/usr/bin/zipalign}"
APKSIGNER="${APKSIGNER:-/usr/bin/apksigner}"

PASS=0; FAIL=0
ok()  { echo "  ✅ $1"; PASS=$((PASS+1)); }
bad() { echo "  ❌ $1"; FAIL=$((FAIL+1)); }

echo "🔍 验证: $(basename "$APK")"

# 1. 版本号（versionCode 必须非0, versionName 必须非空）
BADGING=$("$AAPT" dump badging "$APK" 2>/dev/null | grep "^package" || true)
VCODE=$(echo "$BADGING" | sed -n "s/.*versionCode='\([0-9]*\)'.*/\1/p")
VNAME=$(echo "$BADGING" | sed -n "s/.*versionName='\([^']*\)'.*/\1/p")
if [ -n "$VCODE" ] && [ "$VCODE" != "0" ] && [ -n "$VNAME" ]; then
    ok "版本号 versionCode=$VCODE versionName='$VNAME'"
else
    bad "版本号异常: '$BADGING'（versionCode 必须非0, versionName 必须非空）"
fi

# 2. zipalign 对齐
if "$ZIPALIGN" -c 4 "$APK" >/dev/null 2>&1; then
    ok "zipalign 4 字节对齐"
else
    bad "zipalign 未对齐"
fi

# 3. apksigner 签名
if "$APKSIGNER" verify "$APK" >/dev/null 2>&1; then
    ok "apksigner 签名有效"
else
    bad "apksigner 签名无效"
fi

# 4. META-INF/xposed 三件套
ZIPCHECK=$(python3 - "$APK" <<'PY'
import sys, zipfile
names = zipfile.ZipFile(sys.argv[1]).namelist()
for f in ["META-INF/xposed/java_init.list",
          "META-INF/xposed/module.prop",
          "META-INF/xposed/scope.list"]:
    print(f, "OK" if f in names else "MISSING")
PY
)
if echo "$ZIPCHECK" | grep -q MISSING; then
    bad "META-INF/xposed 缺失:"
    echo "$ZIPCHECK" | grep MISSING | sed 's/^/         /'
else
    ok "META-INF/xposed 三件套齐全"
fi

# 5. AXML 二进制头（必须 03000800, 禁止文本 XML 替换）
AXML=$(python3 - "$APK" <<'PY'
import sys, zipfile
print(zipfile.ZipFile(sys.argv[1]).read("AndroidManifest.xml")[:4].hex())
PY
)
if [ "$AXML" = "03000800" ]; then
    ok "AndroidManifest.xml 二进制头 03000800"
else
    bad "AndroidManifest.xml 头异常: $AXML（应为 03000800, 禁止文本XML替换）"
fi

# 6. resources.arsc 未压缩(Stored)
ARSC=$(python3 - "$APK" <<'PY'
import sys, zipfile
info = zipfile.ZipFile(sys.argv[1]).getinfo("resources.arsc")
print("stored" if info.compress_type == zipfile.ZIP_STORED else "compressed")
PY
)
if [ "$ARSC" = "stored" ]; then
    ok "resources.arsc 未压缩(Stored)"
else
    bad "resources.arsc 被压缩（必须 Stored, 否则资源表解析失败）"
fi

# 7. classes.dex 存在
if python3 - "$APK" <<'PY' | grep -q OK
import sys, zipfile
print("OK" if "classes.dex" in zipfile.ZipFile(sys.argv[1]).namelist() else "MISSING")
PY
then
    ok "classes.dex 存在"
else
    bad "classes.dex 缺失"
fi

echo ""
if [ "$FAIL" -eq 0 ]; then
    echo "🎉 全部 $PASS 项通过，APK 可安装！"
    exit 0
else
    echo "⚠️  $FAIL 项失败 / $PASS 项通过，请修复后重新构建！"
    exit 1
fi
