// import 'dart:async';
//
// import 'package:drift/drift.dart';
// import 'package:flutter_app/managers/logger.dart';
//
// class DriftLogInterceptor extends QueryInterceptor {
//   Future<T> _run<T>(String description, FutureOr<T> Function() operation) async {
//     final stopwatch = Stopwatch()..start();
//
//     try {
//       final result = await operation();
//       log.d('$description\n✅ 执行成功，耗时: ${stopwatch.elapsedMilliseconds} 毫秒');
//       return result;
//     } on Object catch (e, s) {
//       log.e('$description\n❌ 执行失败，耗时: ${stopwatch.elapsedMilliseconds} 毫秒，错误: $e $s');
//       rethrow;
//     }
//   }
//
//   @override
//   TransactionExecutor beginTransaction(QueryExecutor parent) {
//     log.d('开始事务');
//     return super.beginTransaction(parent);
//   }
//
//   @override
//   Future<void> commitTransaction(TransactionExecutor inner) {
//     return _run('提交事务', () => inner.send());
//   }
//
//   @override
//   Future<void> rollbackTransaction(TransactionExecutor inner) {
//     return _run('回滚事务', () => inner.rollback());
//   }
//
//   @override
//   Future<void> runBatched(QueryExecutor executor, BatchedStatements statements) {
//     return _run('批量执行: $statements', () => executor.runBatched(statements));
//   }
//
//   @override
//   Future<int> runInsert(QueryExecutor executor, String statement, List<Object?> args) {
//     return _run('插入: $statement 参数: $args', () => executor.runInsert(statement, args));
//   }
//
//   @override
//   Future<int> runUpdate(QueryExecutor executor, String statement, List<Object?> args) {
//     return _run('更新: $statement 参数: $args', () => executor.runUpdate(statement, args));
//   }
//
//   @override
//   Future<int> runDelete(QueryExecutor executor, String statement, List<Object?> args) {
//     return _run('删除: $statement 参数: $args', () => executor.runDelete(statement, args));
//   }
//
//   @override
//   Future<void> runCustom(QueryExecutor executor, String statement, List<Object?> args) {
//     return _run('执行自定义 SQL: $statement 参数: $args', () => executor.runCustom(statement, args));
//   }
//
//   @override
//   Future<List<Map<String, Object?>>> runSelect(QueryExecutor executor, String statement, List<Object?> args) {
//     return _run('查询: $statement 参数: $args', () => executor.runSelect(statement, args));
//   }
// }
