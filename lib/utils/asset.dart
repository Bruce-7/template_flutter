import 'dart:io';

import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/models/additional_cost.dart';
import 'package:flutter_app/models/asset.dart';
import 'package:flutter_app/utils/common.dart';

class AssetUtil {
  /// 获取资产的使用结束时间
  /// - 如果 stopUsingAt 不为空，返回 stopUsingAt
  /// - 如果 stopUsingAt 为空，返回当前时间
  static DateTime getEndUsingDate(Asset asset) {
    return asset.stopUsingAt ?? DateTime.now();
  }

  /// 计算资产的使用天数
  /// - 从购买日期到使用结束时间的天数
  /// - 最小返回 1 天
  static int calculateUsedDays(Asset asset) {
    final endDate = getEndUsingDate(asset);
    int days = endDate.difference(asset.purchaseDate).inDays;
    return days <= 0 ? 1 : days;
  }

  /// 计算截止到指定日期的有效价格（只包含该日期之前或当天的附加费用）
  static double calculateEffectivePriceAtDate(Asset asset, DateTime targetDate) {
    double effectivePrice = asset.price * (asset.quantity ?? 1);

    if (asset.additionalCosts != null && asset.additionalCosts!.isNotEmpty) {
      for (final cost in asset.additionalCosts!) {
        // 只计入目标日期当天或之前的附加费用
        if (cost.participationStatistics && !cost.date.isAfter(targetDate)) {
          if (cost.type == AdditionalCostType.expense) {
            effectivePrice += cost.amount;
          } else {
            effectivePrice -= cost.amount;
          }
        }
      }
    }

    return effectivePrice;
  }

  // 删除资产相关的图片文件
  static void deleteAssetImages(Asset asset) {
    final imagesDocuments = CommonUtil.getImagesDocuments();

    // 删除主图片
    if (asset.imageName?.isNotEmpty == true) {
      final imageFile = File(imagesDocuments + asset.imageName!);
      if (imageFile.existsSync()) {
        try {
          imageFile.deleteSync();
          log.d('删除主图片: ${asset.imageName}');
        } catch (e) {
          log.e('删除主图片失败: $e');
        }
      }
    }

    // 删除备注图片
    if (asset.imageRemarks?.isNotEmpty == true) {
      for (String imageName in asset.imageRemarks!) {
        final imageFile = File(imagesDocuments + imageName);
        if (imageFile.existsSync()) {
          try {
            imageFile.deleteSync();
            log.d('删除备注图片: $imageName');
          } catch (e) {
            log.e('删除备注图片失败: $e');
          }
        }
      }
    }
  }
}
