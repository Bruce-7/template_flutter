// import 'package:drift/drift.dart';
// import 'package:flutter_app/database/database.dart';
// import 'package:flutter_app/database/tables/assets_table.dart';
// import 'package:flutter_app/models/asset.dart';
// import 'package:flutter_app/models/assets_filter.dart';
//
// part 'assets_dao.g.dart';
//
// @DriftAccessor(tables: [AssetsTable])
// class AssetsDao extends DatabaseAccessor<AppDatabase> with _$AssetsDaoMixin {
//   AssetsDao(super.db);
//
//   // 批量插入资产或存在则更新
//   Future<void> insertAssetsOnConflictUpdate({required List<AssetsTableCompanion> assets}) async {
//     if (assets.isEmpty) return;
//
//     return await batch((batch) {
//       batch.insertAllOnConflictUpdate(assetsTable, assets);
//     });
//   }
//
//   // 删除资产（deletedAt软删除，非物理删除）
//   Future<void> deleteAsset({required AssetsTableCompanion asset}) {
//     final temp = asset.copyWith(deletedAt: Value(DateTime.now()));
//     return insertAssetsOnConflictUpdate(assets: [temp]);
//   }
//
//   // 一次性获取所有统计所需的资产数据（以后再考虑性能优化）
//   Future<List<AssetsTableData>> getAllAssetsForStatistics() async {
//     final query = select(assetsTable)
//       ..where(
//         (t) => t.deletedAt.isNull() & (t.participationStatistics.isNull() | t.participationStatistics.equals(true)),
//       );
//     return await query.get();
//   }
//
//   // 一次性获取所有设置了保质期的资产数据（以后再考虑性能优化）
//   Future<List<AssetsTableData>> getAllAssetsForExpirationDate() async {
//     final query = select(assetsTable);
//
//     query.where((t) => t.deletedAt.isNull());
//     query.where((t) => t.warrantyExpiryDate.isNotNull());
//     query.orderBy([(t) => OrderingTerm.desc(t.warrantyExpiryDate)]);
//
//     return await query.get();
//   }
//
//   // 一次性获取所有资产数据
//   Future<List<AssetsTableData>> getAllAssets({
//     AssetsFilter? filter,
//     bool includeDeleted = false,
//   }) async {
//     final query = select(assetsTable);
//
//     if (filter != null) {
//       _queryFilter(filter: filter, query: query, includeDeleted: includeDeleted);
//     } else {
//       // 软删除过滤
//       if (includeDeleted == false) query.where((t) => t.deletedAt.isNull());
//     }
//
//     return query.get();
//   }
//
//   // 分页获取资产
//   Future<List<AssetsTableData>> getAssetsPagedData({
//     required int offset,
//     required int limit,
//     required AssetsFilter filter,
//     bool includeDeleted = false,
//   }) async {
//     if (offset < 0) offset = 0;
//     if (limit < 0) limit = 20; // 默认分页数量
//
//     final query = select(assetsTable);
//
//     _queryFilter(filter: filter, query: query, includeDeleted: includeDeleted);
//
//     // 分页获取
//     query.limit(limit, offset: offset);
//     return query.get();
//   }
//
//   // 获取总数（用于分页计算）
//   Future<int> getTotalCount({bool includeDeleted = false}) async {
//     final query = selectOnly(assetsTable)..addColumns([assetsTable.id.count()]);
//
//     if (includeDeleted == false) {
//       query.where(assetsTable.deletedAt.isNull());
//     }
//
//     final result = await query.getSingle();
//     return result.read(assetsTable.id.count()) ?? 0;
//   }
//
//   void _queryFilter({
//     required AssetsFilter filter,
//     required SimpleSelectStatement<$AssetsTableTable, AssetsTableData> query,
//     bool includeDeleted = false,
//   }) {
//     // 关键词搜索
//     if (filter.keyword?.isNotEmpty == true) {
//       query.where((t) => t.name.contains(filter.keyword!) | t.remarks.contains(filter.keyword!));
//     }
//
//     // 软删除过滤
//     if (includeDeleted == false) query.where((t) => t.deletedAt.isNull());
//
//     // 筛选状态
//     switch (filter.type) {
//       case AssetFilterType.all:
//         break;
//
//       case AssetFilterType.participated:
//         query.where((t) => t.participationStatistics.isNull() | t.participationStatistics.equals(true));
//         break;
//
//       case AssetFilterType.notParticipated:
//         query.where((t) => t.participationStatistics.equals(false));
//         break;
//
//       case AssetFilterType.inUse:
//         query.where((t) => t.inUse.equals(true));
//         break;
//
//       case AssetFilterType.notInUse:
//         query.where((t) => t.inUse.equals(false));
//         break;
//
//       case AssetFilterType.underWarranty:
//         query.where((t) => t.warrantyExpiryDate.isNotNull() & t.warrantyExpiryDate.isBiggerThanValue(DateTime.now()));
//         break;
//
//       case AssetFilterType.outOfWarranty:
//         query.where((t) => t.warrantyExpiryDate.isNotNull() & t.warrantyExpiryDate.isSmallerOrEqualValue(DateTime.now()));
//         break;
//     }
//
//     // 筛选分类
//     if (filter.category?.isNotEmpty == true) query.where((t) => t.category.equals(filter.category!));
//
//     // 筛选购买日期范围
//     if (filter.startDate != null) {
//       query.where((t) => t.purchaseDate.isBiggerOrEqualValue(filter.startDate!));
//     }
//
//     if (filter.endDate != null) {
//       final endOfDay = DateTime(filter.endDate!.year, filter.endDate!.month, filter.endDate!.day, 23, 59, 59);
//       query.where((t) => t.purchaseDate.isSmallerOrEqualValue(endOfDay));
//     }
//
//     // 排序
//     switch (filter.sort) {
//       case AssetSort.createdAt:
//         query.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
//         break;
//
//       case AssetSort.oldestPurchaseDate:
//         query.orderBy([(t) => OrderingTerm.asc(t.purchaseDate)]);
//         break;
//
//       case AssetSort.latestPurchaseDate:
//         query.orderBy([(t) => OrderingTerm.desc(t.purchaseDate)]);
//         break;
//
//       case AssetSort.lowestPrice:
//         query.orderBy([(t) => OrderingTerm.asc(t.price)]);
//         break;
//
//       case AssetSort.highestPrice:
//         query.orderBy([(t) => OrderingTerm.desc(t.price)]);
//         break;
//
//       case AssetSort.leastUseCount:
//         query.orderBy([(t) => OrderingTerm.asc(t.useCount)]);
//         break;
//
//       case AssetSort.mostUseCount:
//         query.orderBy([(t) => OrderingTerm.desc(t.useCount)]);
//         break;
//     }
//   }
// }
