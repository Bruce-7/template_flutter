# Flutter App Template

Flutter App Template 是一个面向商业项目快速启动的 Flutter 基础框架模板，目标覆盖 iOS、Android、HarmonyOS/OpenHarmony 等移动端场景。项目内已经集成常见应用工程能力，包括路由、状态管理、网络请求、本地数据库、国际化、主题、订阅、图片处理、导入导出、通知、常用组件和页面模板。

项目包含若干示例页面、示例 API、示例数据库表和模板代码，用于说明工程约定。实际业务开发时可以在现有目录和模式上继续扩展，也可以删除不需要的示例模块。

## 主要能力

- iOS、Android、HarmonyOS/OpenHarmony 工程结构
- 基于 Riverpod 的状态管理
- 基于 AutoRoute 的路由管理
- 基于 Dio 的网络层和拦截器
- Drift 数据库结构和迁移示例
- EasyLocalization 国际化配置
- 主题系统、通用组件、Dialog、Toast、Loading、刷新控件
- 图片选择、编辑、裁剪、预览、移除背景示例
- 导入导出、本地通知、iCloud 同步、订阅示例
- 常用构建、迁移和发布脚本

## 环境要求

推荐工具链：

- Flutter `3.35.7`
- Dart `3.9.2`
- DevTools `2.48.0`
- 推荐使用 FVM 管理 Flutter SDK

不同平台构建前，请确认本机已安装对应原生工具链、SDK、证书、签名配置和 IDE。

## 平台支持

- iOS：Xcode 工程、fastlane 发布脚本、iCloud/订阅示例
- Android：Gradle 工程、签名配置读取、ProGuard 配置、发布脚本
- HarmonyOS/OpenHarmony：`ohos` 工程、ArkTS 入口和基础配置

## 技术栈

- 状态管理：`hooks_riverpod`、`flutter_hooks`、`riverpod_annotation`
- 路由：`auto_route`
- 网络：`dio`
- 数据库：`drift`、`drift_flutter`
- 国际化：`easy_localization`
- 资源生成：`flutter_gen`
- UI/交互：`flutter_smart_dialog`、`easy_refresh`、`flutter_slidable`、`fl_chart`
- 图片能力：`extended_image`、`image_picker`、`image_editor`、`image_background_remover`
- 本地能力：`shared_preferences`、`path_provider`、`file_picker`、`flutter_local_notifications`
- 订阅示例：`purchases_flutter`，默认按 RevenueCat 模式集成

## 架构概览

项目采用按职责分层的 Flutter 应用结构：

- `lib/main.dart`：应用启动、国际化、ProviderScope、主题、Dialog/Toast 配置
- `lib/routes/`：路由定义和导航封装
- `lib/pages/`：页面模块，通常拆分为 `page.dart`、`widget.dart`、`function.dart`
- `lib/providers/`：Riverpod 状态和 Provider
- `lib/services/`：API、Dio Client、拦截器和网络响应模型
- `lib/database/`：Drift 表、DAO、数据库配置、迁移逻辑和数据库日志
- `lib/managers/`：数据库、订阅、通知、日志、翻译等全局管理器
- `lib/theme/`：颜色、字体、间距、圆角、主题和 ThemeExtension
- `lib/widgets/`：可复用 UI 组件
- `lib/utils/`、`lib/extension/`、`lib/constants/`：工具函数、扩展方法和常量

## 目录结构

```text
.
├── android/                 # Android 原生工程
├── assets/                  # 图片、图标、翻译等资源
│   ├── icons/
│   ├── images/
│   └── translations/
├── docs/                    # 补充文档
├── drift/                   # Drift schema 和迁移产物
├── ios/                     # iOS 原生工程和 fastlane 配置
├── lib/
│   ├── constants/           # 常量和环境配置
│   ├── database/            # Drift 数据库、表、DAO、迁移
│   ├── extension/           # Dart/Flutter 扩展
│   ├── gen/                 # 生成的资源代码
│   ├── managers/            # 全局服务管理器
│   ├── models/              # 数据模型
│   ├── pages/               # 页面模块和示例页面
│   ├── providers/           # Riverpod 状态
│   ├── routes/              # AutoRoute 配置
│   ├── services/            # API、Dio、拦截器
│   ├── theme/               # 主题系统
│   ├── utils/               # 工具类
│   └── widgets/             # 通用组件
├── ohos/                    # HarmonyOS/OpenHarmony 工程
├── scripts/                 # 构建、发布、迁移脚本
└── test/                    # Flutter 测试
```

