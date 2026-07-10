// import 'package:drift/drift.dart';
// import 'package:flutter_app/database/database.dart';
// import 'package:flutter_app/database/tables/gift_records_table.dart';
//
// part 'gift_records_dao.g.dart';
//
// @DriftAccessor(tables: [GiftRecordsTable])
// class GiftRecordsDao extends DatabaseAccessor<AppDatabase> with _$GiftRecordsDaoMixin {
//   GiftRecordsDao(super.db);
//
//   // 批量插入礼记记录或存在则更新
//   Future<void> insertRecordsOnConflictUpdate({required List<GiftRecordsTableCompanion> records}) async {
//     if (records.isEmpty) return;
//
//     return await batch((batch) {
//       batch.insertAllOnConflictUpdate(giftRecordsTable, records);
//     });
//   }
//
//   // 删除礼记记录（deletedAt软删除，非物理删除）
//   Future<void> deleteRecord({required GiftRecordsTableCompanion record}) {
//     final temp = record.copyWith(deletedAt: Value(DateTime.now()));
//     return insertRecordsOnConflictUpdate(records: [temp]);
//   }
//
//   // 一次性获取所有礼记记录
//   Future<List<GiftRecordsTableData>> getAllRecords({
//     String? keyword,
//     bool includeDeleted = false,
//   }) async {
//     final query = select(giftRecordsTable);
//
//     // 注意：关键词搜索包括 name
//     // 但 items 中的 scene 和 remarks 需要在应用层过滤（因为是JSON字段）
//     if (keyword?.isNotEmpty == true) {
//       query.where((t) =>
//         t.name.contains(keyword!) |
//         t.items.contains(keyword) // 搜索JSON字符串中的内容
//       );
//     }
//
//     if (!includeDeleted) {
//       query.where((t) => t.deletedAt.isNull());
//     }
//
//     query.orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
//
//     return query.get();
//   }
//
//   // 分页获取礼记记录
//   Future<List<GiftRecordsTableData>> getRecordsPagedData({
//     required int offset,
//     required int limit,
//     String? keyword,
//     bool includeDeleted = false,
//   }) async {
//     if (offset < 0) offset = 0;
//     if (limit < 0) limit = 20;
//
//     final query = select(giftRecordsTable);
//
//     // 注意：关键词搜索包括 name
//     // 但 items 中的 scene 和 remarks 需要在应用层过滤（因为是JSON字段）
//     if (keyword?.isNotEmpty == true) {
//       query.where((t) =>
//         t.name.contains(keyword!) |
//         t.items.contains(keyword) // 搜索JSON字符串中的内容
//       );
//     }
//
//     if (!includeDeleted) {
//       query.where((t) => t.deletedAt.isNull());
//     }
//
//     query.orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
//     query.limit(limit, offset: offset);
//
//     return query.get();
//   }
//
//   // 获取总数（用于分页计算）
//   Future<int> getTotalCount({bool includeDeleted = false}) async {
//     final query = selectOnly(giftRecordsTable)..addColumns([giftRecordsTable.id.count()]);
//
//     if (!includeDeleted) {
//       query.where(giftRecordsTable.deletedAt.isNull());
//     }
//
//     final result = await query.getSingle();
//     return result.read(giftRecordsTable.id.count()) ?? 0;
//   }
// }
