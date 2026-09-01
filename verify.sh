#!/bin/bash
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

BADGING=$("$AAPT" dump badging "$APK" 2>/dev/null | grep "^package" || true)
VCODE=$(echo "$BADGING" | sed -n "s/.*versionCode='\([0-9]*\)'.*/\1/p")
VNAME=$(echo "$BADGING" | sed -n "s/.*versionName='\([^']*\)'.*/\1/p")
if [ -n "$VCODE" ] && [ "$VCODE" != "0" ] && [ -n "$VNAME" ]; then
    ok "版本号 versionCode=$VCODE versionName='$VNAME'"
else
    bad "版本号异常: '$BADGING'（versionCode 必须非0, versionName 必须非空）"
fi

if "$ZIPALIGN" -c 4 "$APK" >/dev/null 2>&1; then
    ok "zipalign 4 字节对齐"
else
    bad "zipalign 未对齐"
fi

if "$APKSIGNER" verify "$APK" >/dev/null 2>&1; then
    ok "apksigner 签名有效"
else
    bad "apksigner 签名无效"
fi

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
