import 'package:json_annotation/json_annotation.dart';

part 'additional_cost.g.dart';

/// 附加费用类型
enum AdditionalCostType {
  /// 支出
  expense,

  /// 收入
  income,
}

/// 附加费用
@JsonSerializable()
class AdditionalCost {
  /// 附加费用名称（最多20个字符）
  final String name;

  /// 附加费用金额（最多12位）
  final double amount;

  /// 费用类型：支出或收入
  final AdditionalCostType type;

  /// 是否参与统计
  final bool participationStatistics;

  /// 费用日期
  final DateTime date;

  AdditionalCost({
    required this.name,
    required this.amount,
    required this.type,
    required this.participationStatistics,
    required this.date,
  });

  factory AdditionalCost.fromJson(Map<String, dynamic> json) => _$AdditionalCostFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalCostToJson(this);

  AdditionalCost copyWith({
    String? name,
    double? amount,
    AdditionalCostType? type,
    bool? participationStatistics,
    DateTime? date,
  }) {
    return AdditionalCost(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      participationStatistics: participationStatistics ?? this.participationStatistics,
      date: date ?? this.date,
    );
  }
}
