#!/bin/bash

# 用法：sh ./scripts/publish_android.sh
# 说明：必须在项目根目录执行。交互式选择打包类型和环境

echo -e "\n\033[1;36m🚀 Android 发布打包开始...\033[0m"
echo "----------------------------------------"

# 选择打包类型
echo -e "\033[1;33m请选择打包类型：\033[0m"
echo "1) apk (标准 APK)"
echo "2) apk-split (分架构 APK，体积更小)"
echo "3) appbundle (App Bundle，用于 Google Play)"
read -p "请输入选项 [1-3]: " build_type_choice

case $build_type_choice in
  1)
    BUILD_TYPE="apk"
    BUILD_COMMAND="fvm flutter build apk --release"
    echo -e "\033[1;32m✓ 已选择：标准 APK\033[0m"
    ;;
  2)
    BUILD_TYPE="apk-split"
    BUILD_COMMAND="fvm flutter build apk --split-per-abi --release"
    echo -e "\033[1;32m✓ 已选择：分架构 APK\033[0m"
    ;;
  3)
    BUILD_TYPE="appbundle"
    BUILD_COMMAND="fvm flutter build appbundle --release"
    echo -e "\033[1;32m✓ 已选择：App Bundle\033[0m"
    ;;
  *)
    echo -e "\033[1;31m❌ 错误：无效的选项，请输入 1-3\033[0m"
    exit 1
    ;;
esac

echo ""

# 选择环境
echo -e "\033[1;33m请选择打包环境：\033[0m"
echo "1) test1"
echo "2) test2"
echo "3) production"
read -p "请输入选项 [1-3]: " env_choice

case $env_choice in
  1)
    ENVIRONMENT="test1"
    echo -e "\033[1;32m✓ 已选择：test1\033[0m"
    ;;
  2)
    ENVIRONMENT="test2"
    echo -e "\033[1;32m✓ 已选择：test2\033[0m"
    ;;
  3)
    ENVIRONMENT="production"
    echo -e "\033[1;32m✓ 已选择：production\033[0m"
    ;;
  *)
    echo -e "\033[1;31m❌ 错误：无效的选项，请输入 1-3\033[0m"
    exit 1
    ;;
esac

echo ""
echo "----------------------------------------"
echo -e "\033[1;34m📁 当前目录：$(pwd)\033[0m"
echo -e "\033[1;33m📦 开始执行打包命令：$BUILD_COMMAND --dart-define=environment=$ENVIRONMENT\033[0m"
echo ""

# 执行打包命令
if $BUILD_COMMAND --dart-define=environment=$ENVIRONMENT; then
  echo ""
  echo "----------------------------------------"
  echo -e "\033[1;32m✅ Android 打包成功！\033[0m"
  echo ""
  
  # 显示打包产物位置
  echo -e "\033[1;36m📦 打包产物位置：\033[0m"
  
  if [ "$BUILD_TYPE" = "apk" ]; then
    APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
    if [ -f "$APK_PATH" ]; then
      APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
      echo -e "\033[1;32m  ✓ $APK_PATH ($APK_SIZE)\033[0m"
    fi
  elif [ "$BUILD_TYPE" = "apk-split" ]; then
    echo -e "\033[1;32m  ✓ build/app/outputs/flutter-apk/\033[0m"
    ls -lh build/app/outputs/flutter-apk/*.apk 2>/dev/null | awk '{print "    - " $9 " (" $5 ")"}'
  elif [ "$BUILD_TYPE" = "appbundle" ]; then
    AAB_PATH="build/app/outputs/bundle/release/app-release.aab"
    if [ -f "$AAB_PATH" ]; then
      AAB_SIZE=$(du -h "$AAB_PATH" | cut -f1)
      echo -e "\033[1;32m  ✓ $AAB_PATH ($AAB_SIZE)\033[0m"
    fi
  fi
  
  echo ""
  echo -e "\033[1;36m🌍 打包环境：$ENVIRONMENT\033[0m"
  
else
  echo ""
  echo "----------------------------------------"
  echo -e "\033[1;31m❌ 错误：Android 打包失败。\033[0m"
  exit 1
fi

echo "----------------------------------------"
echo -e "\033[1;32m🎉 Android 发布脚本执行完成！\033[0m\n"
