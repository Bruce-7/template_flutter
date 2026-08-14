# AI 辅助开发规则

本文件为所有 AI 编程助手（Claude Code、Cursor、GitHub Copilot、Windsurf 等）提供统一的开发规范和约束。

## 通用规则

### 语言规范

**默认使用中文**：
- 所有回复、注释、文档、提交信息默认使用中文
- 代码标识符（变量名、函数名、类名）使用英文
- 用户明确要求其他语言时遵循用户要求

### 代码质量原则

**遵循 Andrej Karpathy 编码准则**：
- 避免过度复杂化，优先选择简单直接的实现
- 进行外科手术式的精确修改，不做无关改动
- 明确表达假设，避免隐含的前提条件
- 定义可验证的成功标准
- 三行相似代码不强制抽象，过早抽象比重复更糟

**安全优先**：
- 敏感信息（API Key、密钥、证书）切勿硬编码或提交到版本控制
- 所有用户输入必须验证和清理
- API 接口需考虑认证和权限控制

**不添加不必要的功能**：
- 只实现明确要求的功能，不添加"可能有用"的额外特性
- 不引入未经请求的错误处理、配置选项或抽象层
- Bug 修复不需要清理周围代码
- 一次性操作不需要辅助函数

**代码注释规范**：
- 默认不写注释，代码应自解释
- 仅在以下情况添加注释：
  - 隐藏的约束或不变量
  - 微妙的边界条件
  - 针对特定 bug 的变通方案
  - 会让未来读者困惑的行为
- 不注释代码做什么（良好的命名已说明）
- 不引用当前任务、调用者或问题编号（属于 PR 描述）

---

## 项目概览

Flutter App Template 是生产级 Flutter 应用启动框架，支持 iOS、Android 和 HarmonyOS/OpenHarmony 平台的商业应用开发。

**技术栈**：
- Flutter `3.44.9`, Dart `3.12.2`
- 状态管理：`hooks_riverpod`, `flutter_hooks`, `riverpod_annotation`（代码生成）
- 路由：`auto_route`（代码生成）
- 网络：`dio`（自定义拦截器）
- 数据库：`drift`（迁移支持）
- 国际化：`easy_localization`
- UI：Material Design + 自定义主题系统

---

## 开发命令

所有命令默认使用 `fvm` 前缀。如未使用 FVM，请移除 `fvm` 前缀。

### 依赖管理

```bash
# 安装依赖
fvm flutter pub get
```

### 代码生成

```bash
# 生成所有代码（Riverpod、AutoRoute、JSON、Drift、资源）
fvm dart run build_runner build --delete-conflicting-outputs

# 监听模式（文件变化自动生成）
fvm dart run build_runner watch --delete-conflicting-outputs

# 生成 Drift 数据库迁移（在表结构变更后）
fvm dart run drift_dev make-migrations
```

**辅助脚本**：
- `scripts/build_runner.sh`: 运行代码生成
- `scripts/watch_build_runer.sh`: 监听模式代码生成
- `scripts/drift_dev_migrations.sh`: 生成 Drift 迁移

### 代码质量

```bash
# 格式化代码
fvm dart format .

# 静态分析
fvm dart analyze

# 运行测试
fvm flutter test
```

### 运行应用

```bash
# 开发模式运行
fvm flutter run

# 指定环境运行
fvm flutter run --dart-define=environment=production
```

### 构建发布

```bash
# 构建 Android APK
fvm flutter build apk --release

# 构建 Android App Bundle
fvm flutter build appbundle --release

# 构建 iOS IPA
fvm flutter build ipa --release
```

**发布脚本**：
- `scripts/publish_android.sh`: Android 发布流程
- `scripts/publish_ios.sh`: iOS 发布流程（使用 fastlane）

---

## 核心架构

### 应用启动流程

`lib/main.dart` 初始化顺序：
1. `EasyLocalization`（加载 `assets/translations/` 翻译文件）
2. `dbManager.init()`（初始化 SharedPreferences 和文档目录）
3. `purchasesManager.initialize()`（初始化 RevenueCat 订阅 SDK）
4. `ProviderScope` 包装应用根组件
5. 主题系统（支持亮色/暗色模式）
6. `FlutterSmartDialog`（Toast、Loading、Dialog 统一管理）
7. `EasyRefresh` 默认配置（下拉刷新、上拉加载）

### 目录结构

