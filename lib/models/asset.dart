import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/models/additional_cost.dart';
import 'package:flutter_app/models/notification_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

// 筛选类型
enum AssetFilterType {
  all /*全部*/,
  participated /*已统计*/,
  notParticipated /*未统计*/,
  inUse /*使用中*/,
  notInUse /*未使用*/,
  underWarranty /*在保*/,
  outOfWarranty /*过保*/,
  ;

  String text() {
    switch (this) {
      case AssetFilterType.all:
        return '全部'.tr();
      case AssetFilterType.participated:
        return '已统计'.tr();
      case AssetFilterType.notParticipated:
        return '未统计'.tr();
      case AssetFilterType.inUse:
        return '使用中'.tr();
      case AssetFilterType.notInUse:
        return '未使用'.tr();
      case AssetFilterType.underWarranty:
        return '在保'.tr();
      case AssetFilterType.outOfWarranty:
        return '过保'.tr();
    }
  }
}

// 筛选排序
enum AssetSort {
  createdAt /*创建时间*/,
  oldestPurchaseDate /*最早购买*/,
  latestPurchaseDate /*最新购买*/,
  lowestPrice /*最低价格*/,
  highestPrice /*最高价格*/,
  leastUseCount /*使用次数最少*/,
  mostUseCount /*使用次数最多*/,
  ;

  String text() {
    switch (this) {
      case AssetSort.createdAt:
        return '创建时间'.tr();
      case AssetSort.oldestPurchaseDate:
        return '最早购买'.tr();
      case AssetSort.latestPurchaseDate:
        return '最新购买'.tr();
      case AssetSort.lowestPrice:
        return '最低价格'.tr();
      case AssetSort.highestPrice:
        return '最高价格'.tr();
      case AssetSort.leastUseCount:
        return '使用次数最少'.tr();
      case AssetSort.mostUseCount:
        return '使用次数最多'.tr();
    }
  }
}

@JsonSerializable()
class Asset {
  // 资产唯一id
  final String id;
  final String name;
  final String? category;
  final double price;
  final int? quantity;
  final DateTime purchaseDate;

  // 使用中
  final bool inUse;

  /// 是否参与统计
  final bool participationStatistics;

  // 创建时间
  final DateTime createdAt;

  // 本地图片的名称
  final String? imageName;

  // Emoji 图标（与 imageName 二选一）
  final String? iconEmoji;

  final String? brand;
  final String? model;

  // 目标日均成本
  final double? dailyCost;

  // 使用次数
  final int? useCount;

  final String? remarks;

  // 备注图片名称：[name.png]。
  final List<String>? imageRemarks;

  // 保质日期
  final DateTime? warrantyExpiryDate;

  // 附加费用
  final List<AdditionalCost>? additionalCosts;

  // 标签
  final List<String>? tags;

  // 通知配置
  final NotificationConfig? notificationConfig;

  // 停止使用日期
  final DateTime? stopUsingAt;

  // 更新时间
  final DateTime? updatedAt;

  // 删除时间
  final DateTime? deletedAt;

  Asset({
    required this.id,
    required this.createdAt,
    required this.purchaseDate,
    this.imageName,
    this.iconEmoji,
    this.name = '',
    this.category,
    this.price = 0.00,
    this.quantity,
    this.brand,
    this.model,
    this.dailyCost,
    this.remarks,
    this.imageRemarks,
    this.useCount,
    this.inUse = true,
    this.participationStatistics = true,
    this.warrantyExpiryDate,
    this.additionalCosts,
    this.tags,
    this.notificationConfig,
    this.stopUsingAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);

  Asset copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    int? quantity,
    DateTime? purchaseDate,
    bool? inUse,
    bool? participationStatistics,
    DateTime? createdAt,
    String? imageName,
    String? iconEmoji,
    String? brand,
    String? model,
    double? dailyCost,
    int? useCount,
    String? remarks,
    List<String>? imageRemarks,
    DateTime? warrantyExpiryDate,
    List<AdditionalCost>? additionalCosts,
    List<String>? tags,
    NotificationConfig? notificationConfig,
    DateTime? stopUsingAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      inUse: inUse ?? this.inUse,
      participationStatistics: participationStatistics ?? this.participationStatistics,
      createdAt: createdAt ?? this.createdAt,
      imageName: imageName ?? this.imageName,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      dailyCost: dailyCost ?? this.dailyCost,
      useCount: useCount ?? this.useCount,
      remarks: remarks ?? this.remarks,
      imageRemarks: imageRemarks ?? this.imageRemarks,
      warrantyExpiryDate: warrantyExpiryDate ?? this.warrantyExpiryDate,
      additionalCosts: additionalCosts ?? this.additionalCosts,
      tags: tags ?? this.tags,
      notificationConfig: notificationConfig ?? this.notificationConfig,
      stopUsingAt: stopUsingAt ?? this.stopUsingAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  List<String> getTags() {
    return tags ?? [];
  }

// AssetsTableCompanion toCompanion() {
//   return AssetsTableCompanion(
//     id: Value(id),
//     createdAt: Value(createdAt),
//     updatedAt: Value(updatedAt ?? DateTime.now()),
//     deletedAt: Value(deletedAt),
//     imageName: Value(imageName),
//     iconEmoji: Value(iconEmoji),
//     name: Value(name),
//     category: Value(category),
//     purchaseDate: Value(purchaseDate),
//     price: Value(price),
//     quantity: Value(quantity),
//     brand: Value(brand),
//     model: Value(model),
//     dailyCost: Value(dailyCost),
//     remarks: Value(remarks),
//     imageRemarks: Value(imageRemarks ?? []),
//     useCount: Value(useCount),
//     inUse: Value(inUse),
//     participationStatistics: Value(participationStatistics),
//     warrantyExpiryDate: Value(warrantyExpiryDate),
//     additionalCosts: Value(additionalCosts ?? []),
//     tags: Value(tags ?? []),
//     notificationConfig: Value(notificationConfig),
//     stopUsingAt: Value(stopUsingAt),
//   );
// }
//
// factory Asset.fromAssetsTableData(AssetsTableData data) {
//   return Asset(
//     id: data.id,
//     createdAt: data.createdAt,
//     updatedAt: data.updatedAt,
//     deletedAt: data.deletedAt,
//     imageName: data.imageName,
//     iconEmoji: data.iconEmoji,
//     name: data.name,
//     category: data.category,
//     purchaseDate: data.purchaseDate,
//     price: data.price,
//     quantity: data.quantity,
//     brand: data.brand,
//     model: data.model,
//     dailyCost: data.dailyCost,
//     remarks: data.remarks,
//     imageRemarks: data.imageRemarks,
//     useCount: data.useCount,
//     inUse: data.inUse ?? true,
//     participationStatistics: data.participationStatistics ?? true,
//     warrantyExpiryDate: data.warrantyExpiryDate,
//     additionalCosts: data.additionalCosts,
//     tags: data.tags,
//     notificationConfig: data.notificationConfig,
//     stopUsingAt: data.stopUsingAt,
//   );
// }
}
