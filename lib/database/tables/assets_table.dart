// import 'dart:convert';
//
// import 'package:drift/drift.dart';
// import 'package:flutter_app/database/tables/base_mixin.dart';
// import 'package:flutter_app/models/additional_cost.dart';
// import 'package:flutter_app/models/notification_config.dart';
//
// class AssetsTable extends Table with BaseMixin {
//   // // 自增主键
//   // IntColumn get autoId => integer().autoIncrement()();
//
//   // 唯一id
//   TextColumn get id => text()();
//
//   // 相机相册选择的图标名称
//   TextColumn get imageName => text().nullable()();
//
//   // Emoji 图标（与 imageName 二选一）
//   TextColumn get iconEmoji => text().nullable()();
//
//   // 名称
//   TextColumn get name => text()();
//
//   // 购买日期
//   DateTimeColumn get purchaseDate => dateTime().withDefault(currentDateAndTime)();
//
//   // 购买价格
//   RealColumn get price => real()();
//
//   // 数量
//   IntColumn get quantity => integer().nullable()();
//
//   // 分类
//   TextColumn get category => text().nullable()();
//
//   // 品牌
//   TextColumn get brand => text().nullable()();
//
//   // 型号
//   TextColumn get model => text().nullable()();
//
//   // 使用次数
//   IntColumn get useCount => integer().nullable()();
//
//   // 使用中
//   BoolColumn get inUse => boolean().nullable()();
//
//   /// 是否参与统计
//   BoolColumn get participationStatistics => boolean().nullable()();
//
//   // 目标日均成本
//   RealColumn get dailyCost => real().nullable()();
//
//   // 备注
//   TextColumn get remarks => text().nullable()();
//
//   // 备注图片名称：name.png。 List<String> => json字符串
//   TextColumn get imageRemarks => text().map(const AssetsImageRemarksConverter()).nullable()();
//
//   // 保质日期
//   DateTimeColumn get warrantyExpiryDate => dateTime().nullable()();
//
//   // 附加费用：List<AdditionalCost> => json字符串
//   TextColumn get additionalCosts => text().map(const AdditionalCostsConverter()).nullable()();
//
//   // 标签：List<String> => json字符串
//   TextColumn get tags => text().map(const AssetsTagsConverter()).nullable()();
//
//   // 通知配置：NotificationConfig => json字符串
//   TextColumn get notificationConfig => text().map(const NotificationConfigConverter()).nullable()();
//
//   // 停止使用日期
//   DateTimeColumn get stopUsingAt => dateTime().nullable()();
//
//   @override
//   Set<Column<Object>> get primaryKey => {id};
// }
//
// // 继承 TypeConverter<T, S>，T 是自定义类型，S 是数据库存储的基础类型
// class AssetsImageRemarksConverter extends TypeConverter<List<String>, String?> {
//   const AssetsImageRemarksConverter();
//
//   @override
//   List<String> fromSql(String? fromDb) {
//     return jsonDecode(fromDb ?? '[]').cast<String>();
//   }
//
//   @override
//   String toSql(List<String> value) {
//     return jsonEncode(value);
//   }
// }
//
// // 附加费用转换器
// class AdditionalCostsConverter extends TypeConverter<List<AdditionalCost>, String?> {
//   const AdditionalCostsConverter();
//
//   @override
//   List<AdditionalCost> fromSql(String? fromDb) {
//     if (fromDb == null || fromDb.isEmpty) return [];
//     final List<dynamic> jsonList = jsonDecode(fromDb);
//     return jsonList.map((json) => AdditionalCost.fromJson(json as Map<String, dynamic>)).toList();
//   }
//
//   @override
//   String toSql(List<AdditionalCost> value) {
//     return jsonEncode(value.map((cost) => cost.toJson()).toList());
//   }
// }
//
// // 标签转换器
// class AssetsTagsConverter extends TypeConverter<List<String>, String?> {
//   const AssetsTagsConverter();
//
//   @override
//   List<String> fromSql(String? fromDb) {
//     return jsonDecode(fromDb ?? '[]').cast<String>();
//   }
//
//   @override
//   String toSql(List<String> value) {
//     return jsonEncode(value);
//   }
// }
//
// // 通知配置转换器
// class NotificationConfigConverter extends TypeConverter<NotificationConfig?, String?> {
//   const NotificationConfigConverter();
//
//   @override
//   NotificationConfig? fromSql(String? fromDb) {
//     if (fromDb == null || fromDb.isEmpty) return null;
//     return NotificationConfig.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
//   }
//
//   @override
//   String? toSql(NotificationConfig? value) {
//     if (value == null) return null;
//     return jsonEncode(value.toJson());
//   }
// }
