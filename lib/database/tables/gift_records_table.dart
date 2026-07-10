// import 'dart:convert';
//
// import 'package:drift/drift.dart';
// import 'package:flutter_app/database/tables/base_mixin.dart';
// import 'package:flutter_app/models/gift_record.dart';
//
// class GiftRecordsTable extends Table with BaseMixin {
//   // 唯一id
//   TextColumn get id => text()();
//
//   // 对方姓名
//   TextColumn get name => text()();
//
//   // 关系类型（预设）
//   TextColumn get relationType => text().nullable()();
//
//   // 自定义关系（当relationType为other时使用）
//   TextColumn get customRelation => text().nullable()();
//
//   // 往来记录列表：List<GiftRecordItem> => json字符串
//   TextColumn get items => text().map(const GiftRecordItemsConverter())();
//
//   @override
//   Set<Column<Object>> get primaryKey => {id};
// }
//
// class GiftRecordItemsConverter extends TypeConverter<List<GiftRecordItem>, String> {
//   const GiftRecordItemsConverter();
//
//   @override
//   List<GiftRecordItem> fromSql(String fromDb) {
//     if (fromDb.isEmpty) return [];
//     final List<dynamic> jsonList = jsonDecode(fromDb);
//     return jsonList.map((json) => GiftRecordItem.fromJson(json as Map<String, dynamic>)).toList();
//   }
//
//   @override
//   String toSql(List<GiftRecordItem> value) {
//     return jsonEncode(value.map((item) => item.toJson()).toList());
//   }
// }