```
lib/
├── main.dart                      # 应用入口
├── routes/                        # 路由配置
│   ├── routes.dart               # AutoRoute 配置
│   ├── routes_navigator.dart     # 导航辅助类
│   └── routes.gr.dart            # 生成的路由文件（不手动编辑）
├── pages/                         # 页面模块
│   └── <module>/                 # 每个模块包含 page.dart、widget.dart、function.dart
├── providers/                     # Riverpod 状态管理
│   ├── user_state.dart           # 用户状态
│   └── theme_mode_state.dart     # 主题模式状态
├── services/                      # 网络服务
│   ├── dio/                      # Dio 配置
│   │   ├── dio_client.dart       # Dio 实例工厂
│   │   └── interceptors/         # 拦截器（请求、响应、缓存、日志）
│   ├── api/                      # API 接口模块
│   └── models/                   # API 响应模型
├── database/                      # Drift 数据库
│   ├── database.dart             # 数据库主类、连接、迁移策略
│   ├── tables/                   # 表定义
│   ├── daos/                     # 数据访问对象
│   └── database.steps.dart       # 迁移步骤辅助
├── managers/                      # 全局单例管理器
│   ├── db.dart                   # SharedPreferences 和文件路径
│   ├── logger.dart               # 日志实例
│   ├── purchases.dart            # RevenueCat 包装
│   ├── translations.dart         # 国际化配置
│   └── notification.dart         # 本地通知
├── theme/                         # 主题系统
│   ├── app_theme.dart            # 主题定义（继承 ThemeExtension）
│   ├── app_colors.dart           # 颜色设计令牌
│   ├── app_text_style.dart       # 文本样式
│   ├── app_spacing.dart          # 间距
│   ├── app_radius.dart           # 圆角
│   ├── custom_theme_colors.dart  # 用户可自定义主题色
│   └── app_theme_extension.dart  # BuildContext 扩展
├── widgets/                       # 可复用 UI 组件
├── models/                        # 数据模型（JSON 序列化）
├── utils/                         # 工具类
├── extension/                     # Dart 扩展
├── constants/                     # 常量定义
└── gen/                           # 生成的资源引用（flutter_gen）
```

### 页面模块约定

每个页面遵循三文件模式：

1. **`page.dart`**: 路由注解、页面组件、生命周期钩子、主 build 方法
2. **`widget.dart`**: 页面专属 UI 组件
3. **`function.dart`**: 页面级交互逻辑、辅助函数、回调

示例：
```dart
// page.dart
@RoutePage()
class ExamplePage extends HookConsumerWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');
      return () => log.d('$this dispose');
    }, []);
    
    return Scaffold(/*...*/);
  }
}

// widget.dart
part of 'page.dart';
// 页面 Widget 组件

// function.dart
part of 'page.dart';
// 辅助函数
```

使用 `lib/pages/template/` 作为新页面的起点。

### 路由系统

路由集中定义在 `lib/routes/routes.dart`，使用 AutoRoute 声明式语法：

```dart
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      path: '/${MainRoute.name}',
      page: MainRoute.page,
      children: [/*...*/],
    ),
    // ...
  ];
}
```

**添加新路由流程**：
1. 在 `lib/pages/<module>/` 创建页面模块
2. 在 `lib/routes/routes.dart` 注册路由
3. 运行 `fvm dart run build_runner build --delete-conflicting-outputs`
4. 使用 `RoutesNavigator.appRouter.push(NewRoute())` 或 context 扩展导航

### 状态管理

使用 Riverpod 代码生成，提供者使用 `@riverpod` 注解：

```dart
@riverpod
class UserState extends _$UserState {
  @override
  User build() => User.empty();
  
  void updateUser(User user) {
    state = user;
  }
}
```

创建或修改提供者后必须运行代码生成。

### 网络请求

`DioClient`（`lib/services/dio/dio_client.dart`）是单例工厂，按主机缓存 Dio 实例。拦截器链：

1. **CacheInterceptor**: 防止 2 秒内重复 GET 请求
2. **RequestInterceptor**: 添加请求头、认证、请求日志
3. **ApiResponseResolveInterceptor**: 解析自定义 API 响应格式、处理错误
4. **LoggingInterceptor**: 记录完整请求/响应详情

API 模块组织在 `lib/services/api/`，每个模块使用 `DioClient` 单例。

### 数据库

Drift 数据库配置在 `lib/database/database.dart`（当前作为示例注释）。结构：

- 表定义：`lib/database/tables/`
- DAO：`lib/database/daos/`
- 迁移策略：使用 `database.steps.dart` 中的 `stepByStep`
- Schema 版本：存储在 `drift/schemas/`

**表结构变更流程**：
1. 更新表定义
2. 运行 `fvm dart run drift_dev make-migrations`
3. 在 `database.dart` 实现迁移逻辑
4. 运行代码生成

### 主题系统

自定义主题系统继承 `ThemeExtension<AppTheme>`，通过 context 扩展访问：

```dart
context.colors.primary
context.textStyle.headline1
context.spacing.small
context.radius.medium
```

主题模式状态由 `themeModeStateProvider` 管理，自定义颜色通过 `CustomThemeColors` 应用。

### 国际化

