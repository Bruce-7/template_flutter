// import 'dart:convert';
// import 'dart:io';
//
// import 'package:archive/archive.dart';
// import 'package:drift/drift.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_app/constants/keys.dart';
// import 'package:flutter_app/database/database.dart';
// import 'package:flutter_app/extension/db_prefs_extension.dart';
// import 'package:flutter_app/managers/db.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/utils/date_format.dart';
// import 'package:path_provider/path_provider.dart';
//
// /// 备份工具类
// class BackupUtil {
//   /// 创建备份ZIP文件
//   ///
//   /// 将Documents目录下的所有文件和分类、标签数据压缩成ZIP
//   /// 返回ZIP文件路径
//   static Future<String> createBackupZip() async {
//     final documentsDir = dbManager.documentsDir;
//     final tempDir = await getTemporaryDirectory();
//     final timestamp = DateFormatUtil.yyyyMMddHHmmss();
//     final zipFilePath = '${tempDir.path}/app_backup_$timestamp.zip';
//
//     // 创建Archive对象
//     final archive = Archive();
//
//     // 遍历Documents目录下的所有文件并添加到archive
//     final files = documentsDir.listSync(recursive: true);
//     for (final file in files) {
//       if (file is File) {
//         final relativePath = file.path.replaceFirst('${documentsDir.path}/', '');
//         final fileBytes = await file.readAsBytes();
//         final archiveFile = ArchiveFile(relativePath, fileBytes.length, fileBytes);
//         archive.addFile(archiveFile);
//       }
//     }
//
//     // 添加分类和标签数据到备份（使用 JSON 格式）
//     try {
//       final categoriesName = dbManager.categoriesName();
//       final tagsName = dbManager.tagsName();
//
//       final preferencesData = {
//         kCategoriesName: categoriesName,
//         kTagsName: tagsName,
//       };
//
//       final jsonString = jsonEncode(preferencesData);
//       final jsonBytes = utf8.encode(jsonString);
//       final archiveFile = ArchiveFile('preferences.json', jsonBytes.length, jsonBytes);
//       archive.addFile(archiveFile);
//
//       log.d('已添加分类和标签数据到备份');
//       log.d('分类: ${categoriesName.length} 个，标签: ${tagsName.length} 个');
//     } catch (e) {
//       log.e('备份分类和标签数据失败: $e');
//     }
//
//     // 编码为zip
//     final zipData = ZipEncoder().encode(archive);
//
//     // 写入zip文件
//     final zipFile = File(zipFilePath);
//     await zipFile.writeAsBytes(zipData);
//
//     return zipFilePath;
//   }
//
//   /// 解压ZIP文件到临时目录
//   ///
//   /// 返回解压目录路径
//   static Future<String> extractZipToTemp(String zipFilePath) async {
//     final tempDir = await getTemporaryDirectory();
//     final extractPath = '${tempDir.path}/app_extract_${DateFormatUtil.yyyyMMddHHmmss()}';
//
//     // 解压zip文件到临时目录
//     final zipFile = File(zipFilePath);
//     final bytes = await zipFile.readAsBytes();
//     final archive = ZipDecoder().decodeBytes(bytes);
//
//     for (final file in archive) {
//       final filename = '$extractPath/${file.name}';
//       if (file.isFile) {
//         final outFile = File(filename);
//         await outFile.create(recursive: true);
//         await outFile.writeAsBytes(file.content as List<int>);
//       } else {
//         final dir = Directory(filename);
//         await dir.create(recursive: true);
//       }
//     }
//
//     return extractPath;
//   }
//
//   /// 验证备份文件是否有效
//   ///
//   /// 检查是否包含数据库文件
//   static Future<bool> validateBackup(String extractPath) async {
//     final dbFile = File('$extractPath/app.db');
//     return await dbFile.exists();
//   }
//
//   /// 导入数据库数据
//   ///
//   /// 使用ATTACH DATABASE方式从导入的数据库复制数据到当前数据库
//   /// 返回导入的总数据条数（资产 + 礼记）
//   static Future<int> importDatabaseData(String extractPath) async {
//     final dbFile = File('$extractPath/app.db');
//     final currentDb = dbManager.database;
//
//     // 执行ATTACH和INSERT操作，临时附加外部数据库
//     await currentDb.customStatement(
//       'ATTACH DATABASE ? AS import_db',
//       [dbFile.path],
//     );
//
//     try {
//       int totalCount = 0;
//
//       // 导入资产表
//       final assetsCount = await _importTable(
//         currentDb,
//         tableName: currentDb.assetsTable.aliasedName,
//         updateTable: currentDb.assetsTable,
//       );
//       totalCount += assetsCount;
//       log.d('成功导入 $assetsCount 条资产数据');
//
//       // 导入礼记表（兼容旧备份无此表的情况）
//       final giftRecordsCount = await _importTable(
//         currentDb,
//         tableName: currentDb.giftRecordsTable.aliasedName,
//         updateTable: currentDb.giftRecordsTable,
//       );
//       totalCount += giftRecordsCount;
//       log.d('成功导入 $giftRecordsCount 条礼记数据');
//
//       log.d('总共导入 $totalCount 条数据');
//       return totalCount;
//     } finally {
//       // 分离导入的数据库
//       await currentDb.customStatement('DETACH DATABASE import_db');
//     }
//   }
//
//   /// 从导入数据库导入单张表的数据
//   ///
//   /// 自动检测导入数据库是否包含该表，兼容旧版本备份
//   /// 返回导入的数据条数
//   static Future<int> _importTable(
//     AppDatabase currentDb, {
//     required String tableName,
//     required TableInfo updateTable,
//   }) async {
//     try {
//       // 检查导入数据库是否存在该表
//       final tableCheck = await currentDb.customSelect(
//         "SELECT name FROM import_db.sqlite_master WHERE type='table' AND name=?",
//         variables: [Variable.withString(tableName)],
//       ).get();
//
//       if (tableCheck.isEmpty) {
//         log.d('导入数据库中不存在表: $tableName，跳过');
//         return 0;
//       }
//
//       // 获取导入数据库的表结构
//       final importColumns = await currentDb.customSelect('PRAGMA import_db.table_info($tableName)').get();
//
//       // 获取当前数据库的表结构
//       final currentColumns = await currentDb.customSelect('PRAGMA table_info($tableName)').get();
//
//       // 提取字段名称
//       final importColumnNames = importColumns.map((row) => row.data['name'] as String).toSet();
//       final currentColumnNames = currentColumns.map((row) => row.data['name'] as String).toSet();
//
//       // 找出两个数据库都存在的字段
//       final commonColumns = importColumnNames.intersection(currentColumnNames).toList();
//       if (commonColumns.isEmpty) return 0;
//
//       // 获取导入数据库的数据数量
//       final importCountResult = await currentDb.customSelect('SELECT COUNT(*) as count FROM import_db.$tableName').getSingle();
//       final importCount = importCountResult.data['count'] as int;
//       if (importCount == 0) return 0;
//
//       // 构建动态SQL语句
//       final columnsList = commonColumns.join(', ');
//       final insertSql = '''
//         INSERT OR REPLACE INTO $tableName ($columnsList)
//         SELECT $columnsList FROM import_db.$tableName
//       ''';
//
//       log.d('[$tableName] 导入字段: $columnsList');
//
//       // 使用INSERT OR REPLACE从导入的数据库复制数据到当前数据库
//       await currentDb.customInsert(
//         insertSql,
//         updates: {updateTable},
//       );
//
//       return importCount;
//     } catch (e) {
//       log.e('导入表 $tableName 失败: $e');
//       return 0;
//     }
//   }
//
//   /// 复制图片文件到Documents目录
//   ///
//   /// 从解压目录复制图片文件到Documents目录（跳过已存在的文件）
//   static Future<void> copyImagesToDocuments(String extractPath) async {
//     final documentsDir = dbManager.documentsDir;
//     final extractDir = Directory(extractPath);
//
//     // 过滤不需要的文件
//     final dbFile = File('$extractPath/app.db');
//     final plistFile = File('$extractPath/preferences.json');
//
//     // 只复制图片文件到Documents目录
//     final extractedFiles = extractDir.listSync(recursive: true);
//     for (final file in extractedFiles) {
//       if (file is File && file.path != dbFile.path && file.path != plistFile.path) {
//         final relativePath = file.path.replaceFirst('$extractPath/', '');
//         final targetFile = File('${documentsDir.path}/$relativePath');
//
//         // 如果目标文件不存在，则复制
//         if (!await targetFile.exists()) {
//           await targetFile.create(recursive: true);
//           await file.copy(targetFile.path);
//         }
//       }
//     }
//   }
//
//   /// 恢复分类和标签数据
//   ///
//   /// 从解压目录的 JSON 文件恢复分类和标签数据，合并到当前数据
//   static Future<void> restorePlistFile(String extractPath) async {
//     try {
//       final jsonFile = File('$extractPath/preferences.json');
//       if (!await jsonFile.exists()) {
//         log.w('备份中不包含preferences.json文件');
//         return;
//       }
//
//       // 获取当前的分类和标签
//       final currentCategories = dbManager.categoriesName();
//       final currentTags = dbManager.tagsName();
//
//       // 读取备份的 JSON 文件
//       final jsonString = await jsonFile.readAsString();
//       final Map<String, dynamic> preferencesMap = jsonDecode(jsonString);
//
//       // 通过 key 读取备份数据的分类和标签
//       List<String> backupCategories = [];
//       if (preferencesMap.containsKey(kCategoriesName)) {
//         backupCategories = (preferencesMap[kCategoriesName] as List<dynamic>?)?.cast<String>() ?? [];
//       }
//
//       List<String> backupTags = [];
//       if (preferencesMap.containsKey(kTagsName)) {
//         backupTags = (preferencesMap[kTagsName] as List<dynamic>?)?.cast<String>() ?? [];
//       }
//
//       log.d('备份数据 - 分类: ${backupCategories.length} 个，标签: ${backupTags.length} 个');
//
//       // 合并数据：去重，添加新增的分类和标签
//       final mergedCategories = <String>{...currentCategories, ...backupCategories}.toList();
//       final mergedTags = <String>{...currentTags, ...backupTags}.toList();
//
//       // 更新数据
//       dbManager.setCategoriesName(mergedCategories);
//       dbManager.setTagsName(mergedTags);
//
//       final addedCategories = mergedCategories.length - currentCategories.length;
//       final addedTags = mergedTags.length - currentTags.length;
//       log.d('已恢复并合并分类和标签数据');
//       log.d('分类: 当前 ${currentCategories.length} + 新增 $addedCategories = ${mergedCategories.length}');
//       log.d('标签: 当前 ${currentTags.length} + 新增 $addedTags = ${mergedTags.length}');
//     } catch (e) {
//       log.e('恢复分类和标签数据失败: $e');
//     }
//   }
//
//   /// 清理临时目录
//   static Future<void> cleanupTempDirectory(String directoryPath) async {
//     final dir = Directory(directoryPath);
//     if (await dir.exists()) {
//       await dir.delete(recursive: true);
//     }
//   }
//
//   /// 完整的导入流程
//   ///
//   /// 从ZIP文件导入数据、图片和分类、标签数据
//   /// 返回导入的数据条数
//   static Future<int> importFromZip(String zipFilePath) async {
//     String? extractPath;
//
//     try {
//       // 1. 解压ZIP文件
//       extractPath = await extractZipToTemp(zipFilePath);
//
//       // 2. 验证备份文件
//       final isValid = await validateBackup(extractPath);
//       if (!isValid) {
//         throw Exception('导入的文件格式不正确'.tr());
//       }
//
//       // 3. 导入数据库数据
//       final count = await importDatabaseData(extractPath);
//       if (count == 0) {
//         throw Exception('导入的数据为空'.tr());
//       }
//
//       // 4. 复制图片文件
//       await copyImagesToDocuments(extractPath);
//
//       // 5. 恢复 plist 文件（分类和标签数据）
//       await restorePlistFile(extractPath);
//
//       return count;
//     } finally {
//       // 6. 清理临时目录
//       if (extractPath != null) {
//         await cleanupTempDirectory(extractPath);
//       }
//     }
//   }
// }
