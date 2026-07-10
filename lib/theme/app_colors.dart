import 'package:flutter/material.dart';

/// 颜色系统定义
///
/// 支持明暗两种模式，包含所有界面所需的颜色定义

@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// 透明色
  /// 使用场景：用于需要透明背景的组件
  final Color transparent;

  /// 种子颜色
  /// 使用场景：Material 3 主题系统的基础颜色，用于生成整个配色方案
  /// 通常使用品牌主色，如蓝色 #2196F3
  final Color seed;

  /// 主要颜色
  /// 使用场景：用于最重要的操作和元素，如主要按钮（确认、保存、提交）、选中状态、导航栏选中项等
  final Color primary;

  /// 主要颜色上的文字/图标颜色
  /// 使用场景：绘制在 primary 颜色之上的内容，如主要按钮内的文字、图标
  /// 确保与 primary 形成足够对比度，保证可读性
  final Color onPrimary;

  /// 主要容器颜色
  /// 使用场景：主要按钮的背景、选中标签的背景、重要信息卡片背景等
  /// 比 primary 颜色更浅，用于需要突出但不过于抢眼的容器
  final Color primaryContainer;

  /// 主要容器上的文字/图标颜色
  /// 使用场景：绘制在 primaryContainer 之上的文字或图标
  /// 如主要按钮的文字、标签页选中的文字
  final Color onPrimaryContainer;

  /// 次要颜色
  /// 使用场景：用于次要的操作和元素，如次要按钮（取消、重置）、过滤标签、开关组件等
  final Color secondary;

  /// 次要颜色上的文字/图标颜色
  /// 使用场景：绘制在 secondary 颜色之上的内容，如次要按钮内的文字、图标
  final Color onSecondary;

  /// 次要容器颜色
  /// 使用场景：次要按钮的背景、未选中标签的背景、次要信息卡片背景等
  /// 用于区分不同功能区域，但不如 primaryContainer 重要
  final Color secondaryContainer;

  /// 次要容器上的文字/图标颜色
  /// 使用场景：绘制在 secondaryContainer 之上的文字或图标
  /// 如次要按钮的文字、未选中标签的文字
  final Color onSecondaryContainer;

  /// 第三颜色
  /// 使用场景：用于强调性元素、装饰性组件、特殊状态指示等
  /// 如成功提示、新功能标记、特殊分类标签
  final Color tertiary;

  /// 第三颜色上的文字/图标颜色
  /// 使用场景：绘制在 tertiary 颜色之上的内容
  final Color onTertiary;

  /// 第三容器颜色
  /// 使用场景：需要突出显示但不同于主次颜色的容器，如促销标签、新功能提示背景
  final Color tertiaryContainer;

  /// 第三容器上的文字/图标颜色
  /// 使用场景：绘制在 tertiaryContainer 之上的文字或图标
  final Color onTertiaryContainer;

  /// 错误颜色
  /// 使用场景：用于错误状态提示，如删除按钮、错误信息、验证失败提示等
  final Color error;

  /// 错误颜色上的文字/图标颜色
  /// 使用场景：绘制在 error 颜色之上的内容，如删除按钮内的文字、错误图标
  final Color onError;

  /// 错误容器颜色
  /// 使用场景：错误提示框的背景、错误输入框的边框、错误状态卡片背景等
  /// 比 error 颜色更浅，用于大面积的错误提示区域
  final Color errorContainer;

  /// 错误容器上的文字/图标颜色
  /// 使用场景：绘制在 errorContainer 之上的错误信息文字或图标
  /// 确保错误信息的可读性
  final Color onErrorContainer;

  /// 背景颜色
  /// 使用场景：应用主背景色，如页面背景、对话框背景、底部导航栏背景等
  /// 是整个应用的基础背景色
  final Color background;

  /// 背景上的文字/图标颜色
  /// 使用场景：绘制在 background 之上的主要内容文字
  /// 如正文文字、标题、列表项文字等主要文本内容
  final Color onBackground;

  /// 表面颜色
  /// 使用场景：对话框背景、底部表单背景、浮动按钮背景等
  /// 用于需要与主背景区分的组件表面
  final Color surface;

  /// 表面上的文字/图标颜色
  /// 使用场景：绘制在 surface 之上的文字或图标
  /// 如对话框标题、列表项文字
  final Color onSurface;

  /// 表面变体颜色
  /// 使用场景：需要与 surface 略有区别的表面，如未选中的筛选标签、分组标题背景等
  /// 用于创建层次感和视觉区分
  final Color surfaceVariant;

  /// 表面变体上的文字/图标颜色
  /// 使用场景：绘制在 surfaceVariant 之上的次要文字
  /// 如辅助信息文字、占位符文字、时间戳等
  final Color onSurfaceVariant;

  /// 表面容器颜色
  /// 使用场景：标准容器背景，如列表项背景、表单区域背景、内容区域背景等
  /// 是最常用的容器背景色
  final Color surfaceContainer;

  /// 低高度表面容器颜色
  /// 使用场景：需要更低调的容器，如分割线上方区域、次要内容区域、嵌套容器背景等
  /// 比 surfaceContainer 更接近背景色
  final Color surfaceContainerLow;

  /// 高高度表面容器颜色
  /// 使用场景：需要更突出的容器，如悬浮卡片、重要信息区域、突出显示的列表项等
  /// 比 surfaceContainer 更醒目
  final Color surfaceContainerHigh;

  /// 最高高度表面容器颜色
  /// 使用场景：最突出的容器，如顶部导航栏、底部操作栏、重要提示卡片等
  /// 用于需要强烈视觉区分的组件
  final Color surfaceContainerHighest;

  /// 边框和分割线颜色
  /// 使用场景：输入框边框、卡片边框、分割线、列表项分隔线等
  /// 用于定义组件边界和分隔不同区域
  final Color outline;

  /// 边框变体颜色
  /// 使用场景：需要更淡的边框，如禁用状态边框、次要分割线、装饰性线条等
  /// 比 outline 更淡，用于不希望过于明显的边界
  final Color outlineVariant;

  /// 阴影颜色
  /// 使用场景：组件阴影、浮动元素下方阴影、卡片投影等
  /// 用于创建深度感和层次感
  final Color shadow;

  /// 遮罩颜色
  /// 使用场景：全屏遮罩、模态对话框背景、加载遮罩、下拉刷新遮罩等
  /// 用于遮挡背景内容，突出前景元素
  final Color scrim;

  /// 在遮罩颜色上面常用的颜色
  final Color onScrim;

  /// 反色表面颜色
  /// 使用场景：用于反色主题的背景，如深色模式下的浅色背景、弹出菜单背景等
  /// 与 background 形成强烈对比
  final Color inverseSurface;

  /// 反色表面上的文字/图标颜色
  /// 使用场景：绘制在 inverseSurface 之上的文字或图标
  /// 确保在反色背景上的可读性
  final Color onInverseSurface;

  /// 反色主要颜色
  /// 使用场景：反色主题中的主要操作颜色，如深色背景上的浅色按钮、选中状态等
  /// 与 primary 形成对比，用于反色场景
  final Color inversePrimary;

  /// 表面色
  /// 使用场景：用于给表面着色的叠加颜色，如给卡片添加轻微的主题色调
  /// 可以通过混合到 surface 中来创建自定义表面颜色
  final Color surfaceTint;

  /// 成功颜色
  /// 使用场景：成功状态提示，如成功提示框、完成状态、验证通过、下载完成等
  /// 绿色系，表示积极的操作结果
  final Color success;

  /// 成功颜色上的文字/图标颜色
  /// 使用场景：绘制在 success 颜色之上的内容，如成功图标、成功提示文字
  /// 确保在成功背景上的可读性
  final Color onSuccess;

  /// 警告颜色
  /// 使用场景：警告状态提示，如警告提示框、注意信息、待处理事项、低电量等
  /// 黄色/橙色系，表示需要用户注意但不紧急
  final Color warning;

  /// 警告颜色上的文字/图标颜色
  /// 使用场景：绘制在 warning 颜色之上的内容，如警告图标、警告提示文字
  final Color onWarning;

  /// 禁用状态颜色
  /// 使用场景：禁用组件的背景色，如禁用按钮、禁用输入框、禁用菜单项等
  /// 表示组件不可交互状态
  final Color disabled;

  /// 禁用状态上的文字/图标颜色
  /// 使用场景：禁用组件上的文字或图标颜色
  /// 表示禁用状态下的内容，通常颜色较淡
  final Color onDisabled;

  /// 链接颜色
  /// 使用场景：可点击链接文字、超链接、引用链接等
  /// 通常使用主题蓝色，表示可交互的文本链接
  final Color link;

  /// 链接上的文字/图标颜色
  /// 使用场景：绘制在 link 颜色背景上的内容，如链接按钮内的文字
  /// 确保在链接背景上的可读性
  final Color onLink;

  const AppColors({
    required this.transparent,
    required this.seed,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.surfaceContainer,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.onScrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.disabled,
    required this.onDisabled,
    required this.link,
    required this.onLink,
  });

  /// 创建浅色主题颜色
  factory AppColors.light() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFF3A86FF),
      primary: const Color(0xFF3A86FF),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFE3F2FD),
      onPrimaryContainer: const Color(0xFF0D356B),
      secondary: const Color(0xFF9C27B0),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFF3E5F5),
      onSecondaryContainer: const Color(0xFF4A148C),
      tertiary: const Color(0xFF00BFA5),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFE0F7F6),
      onTertiaryContainer: const Color(0xFF004D40),
      error: const Color(0xFFFF5252),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFEBEE),
      onErrorContainer: const Color(0xFFC62828),
      background: const Color(0xFFFFFFFF),
      onBackground: const Color(0xFF212121),
      surface: const Color(0xFFFAFAFA),
      onSurface: const Color(0xFF222222),
      surfaceVariant: const Color(0xFFF5F5F5),
      onSurfaceVariant: const Color(0xFF757575),
      surfaceContainer: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF8F9FA),
      surfaceContainerHigh: const Color(0xFFF1F3F4),
      surfaceContainerHighest: const Color(0xFFE8EAED),
      outline: const Color(0xFFE0E0E0),
      outlineVariant: const Color(0xFFFBFBFB),
      shadow: const Color(0xFF000000).withValues(alpha: 0.1),
      scrim: const Color(0xFF000000).withValues(alpha: 0.6),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFF121212),
      onInverseSurface: const Color(0xFFF5F5F5),
      inversePrimary: const Color(0xFFA8D1FF),
      surfaceTint: const Color(0xFF3A86FF),
      success: const Color(0xFF4CAF50),
      onSuccess: const Color(0xFFFFFFFF),
      warning: const Color(0xFFFF9800),
      onWarning: const Color(0xFF000000),
      disabled: const Color(0xFFBDBDBD),
      onDisabled: const Color(0xFF9E9E9E),
      link: const Color(0xFF3A86FF),
      onLink: const Color(0xFFFFFFFF),
    );
  }

  /// 创建深色主题颜色
  factory AppColors.dark() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFF64B5F6),
      primary: const Color(0xFF64B5F6),
      onPrimary: const Color(0xFF000000),
      primaryContainer: const Color(0xFF1E3A5F),
      onPrimaryContainer: const Color(0xFFE3F2FD),
      secondary: const Color(0xFFCE93D8),
      onSecondary: const Color(0xFF000000),
      secondaryContainer: const Color(0xFF4A148C),
      onSecondaryContainer: const Color(0xFFF3E5F5),
      tertiary: const Color(0xFF4DB6AC),
      onTertiary: const Color(0xFF000000),
      tertiaryContainer: const Color(0xFF004D40),
      onTertiaryContainer: const Color(0xFFE0F7F6),
      error: const Color(0xFFEF5350),
      onError: const Color(0xFF000000),
      errorContainer: const Color(0xFFB71C1C),
      onErrorContainer: const Color(0xFFFFEBEE),
      background: const Color(0xFF121212),
      onBackground: const Color(0xFFE0E0E0),
      surface: const Color(0xFF1E1E1E),
      onSurface: const Color(0xFFE0E0E0),
      surfaceVariant: const Color(0xFF2A2A2A),
      onSurfaceVariant: const Color(0xFFBDBDBD),
      surfaceContainer: const Color(0xFF252525),
      surfaceContainerLow: const Color(0xFF1A1A1A),
      surfaceContainerHigh: const Color(0xFF2F2F2F),
      surfaceContainerHighest: const Color(0xFF3A3A3A),
      outline: const Color(0xFF424242),
      outlineVariant: const Color(0xFF303030),
      shadow: const Color(0xFF000000).withValues(alpha: 0.8),
      scrim: const Color(0xFF000000).withValues(alpha: 0.6),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFFE0E0E0),
      onInverseSurface: const Color(0xFF121212),
      inversePrimary: const Color(0xFF0D356B),
      surfaceTint: const Color(0xFF64B5F6),
      success: const Color(0xFF66BB6A),
      onSuccess: const Color(0xFF000000),
      warning: const Color(0xFFFFB74D),
      onWarning: const Color(0xFF000000),
      disabled: const Color(0xFF424242),
      onDisabled: const Color(0xFF757575),
      link: const Color(0xFF64B5F6),
      onLink: const Color(0xFF000000),
    );
  }

  /// 科技配色
  factory AppColors.tech() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFF00BCD4),
      primary: const Color(0xFF00BCD4),
      onPrimary: const Color(0xFF000000),
      primaryContainer: const Color(0xFFB2EBF2),
      onPrimaryContainer: const Color(0xFF006064),
      secondary: const Color(0xFF607D8B),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFCFD8DC),
      onSecondaryContainer: const Color(0xFF37474F),
      tertiary: const Color(0xFF009688),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFB2DFDB),
      onTertiaryContainer: const Color(0xFF004D40),
      error: const Color(0xFFF44336),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFCDD2),
      onErrorContainer: const Color(0xFFB71C1C),
      background: const Color(0xFF263238),
      onBackground: const Color(0xFFFFFFFF),
      surface: const Color(0xFF37474F),
      onSurface: const Color(0xFFFFFFFF),
      surfaceVariant: const Color(0xFF455A64),
      onSurfaceVariant: const Color(0xFFB0BEC5),
      surfaceContainer: const Color(0xFF37474F),
      surfaceContainerLow: const Color(0xFF2C3B44),
      surfaceContainerHigh: const Color(0xFF415A65),
      surfaceContainerHighest: const Color(0xFF4B636E),
      outline: const Color(0xFF546E7A),
      outlineVariant: const Color(0xFF607D8B),
      shadow: const Color(0xFF000000).withValues(alpha: 0.3),
      scrim: const Color(0xFF000000).withValues(alpha: 0.6),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFFFFFFFF),
      onInverseSurface: const Color(0xFF263238),
      inversePrimary: const Color(0xFF80DEEA),
      surfaceTint: const Color(0xFF00BCD4),
      success: const Color(0xFF4CAF50),
      onSuccess: const Color(0xFFFFFFFF),
      warning: const Color(0xFFFFC107),
      onWarning: const Color(0xFF000000),
      disabled: const Color(0xFF546E7A),
      onDisabled: const Color(0xFF90A4AE),
      link: const Color(0xFF29B6F6),
      onLink: const Color(0xFF000000),
    );
  }

  /// 终端配色
  factory AppColors.terminal() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFF00FF00),
      primary: const Color(0xFF00FF00),
      onPrimary: const Color(0xFF000000),
      primaryContainer: const Color(0xFF1A2C1A),
      onPrimaryContainer: const Color(0xFF00FF00),
      secondary: const Color(0xFFFFFF00),
      onSecondary: const Color(0xFF000000),
      secondaryContainer: const Color(0xFF333300),
      onSecondaryContainer: const Color(0xFFFFCC00),
      tertiary: const Color(0xFF00FFFF),
      onTertiary: const Color(0xFF000000),
      tertiaryContainer: const Color(0xFF003333),
      onTertiaryContainer: const Color(0xFF00CCCC),
      error: const Color(0xFFFF0000),
      onError: const Color(0xFF000000),
      errorContainer: const Color(0xFF330000),
      onErrorContainer: const Color(0xFFFF6666),
      background: const Color(0xFF0A0A0A),
      onBackground: const Color(0xFF00FF00),
      surface: const Color(0xFF121212),
      onSurface: const Color(0xFF00FF00),
      surfaceVariant: const Color(0xFF1A1A1A),
      onSurfaceVariant: const Color(0xFF66FF66),
      surfaceContainer: const Color(0xFF0F0F0F),
      surfaceContainerLow: const Color(0xFF0A0A0A),
      surfaceContainerHigh: const Color(0xFF1A1A1A),
      surfaceContainerHighest: const Color(0xFF222222),
      outline: const Color(0xFF333333),
      outlineVariant: const Color(0xFF444444),
      shadow: const Color(0xFFFFFF00).withValues(alpha: 0.1),
      scrim: const Color(0xFF000000).withValues(alpha: 0.8),
      onScrim: const Color(0xFF00FF00),
      inverseSurface: const Color(0xFF00FF00),
      onInverseSurface: const Color(0xFF000000),
      inversePrimary: const Color(0xFF003300),
      surfaceTint: const Color(0xFF00CC00),
      success: const Color(0xFF00FF00),
      onSuccess: const Color(0xFF000000),
      warning: const Color(0xFFFF6600),
      onWarning: const Color(0xFF000000),
      disabled: const Color(0xFF333333),
      onDisabled: const Color(0xFF666666),
      link: const Color(0xFF00CCFF),
      onLink: const Color(0xFF000000),
    );
  }

  /// 卡通配色
  factory AppColors.cartoon() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFFFF4081),
      primary: const Color(0xFFFF4081),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFFFE0EB),
      onPrimaryContainer: const Color(0xFFC60055),
      secondary: const Color(0xFF6200EA),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFE8E0FF),
      onSecondaryContainer: const Color(0xFF3F00B2),
      tertiary: const Color(0xFF00E676),
      onTertiary: const Color(0xFF000000),
      tertiaryContainer: const Color(0xFFE8FFE6),
      onTertiaryContainer: const Color(0xFF00C853),
      error: const Color(0xFFFF5252),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFE0E0),
      onErrorContainer: const Color(0xFFD32F2F),
      background: const Color(0xFFF5F5F5),
      onBackground: const Color(0xFF333333),
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF333333),
      surfaceVariant: const Color(0xFFF0F0F0),
      onSurfaceVariant: const Color(0xFF666666),
      surfaceContainer: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFFAFAFA),
      surfaceContainerHigh: const Color(0xFFF5F5F5),
      surfaceContainerHighest: const Color(0xFFEEEEEE),
      outline: const Color(0xFFE0E0E0),
      outlineVariant: const Color(0xFFF0F0F0),
      shadow: const Color(0xFFFF4081).withValues(alpha: 0.2),
      scrim: const Color(0xFF333333).withValues(alpha: 0.3),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFF333333),
      onInverseSurface: const Color(0xFFFFFFFF),
      inversePrimary: const Color(0xFFFFBBDD),
      surfaceTint: const Color(0xFFFF4081),
      success: const Color(0xFF00E676),
      onSuccess: const Color(0xFF000000),
      warning: const Color(0xFFFFEB3B),
      onWarning: const Color(0xFF000000),
      disabled: const Color(0xFFE0E0E0),
      onDisabled: const Color(0xFF9E9E9E),
      link: const Color(0xFF2979FF),
      onLink: const Color(0xFFFFFFFF),
    );
  }

  /// 樱花配色
  factory AppColors.sakura() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFFFFB6C1),
      primary: const Color(0xFFFFB6C1),
      onPrimary: const Color(0xFF8B4513),
      primaryContainer: const Color(0xFFFFF0F5),
      onPrimaryContainer: const Color(0xFFDB7093),
      secondary: const Color(0xFFDDA0DD),
      onSecondary: const Color(0xFF8B4513),
      secondaryContainer: const Color(0xFFF8F0FF),
      onSecondaryContainer: const Color(0xFFBA55D3),
      tertiary: const Color(0xFF98FB98),
      onTertiary: const Color(0xFF006400),
      tertiaryContainer: const Color(0xFFF0FFF0),
      onTertiaryContainer: const Color(0xFF3CB371),
      error: const Color(0xFFFF69B4),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFE0EF),
      onErrorContainer: const Color(0xFFC71585),
      background: const Color(0xFFFFFAFA),
      onBackground: const Color(0xFF8B6969),
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF8B6969),
      surfaceVariant: const Color(0xFFFFF0F5),
      onSurfaceVariant: const Color(0xFFDB7093),
      surfaceContainer: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFFFFAFA),
      surfaceContainerHigh: const Color(0xFFFFF0F5),
      surfaceContainerHighest: const Color(0xFFF8E8EE),
      outline: const Color(0xFFFFD1DC),
      outlineVariant: const Color(0xFFFFE4E9),
      shadow: const Color(0xFFFFB6C1).withValues(alpha: 0.2),
      scrim: const Color(0xFF8B6969).withValues(alpha: 0.3),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFF8B6969),
      onInverseSurface: const Color(0xFFFFFAFA),
      inversePrimary: const Color(0xFFFFD1DC),
      surfaceTint: const Color(0xFFFFB6C1),
      success: const Color(0xFF90EE90),
      onSuccess: const Color(0xFF006400),
      warning: const Color(0xFFFFD700),
      onWarning: const Color(0xFF8B4513),
      disabled: const Color(0xFFFFE4E9),
      onDisabled: const Color(0xFFDB7093),
      link: const Color(0xFF87CEEB),
      onLink: const Color(0xFF00688B),
    );
  }

  /// 海洋配色
  factory AppColors.ocean() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFF00BCD4),
      primary: const Color(0xFF00BCD4),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFE0F7FA),
      onPrimaryContainer: const Color(0xFF006064),
      secondary: const Color(0xFF2196F3),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFE3F2FD),
      onSecondaryContainer: const Color(0xFF0D47A1),
      tertiary: const Color(0xFF536DFE),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFE8EAFF),
      onTertiaryContainer: const Color(0xFF304FFE),
      error: const Color(0xFFEF5350),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFEBEE),
      onErrorContainer: const Color(0xFFC62828),
      background: const Color(0xFFE3F2FD),
      onBackground: const Color(0xFF0277BD),
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF0277BD),
      surfaceVariant: const Color(0xFFE0F7FA),
      onSurfaceVariant: const Color(0xFF00ACC1),
      surfaceContainer: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF1F8FE),
      surfaceContainerHigh: const Color(0xFFE3F2FD),
      surfaceContainerHighest: const Color(0xFFB3E5FC),
      outline: const Color(0xFFB3E5FC),
      outlineVariant: const Color(0xFFE0F7FA),
      shadow: const Color(0xFF00BCD4).withValues(alpha: 0.2),
      scrim: const Color(0xFF006064).withValues(alpha: 0.3),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFF006064),
      onInverseSurface: const Color(0xFFE0F7FA),
      inversePrimary: const Color(0xFF80DEEA),
      surfaceTint: const Color(0xFF00BCD4),
      success: const Color(0xFF4DB6AC),
      onSuccess: const Color(0xFFFFFFFF),
      warning: const Color(0xFFFFB74D),
      onWarning: const Color(0xFF000000),
      disabled: const Color(0xFFB3E5FC),
      onDisabled: const Color(0xFF4FC3F7),
      link: const Color(0xFF2979FF),
      onLink: const Color(0xFFFFFFFF),
    );
  }

  /// 春风配色
  factory AppColors.springBreeze() {
    return AppColors(
      transparent: const Color(0x00000000),
      seed: const Color(0xFF81C784),
      primary: const Color(0xFF81C784),
      onPrimary: const Color(0xFF1B5E20),
      primaryContainer: const Color(0xFFE8F5E8),
      onPrimaryContainer: const Color(0xFF2E7D32),
      secondary: const Color(0xFFF8BBD0),
      onSecondary: const Color(0xFF880E4F),
      secondaryContainer: const Color(0xFFFFF0F5),
      onSecondaryContainer: const Color(0xFFC2185B),
      tertiary: const Color(0xFF90CAF9),
      onTertiary: const Color(0xFF0D47A1),
      tertiaryContainer: const Color(0xFFE3F2FD),
      onTertiaryContainer: const Color(0xFF1976D2),
      error: const Color(0xFFEF9A9A),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFEBEE),
      onErrorContainer: const Color(0xFFC62828),
      background: const Color(0xFFFEFEF7),
      onBackground: const Color(0xFF4E342E),
      surface: const Color(0xFFFFFEF0),
      onSurface: const Color(0xFF5D4037),
      surfaceVariant: const Color(0xFFF5F5E8),
      onSurfaceVariant: const Color(0xFF8D6E63),
      surfaceContainer: const Color(0xFFFFFEF5),
      surfaceContainerLow: const Color(0xFFFEFBEB),
      surfaceContainerHigh: const Color(0xFFF5F5E0),
      surfaceContainerHighest: const Color(0xFFEBEBD6),
      outline: const Color(0xFFD7CCC8),
      outlineVariant: const Color(0xFFEFEBE9),
      shadow: const Color(0xFF8D6E63).withValues(alpha: 0.1),
      scrim: const Color(0xFF5D4037).withValues(alpha: 0.2),
      onScrim: const Color(0xFFFFFFFF),
      inverseSurface: const Color(0xFF4E342E),
      onInverseSurface: const Color(0xFFFEFEF7),
      inversePrimary: const Color(0xFFC8E6C9),
      surfaceTint: const Color(0xFF81C784),
      success: const Color(0xFFA5D6A7),
      onSuccess: const Color(0xFF1B5E20),
      warning: const Color(0xFFFFE082),
      onWarning: const Color(0xFF5D4037),
      disabled: const Color(0xFFE0D7C8),
      onDisabled: const Color(0xFFA1887F),
      link: const Color(0xFF64B5F6),
      onLink: const Color(0xFF0D47A1),
    );
  }

  /// 复制并修改部分颜色属性
  @override
  AppColors copyWith({
    Color? seed,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? surfaceContainer,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? onScrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? disabled,
    Color? onDisabled,
    Color? link,
    Color? onLink,
  }) {
    return AppColors(
      transparent: Colors.transparent,
      seed: seed ?? this.seed,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest ?? this.surfaceContainerHighest,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      onScrim: onScrim ?? this.onScrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
      link: link ?? this.link,
      onLink: onLink ?? this.onLink,
    );
  }

  /// 在两个颜色之间进行插值
  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      transparent: Color.lerp(transparent, other.transparent, t)!,
      seed: Color.lerp(seed, other.seed, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer: Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer: Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer: Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onTertiaryContainer: Color.lerp(onTertiaryContainer, other.onTertiaryContainer, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer: Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surfaceContainerLow: Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      surfaceContainerHigh: Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      surfaceContainerHighest: Color.lerp(surfaceContainerHighest, other.surfaceContainerHighest, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      onScrim: Color.lerp(onScrim, other.onScrim, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverseSurface: Color.lerp(onInverseSurface, other.onInverseSurface, t)!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      onDisabled: Color.lerp(onDisabled, other.onDisabled, t)!,
      link: Color.lerp(link, other.link, t)!,
      onLink: Color.lerp(onLink, other.onLink, t)!,
    );
  }
}