翻译文件位于 `assets/translations/`（JSON 格式），在 `lib/managers/translations.dart` 配置：

```dart
class Translations {
  static const supportedLocales = [Locale('zh', 'CN'), Locale('en', 'US')];
  static const chineseSimplified = Locale('zh', 'CN');
}
```

使用 `'key'.tr()` 进行翻译查找。

### 全局服务

管理器在 `main.dart` 中初始化为单例：

- `dbManager`: SharedPreferences、文档目录访问
- `purchasesManager`: RevenueCat SDK 包装
- `log`: Logger 实例
- `Translations`: 国际化配置

---

## 代码生成规则

以下情况需要代码生成：
- Riverpod 提供者（`@riverpod` 注解）
- AutoRoute 路由（`@RoutePage()` 注解）
- JSON 序列化（`@JsonSerializable()` 注解）
- Drift 数据库（`@DriftDatabase`, `@UseRowClass` 等注解）
- 资源引用（`flutter_gen` 从 `pubspec.yaml` 的 assets）

修改带注解的代码后，必须运行 `fvm dart run build_runner build --delete-conflicting-outputs`。

生成的文件（`.g.dart`, `.gr.dart`）不得手动编辑。

---

## 环境配置

应用通过 `--dart-define=environment=<value>` 读取环境，默认为 `production`。扩展 `lib/constants/env.dart` 进行环境特定配置。

---

## 平台特定说明

- **iOS**: Xcode 项目在 `ios/`，fastlane 脚本在 `ios/fastlane/`
- **Android**: Gradle 项目在 `android/`，签名配置从 `android/key.properties` 读取（不纳入版本控制）
- **HarmonyOS**: `ohos/` 目录包含 ArkTS 入口

---

## 测试

使用 `fvm flutter test` 运行测试，Widget 测试位于 `test/`。

---

## 安全规范

### 开发时

- ✅ 使用 Dio 拦截器统一处理认证
- ✅ 验证和清理所有用户输入
- ✅ 敏感接口添加认证和权限控制

### 禁止操作

- ❌ 不要提交密钥文件（`android/key.properties`, `*.jks`, `*.keystore`, `*.p8`）
- ❌ 不要在 `lib/constants/keys.dart` 硬编码生产密钥
- ❌ 不要修改生成的文件（`.g.dart`, `.gr.dart`）
- ❌ 不要绕过 `DioClient` 自己创建 Dio 实例

### 发布前检查清单

- [ ] `android/key.properties` 未提交
- [ ] iOS 证书、Provisioning Profiles、`.p8` 文件未提交
- [ ] `lib/constants/keys.dart` 中无生产密钥
- [ ] `ios/fastlane/app_store_connect_api_key.json` 使用示例占位符
- [ ] 所有曾提交的密钥已撤销并轮换

---

## 故障排查

### 代码生成失败

```bash
# 清理生成文件后重新生成
fvm flutter clean
fvm flutter pub get
fvm dart run build_runner clean
fvm dart run build_runner build --delete-conflicting-outputs
```

### 路由未生成

```bash
# 检查页面是否有 @RoutePage() 注解
# 检查路由是否在 routes.dart 中注册
# 运行代码生成
fvm dart run build_runner build --delete-conflicting-outputs
```

### 依赖冲突

```bash
# 查看依赖树
fvm flutter pub deps

# 升级依赖
fvm flutter pub upgrade
```

---

## 开发规范

### 创建新页面

1. 复制 `lib/pages/template/` 到 `lib/pages/<new_module>/`
2. 重命名文件和类名
3. 在 `lib/routes/routes.dart` 注册路由
4. 运行代码生成

### 创建新 Provider

1. 在 `lib/providers/` 创建文件
2. 使用 `@riverpod` 注解
3. 运行代码生成
4. 通过 `ref.watch()` 或 `ref.read()` 访问

### 创建新 API 模块

1. 在 `lib/services/api/<module>/` 创建文件
2. 使用 `DioClient.instance(baseUrl)` 获取 Dio 实例
3. 在 `lib/services/models/` 定义响应模型
4. 使用 `@JsonSerializable()` 注解模型
5. 运行代码生成

### 数据库表变更

1. 修改 `lib/database/tables/` 中的表定义
2. 更新 `lib/database/database.dart` 中的 `schemaVersion`
3. 运行 `fvm dart run drift_dev make-migrations`
4. 实现 `MigrationStrategy` 中的迁移逻辑
5. 运行代码生成

---

## 参考资料

- Flutter 文档: https://flutter.dev/docs
- Riverpod 文档: https://riverpod.dev/
- AutoRoute 文档: https://autoroute.vercel.app/
- Drift 文档: https://drift.simonbinder.eu/
- EasyLocalization 文档: https://pub.dev/packages/easy_localization
