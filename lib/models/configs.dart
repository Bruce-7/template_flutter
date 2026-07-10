import 'package:json_annotation/json_annotation.dart';

part 'configs.g.dart';

/// 配置类型枚举
/// 用于管理应用中的各类动态内容配置，如 banner、活动、设置等
/// 支持通过 type 字段区分不同类型的配置
enum ConfigType {
  /// Banner广告
  @JsonValue('banner')
  banner,

  /// 活动配置
  @JsonValue('activity')
  activity,

  /// 系统设置
  @JsonValue('setting')
  setting;

  /// 获取枚举对应的字符串值
  String toJson() {
    switch (this) {
      case ConfigType.banner:
        return 'banner';
      case ConfigType.activity:
        return 'activity';
      case ConfigType.setting:
        return 'setting';
    }
  }
}

/// 配置项模型
@JsonSerializable()
class Config {
  /// 配置项ID
  final int id;

  /// 配置项标题
  final String title;

  /// Banner图片URL，用于 banner 和 activity 类型
  @JsonKey(name: 'banner_image_url')
  final String? bannerImageUrl;

  /// 点击后跳转的目标URL
  @JsonKey(name: 'target_url')
  final String? targetUrl;

  /// 配置项的详细描述
  final String? description;

  Config({
    required this.id,
    required this.title,
    this.bannerImageUrl,
    this.targetUrl,
    this.description,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