## 快速开始

```bash
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run
```

如果不使用 FVM，可以去掉命令中的 `fvm` 前缀。建议保持 Flutter SDK 版本一致，以减少多端构建差异。

## 常用命令

```bash
# 安装依赖
fvm flutter pub get

# 生成 Riverpod、AutoRoute、JSON、Drift、flutter_gen 文件
fvm dart run build_runner build --delete-conflicting-outputs

# 监听生成
fvm dart run build_runner watch --delete-conflicting-outputs

# 生成 Drift 迁移
fvm dart run drift_dev make-migrations

# 静态分析
fvm dart analyze

# 测试
fvm flutter test

# Android 构建
fvm flutter build apk --release

# iOS 构建
fvm flutter build ipa --release
```

## 运行环境

项目通过 Dart 编译环境变量选择 API 环境：

```bash
fvm flutter run --dart-define=environment=production
```

默认值为 `production`。可按业务需要扩展 `lib/constants/env.dart` 和网络配置。

## 代码生成

修改以下内容后通常需要重新运行 `build_runner`：

- Riverpod 注解
- AutoRoute 路由定义
- JSON 序列化模型
- Drift 表、DAO、数据库定义
- 资源配置

生成文件不建议手动编辑。

## 数据库

Drift 相关文件位于：

- `lib/database/tables/`
- `lib/database/daos/`
- `lib/database/database.dart`
- `drift/schemas/`
- `scripts/drift_dev_migrations.sh`

修改表结构后，请生成迁移并补充必要的迁移逻辑。

## 路由约定

路由定义位于 `lib/routes/routes.dart`。新增页面时：

1. 创建页面模块
2. 在 `routes.dart` 注册路由
3. 运行代码生成
4. 使用生成的 Route 类或 `RoutesNavigator` 跳转

## 页面约定

页面模块通常拆分为：

- `page.dart`：路由注解、页面入口、状态装配
- `widget.dart`：页面内 UI 组件
- `function.dart`：页面级交互逻辑和辅助函数

`lib/pages/template/` 包含可复制使用的页面模板代码。

## 开源前安全检查

公开仓库前请确认未提交以下内容：

- Android keystore、`key.properties`、`.jks`、`.keystore`
- iOS `.p8`、证书、描述文件、真实 fastlane API Key JSON
- RevenueCat、Sentry、蒲公英、App Store Connect、Google Play、后端服务等真实密钥
- 生产域名、私有 API 地址、Token、Cookie、测试账号、手机号、私人邮箱
- 不希望公开的真实 Bundle ID、application ID、iCloud Container ID、订阅产品 ID

当前仓库注意事项：

- `android/key.properties` 和 `android/upload-keystore/upload-keystore.jks` 存在于本地，但未被 Git 跟踪。请确保不要提交到公开仓库。
- 原先被跟踪的 fastlane API Key 占位文件已替换为 `ios/fastlane/app_store_connect_api_key.example.json`。
- `lib/constants/keys.dart` 仍包含占位值。发布前请确认没有真实生产配置。

如果真实密钥曾经进入 Git 历史，请先撤销密钥并清理 Git 历史，再公开仓库。

## 发布密钥

Android 签名从 `android/key.properties` 读取。该文件和 keystore 应保留在 Git 之外。

iOS fastlane 上传密钥从环境变量读取：

- `PGYER_API_KEY`
- `PGYER_PASSWORD`
- `APP_STORE_CONNECT_API_KEY_PATH`

## 贡献

欢迎提交 Issue 和 Pull Request。提交前建议运行：

```bash
fvm dart format .
fvm dart analyze
fvm flutter test
```

涉及生成代码时，还应运行：

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

## 授权

本项目为私有项目，保留所有权利。未经授权不得使用、复制、修改或分发本软件。详见 [LICENSE](LICENSE)。
