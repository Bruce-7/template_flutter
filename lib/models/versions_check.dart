import 'package:json_annotation/json_annotation.dart';

part 'versions_check.g.dart';

/// 应用平台枚举，与后端 PLATFORM_CHOICES 对齐
enum AppPlatform {
  ios('ios', 'iOS'),
  android('android', 'Android'),
  all('all', '全平台');

  final String value;
  final String displayName;

  const AppPlatform(this.value, this.displayName);

  static AppPlatform fromJson(String? value) {
    if (value == null) {
      return AppPlatform.all;
    }

    return AppPlatform.values.firstWhere(
      (item) => item.value == value,
      orElse: () => AppPlatform.all,
    );
  }

  String toJson() => value;
}

AppPlatform _platformFromJson(String? value) => AppPlatform.fromJson(value);

String _platformToJson(AppPlatform platform) => platform.toJson();

/// 版本更新检查数据模型
@JsonSerializable()
class VersionsCheck {
  /// 是否存在新版本，对应后端 has_update
  @JsonKey(name: 'has_update')
  final bool hasUpdate;

  /// 当前版本是否被强制更新，对应后端 is_force_update
  @JsonKey(name: 'is_force_update')
  final bool isForceUpdate;

  /// 最新版本详情，可能为空
  @JsonKey(name: 'latest_version')
  final LatestVersionInfo? latestVersion;

  const VersionsCheck({
    required this.hasUpdate,
    required this.isForceUpdate,
    this.latestVersion,
  });

  factory VersionsCheck.fromJson(Map<String, dynamic> json) => _$VersionsCheckFromJson(json);

  Map<String, dynamic> toJson() => _$VersionsCheckToJson(this);
}

/// 最新版本详细信息
@JsonSerializable()
class LatestVersionInfo {
  /// 版本记录主键 id
  final int id;

  /// 版本所属平台标识：ios/android/all
  @JsonKey(name: 'platform', fromJson: _platformFromJson, toJson: _platformToJson)
  final AppPlatform platform;

  /// 平台展示文案，例如 Android、iOS
  @JsonKey(name: 'platform_display')
  final String platformDisplay;

  /// 用于比较的版本号（递增整型）
  @JsonKey(name: 'version_code')
  final int versionCode;

  /// 人类可读的版本名称，如 1.7.1
  @JsonKey(name: 'version_name')
  final String versionName;

  /// 更新弹窗标题
  final String? title;

  /// 更新描述信息
  final String? description;

  /// 应用下载链接
  @JsonKey(name: 'download_url')
  final String downloadUrl;

  /// 该版本是否强制更新
  @JsonKey(name: 'is_force_update')
  final bool isForceUpdate;

  /// 是否启用此版本
  @JsonKey(name: 'is_active')
  final bool isActive;

  /// 详细更新日志，支持 Markdown
  @JsonKey(name: 'release_notes')
  final String? releaseNotes;

  /// 最低支持版本（小于该版本需强更）
  @JsonKey(name: 'min_support_version')
  final int? minSupportVersion;

  /// 创建时间，后端 ISO8601 字符串
  @JsonKey(name: 'create_time')
  final DateTime? createTime;

  /// 更新时间，后端 ISO8601 字符串
  @JsonKey(name: 'update_time')
  final DateTime? updateTime;

  const LatestVersionInfo({
    required this.id,
    required this.platform,
    required this.platformDisplay,
    required this.versionCode,
    required this.versionName,
    required this.downloadUrl,
    required this.isForceUpdate,
    required this.isActive,
    this.title,
    this.description,
    this.releaseNotes,
    this.minSupportVersion,
    this.createTime,
    this.updateTime,
  });

  factory LatestVersionInfo.fromJson(Map<String, dynamic> json) => _$LatestVersionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LatestVersionInfoToJson(this);

  // 当前版本的 versionCode 小于 minSupportVersion 也是强制更新
  bool getForceUpdate(int currentVersionCode) {
    if (isForceUpdate) return isForceUpdate;

    if (minSupportVersion != null) {
      return currentVersionCode < minSupportVersion!;
    }

    return false;
  }
}
