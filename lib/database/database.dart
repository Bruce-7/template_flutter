// import 'dart:io';
//
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_app/database/daos/assets_dao.dart';
// import 'package:flutter_app/database/daos/gift_records_dao.dart';
// import 'package:flutter_app/database/database.steps.dart';
// import 'package:flutter_app/database/logger.dart';
// import 'package:flutter_app/database/tables/assets_table.dart';
// import 'package:flutter_app/database/tables/gift_records_table.dart';
// import 'package:flutter_app/managers/db.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/models/additional_cost.dart';
// import 'package:flutter_app/models/notification_config.dart';
// import 'package:path/path.dart' as p;
//
// part 'database.g.dart';
//
// @DriftDatabase(
//   tables: [AssetsTable, GiftRecordsTable],
//   daos: [AssetsDao, GiftRecordsDao],
// )
// class AppDatabase extends _$AppDatabase {
//   AppDatabase(super.e);
//
//   factory AppDatabase.connect() => AppDatabase(_openConnection());
//
//   @override
//   int get schemaVersion => 6;
//
//   static LazyDatabase _openConnection() {
//     return LazyDatabase(() async {
//       // 选择支持持久化，系统能同步的目录。
//       final dbPath = p.join(dbManager.documentsDir.path, 'app.db');
//       log.d('dbPath: $dbPath');
//
//       final db = NativeDatabase(
//         File(dbPath),
//         // logStatements: kDebugMode, // 可控数据库日志打印
//       );
//
//       // 以后需要统计数据库报错再放开。
//       if (kDebugMode) {
//         // 使用自定义日志拦截器
//         return db.interceptWith(DriftLogInterceptor());
//       }
//
//       return db;
//     });
//   }
//
//   @override
//   MigrationStrategy get migration {
//     return MigrationStrategy(
//       onUpgrade: _schemaUpgrade,
//     );
//   }
// }
//
// extension Migrations on GeneratedDatabase {
//   OnUpgrade get _schemaUpgrade => stepByStep(
//         from1To2: (m, schema) async {
//           log.d('🚀 开始迁移 from1To2');
//           await m.addColumn(schema.assetsTable, schema.assetsTable.participationStatistics);
//           await m.addColumn(schema.assetsTable, schema.assetsTable.tags);
//           log.d('✅ 迁移完成 from1To2');
//         },
//         from2To3: (Migrator m, Schema3 schema) async {
//           log.d('🚀 开始迁移 from2To3');
//           await m.addColumn(schema.assetsTable, schema.assetsTable.notificationConfig);
//           log.d('✅ 迁移完成 from2To3');
//         },
//         from3To4: (Migrator m, Schema4 schema) async {
//           log.d('🚀 开始迁移 from3To4');
//           await m.addColumn(schema.assetsTable, schema.assetsTable.stopUsingAt);
//           log.d('✅ 迁移完成 from3To4');
//         },
//         from4To5: (Migrator m, Schema5 schema) async {
//           log.d('🚀 开始迁移 from4To5');
//           await m.addColumn(schema.assetsTable, schema.assetsTable.quantity);
//           log.d('✅ 迁移完成 from4To5');
//         },
//         from5To6: (Migrator m, Schema6 schema) async {
//           log.d('🚀 开始迁移 from5To6');
//           await m.createTable(schema.giftRecordsTable);
//           log.d('✅ 迁移完成 from5To6');
//         },
//       );
// }
//
// // 暂时不使用ref
// // @Riverpod(keepAlive: true)
// // AppDatabase appDatabase(Ref ref) => AppDatabase();
