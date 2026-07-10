import 'package:json_annotation/json_annotation.dart';

part 'notification_config.g.dart';

@JsonSerializable()
class NotificationConfig {
  final bool enabled;

  // 通知提前多少天
  final int daysBeforeExpiry;

  // 自定义通知消息
  final String? customMessage;

  NotificationConfig({
    this.enabled = false,
    this.daysBeforeExpiry = 1,
    this.customMessage,
  });

  factory NotificationConfig.fromJson(Map<String, dynamic> json) => _$NotificationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationConfigToJson(this);

  NotificationConfig copyWith({
    bool? enabled,
    int? daysBeforeExpiry,
    String? customMessage,
  }) {
    return NotificationConfig(
      enabled: enabled ?? this.enabled,
      daysBeforeExpiry: daysBeforeExpiry ?? this.daysBeforeExpiry,
      customMessage: customMessage ?? this.customMessage,
    );
  }
}
