// import 'package:easy_refresh/easy_refresh.dart';
// import 'package:flutter_app/database/daos/assets_dao.dart';
// import 'package:flutter_app/database/database.dart';
// import 'package:flutter_app/managers/db.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/models/asset.dart';
// import 'package:flutter_app/models/assets_filter.dart';
// import 'package:flutter_app/models/pagination_data.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'assets_state.g.dart';
//
// @riverpod
// class AssetsState extends _$AssetsState {
//   final AssetsDao _assetsDao = dbManager.database.assetsDao;
//
//   @override
//   FutureOr<PaginationData<Asset>> build({
//     required AssetsFilter filter,
//   }) async {
//     ref.onDispose(() {
//       log.d('$this dispose');
//     });
//
//     log.d('$this build');
//
//     final pagedData = PaginationData<Asset>.defaultController();
//     final List<AssetsTableData> dbData;
//
//     if (filter.tags?.isNotEmpty == true) {
//       // 如果有tags筛选就全量获取数据，内存处理过滤。
//       dbData = await _assetsDao.getAllAssets(filter: filter);
//     } else {
//       dbData = await _assetsDao.getAssetsPagedData(
//         offset: pagedData.offset,
//         limit: pagedData.limit,
//         filter: filter,
//       );
//     }
//
//     log.d('$this build 获取 Assets 数据数量: ${dbData.length}');
//     List<Asset> tempAssets = [];
//     if (dbData.isNotEmpty) {
//       tempAssets = dbData.map((e) => Asset.fromAssetsTableData(e)).toList();
//
//       if (filter.tags?.isNotEmpty == true) {
//         // 过滤不符合当前筛选条件的资产
//         tempAssets = tempAssets.where((asset) {
//           return _isAssetPassFilter(asset, filter);
//         }).toList();
//       }
//
//       // 过滤完在排序。
//       tempAssets = _sortAssets(assets: tempAssets);
//
//       if (tempAssets.length < pagedData.limit) {
//         pagedData.noMore = true;
//
//         // 因为说异步原因，首次立马设置noMore不生效，延迟一会儿。
//         Future.delayed(const Duration(milliseconds: 1000), () {
//           pagedData.refreshController.finishLoad(IndicatorResult.noMore);
//         });
//       } else {
//         pagedData.noMore = false;
//
//         // 因为说异步原因，首次立马设置noMore不生效，延迟一会儿。
//         Future.delayed(const Duration(milliseconds: 1000), () {
//           pagedData.refreshController.finishLoad(IndicatorResult.success);
//         });
//       }
//     }
//
//     pagedData.offset = tempAssets.length;
//     return pagedData.copyWith(count: 0, results: tempAssets, next: null, previous: null);
//   }
//
//   // 批量资产插入或更新
//   void insertAssetsOnConflictUpdate({required List<Asset> assets}) {
//     _insertAssetsOnConflictUpdate(assets: assets);
//   }
//
//   // 单个资产插入或更新
//   void insertAssetOnConflictUpdate({required Asset asset}) {
//     _insertAssetsOnConflictUpdate(assets: [asset]);
//   }
//
//   // 删除资产
//   Future<void> deleteAsset({required Asset asset}) async {
//     await _assetsDao.deleteAsset(asset: asset.toCompanion());
//
//     if (!state.hasValue) return;
//     final pagedData = state.value;
//     if (pagedData == null) return;
//
//     // 从内存中移除
//     pagedData.results?.removeWhere((oldAsset) => oldAsset.id == asset.id);
//
//     pagedData.offset = pagedData.results?.length ?? 0;
//
//     // 重置 noMore 状态，因为删除后可能有更多数据可以加载
//     if (pagedData.noMore) {
//       pagedData.noMore = false;
//     }
//
//     state = AsyncValue.data(pagedData);
//   }
//
//   void onRefresh() async {
//     if (!state.hasValue) return;
//     final pagedData = state.value;
//     if (pagedData == null) return;
//
//     pagedData.offset = 0;
//
//     final dbData = await _assetsDao.getAssetsPagedData(
//       offset: pagedData.offset,
//       limit: pagedData.limit,
//       filter: filter,
//     );
//     log.d('$this onRefresh 获取 Assets 数据数量: ${dbData.length}');
//
//     if (dbData.length < pagedData.limit) {
//       pagedData.noMore = true;
//       pagedData.refreshController.finishLoad(IndicatorResult.noMore);
//     } else {
//       pagedData.noMore = false;
//       pagedData.refreshController.finishLoad(IndicatorResult.success);
//     }
//
//     pagedData.refreshController.finishRefresh(IndicatorResult.success);
//
//     if (dbData.isNotEmpty) {
//       _insertAssetsOnConflictUpdate(assets: dbData.map((e) => Asset.fromAssetsTableData(e)).toList(), writeToDatabase: false);
//     }
//   }
//
//   void onLoad() async {
//     if (!state.hasValue) return;
//     final pagedData = state.value;
//     if (pagedData == null) return;
//
//     final dbData = await _assetsDao.getAssetsPagedData(
//       offset: pagedData.offset,
//       limit: pagedData.limit,
//       filter: filter,
//     );
//     log.d('$this onLoad 获取 Assets 数据数量: ${dbData.length}');
//
//     if (dbData.length < pagedData.limit) {
//       pagedData.noMore = true;
//       pagedData.refreshController.finishLoad(IndicatorResult.noMore);
//     } else {
//       pagedData.noMore = false;
//       pagedData.refreshController.finishLoad(IndicatorResult.success);
//     }
//
//     if (dbData.isNotEmpty) {
//       _insertAssetsOnConflictUpdate(assets: dbData.map((e) => Asset.fromAssetsTableData(e)).toList(), writeToDatabase: false);
//     }
//   }
//
//   // ---私有方法---
//
//   // assets根据filter.sort排序
//   List<Asset> _sortAssets({required List<Asset> assets}) {
//     if (assets.length <= 1) return assets;
//
//     switch (filter.sort) {
//       case AssetSort.createdAt:
//         assets.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//         break;
//
//       case AssetSort.oldestPurchaseDate:
//         assets.sort((a, b) => a.purchaseDate.compareTo(b.purchaseDate));
//         break;
//
//       case AssetSort.latestPurchaseDate:
//         assets.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));
//         break;
//
//       case AssetSort.lowestPrice:
//         assets.sort((a, b) => a.price.compareTo(b.price));
//         break;
//
//       case AssetSort.highestPrice:
//         assets.sort((a, b) => b.price.compareTo(a.price));
//         break;
//
//       case AssetSort.leastUseCount:
//         assets.sort((a, b) => (a.useCount ?? 0).compareTo((b.useCount ?? 0)));
//         break;
//
//       case AssetSort.mostUseCount:
//         assets.sort((a, b) => (b.useCount ?? 0).compareTo((a.useCount ?? 0)));
//         break;
//     }
//
//     return assets;
//   }
//
//   void _insertAssetsOnConflictUpdate({required List<Asset> assets, bool writeToDatabase = true}) {
//     if (assets.isEmpty) {
//       return;
//     }
//
//     // 异步插入数据
//     if (writeToDatabase) {
//       _assetsDao.insertAssetsOnConflictUpdate(assets: assets.map((e) => e.toCompanion()).toList());
//     }
//
//     if (!state.hasValue) {
//       return;
//     }
//     final pagedData = state.value;
//     if (pagedData == null) return;
//
//     List<Asset>? tempAssets = pagedData.results;
//     // 内存存在则替换，不存在则添加
//     if (tempAssets?.isNotEmpty == true) {
//       for (final asset in assets) {
//         final index = tempAssets!.indexWhere((e) => e.id == asset.id);
//         if (index != -1) {
//           tempAssets[index] = asset;
//         } else {
//           tempAssets.add(asset);
//         }
//       }
//     } else {
//       tempAssets = assets;
//     }
//
//     // 过滤不符合当前筛选条件的资产
//     tempAssets = tempAssets?.where((asset) {
//       return _isAssetPassFilter(asset, filter);
//     }).toList();
//
//     // 重新排序
//     if (tempAssets?.isNotEmpty == true) {
//       tempAssets = _sortAssets(assets: tempAssets!);
//     }
//
//     pagedData.offset = tempAssets?.length ?? 0;
//     state = AsyncValue.data(pagedData.copyWith(count: 0, results: tempAssets, next: null, previous: null));
//   }
//
//   // 过滤不符合当前筛选条件的资产
//   // return true则满足条件，false则不满足需要过滤。
//   bool _isAssetPassFilter(Asset asset, AssetsFilter filter) {
//     bool isPass = true;
//
//     // 搜索关键字
//     if (filter.keyword?.isNotEmpty == true) {
//       final keyword = filter.keyword!;
//       final matchName = asset.name.contains(keyword);
//       final matchRemarks = asset.remarks?.contains(keyword) ?? false;
//       if (!matchName && !matchRemarks) {
//         return false;
//       }
//     }
//
//     // 类型筛选
//     switch (filter.type) {
//       case AssetFilterType.all:
//         break;
//
//       case AssetFilterType.participated:
//         if (!asset.participationStatistics) isPass = false;
//         break;
//
//       case AssetFilterType.notParticipated:
//         if (asset.participationStatistics) isPass = false;
//         break;
//
//       case AssetFilterType.inUse:
//         if (!asset.inUse) isPass = false;
//         break;
//
//       case AssetFilterType.notInUse:
//         if (asset.inUse) isPass = false;
//         break;
//
//       case AssetFilterType.underWarranty:
//         if (asset.warrantyExpiryDate == null || DateTime.now().isAfter(asset.warrantyExpiryDate!)) {
//           isPass = false;
//         }
//         break;
//
//       case AssetFilterType.outOfWarranty:
//         if (asset.warrantyExpiryDate == null || DateTime.now().isBefore(asset.warrantyExpiryDate!)) {
//           isPass = false;
//         }
//         break;
//     }
//
//     // 分类筛选（如果有）
//     if (filter.category != null && filter.category!.isNotEmpty) {
//       if (asset.category != filter.category) {
//         isPass = false;
//       }
//     }
//
//     // 标签筛选（如果有）- 多选，资产需要包含所有选中的标签
//     if (filter.tags != null && filter.tags!.isNotEmpty) {
//       final assetTags = asset.getTags();
//       for (final tag in filter.tags!) {
//         if (!assetTags.contains(tag)) {
//           isPass = false;
//           break;
//         }
//       }
//     }
//
//     // 购买日期范围筛选
//     if (filter.startDate != null) {
//       if (asset.purchaseDate.isBefore(filter.startDate!)) {
//         isPass = false;
//       }
//     }
//
//     if (filter.endDate != null) {
//       final endOfDay = DateTime(filter.endDate!.year, filter.endDate!.month, filter.endDate!.day, 23, 59, 59);
//       if (asset.purchaseDate.isAfter(endOfDay)) {
//         isPass = false;
//       }
//     }
//
//     return isPass;
//   }
// }
