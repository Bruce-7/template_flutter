import 'package:flutter_app/constants/currencies.dart';
import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_state.g.dart';

@riverpod
class CurrencyState extends _$CurrencyState {
  @override
  String build() {
    // 读取持久化的货币符号
    final symbol = dbManager.prefs.getString(kCurrencySymbol);
    return symbol ?? currencies.first;
  }

  String get symbol => state;

  /// 设置货币符号
  void setSymbol(String symbol) {
    if (state == symbol) return;
    state = symbol;
    _save();
  }

  /// 保存到本地
  void _save() {
    dbManager.prefs.setString(kCurrencySymbol, state);
  }
}
