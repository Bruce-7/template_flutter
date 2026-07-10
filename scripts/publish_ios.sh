#!/bin/bash

# 用法：sh ./scripts/publish_ios.sh
# 说明：必须在项目根目录执行。交互式选择打包类型和环境

echo -e "\n\033[1;36m🚀 iOS 发布打包开始...\033[0m"
echo "----------------------------------------"

# 选择打包类型
echo -e "\033[1;33m请选择打包类型：\033[0m"
echo "1) beta (上传蒲公英)"
echo "2) release (上传 App Store/TestFlight)"
read -p "请输入选项 [1-2]: " build_type_choice

case $build_type_choice in
  1)
    LANE="beta"
    echo -e "\033[1;32m✓ 已选择：beta\033[0m"
    ;;
  2)
    LANE="release"
    echo -e "\033[1;32m✓ 已选择：release\033[0m"
    ;;
  *)
    echo -e "\033[1;31m❌ 错误：无效的选项，请输入 1 或 2\033[0m"
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

# 进入 iOS 项目目录
pushd "./ios" > /dev/null || {
  echo -e "\033[1;31m❌ 错误：无法进入 ios 目录。\033[0m"
  exit 1
}

echo -e "\033[1;34m📁 当前目录：$(pwd)\033[0m"
echo -e "\033[1;33m📦 开始执行发布命令：bundle exec fastlane $LANE environment:$ENVIRONMENT --verbose\033[0m"

# 执行 fastlane，传递环境参数
if bundle exec fastlane "$LANE" environment:"$ENVIRONMENT" --verbose; then
  echo -e "\033[1;32m✅ Fastlane 发布成功！\033[0m"
else
  echo -e "\033[1;31m❌ 错误：bundle exec fastlane $LANE 执行失败。\033[0m"
  popd > /dev/null || exit
  exit 1
fi

# 返回原始目录
popd > /dev/null || exit
echo "----------------------------------------"
echo -e "\033[1;32m🎉 iOS 发布脚本执行完成！\033[0m\n"