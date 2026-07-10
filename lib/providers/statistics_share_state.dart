import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistics_share_state.g.dart';

@riverpod
class StatisticsShareState extends _$StatisticsShareState {
  @override
  void Function()? build() {
    return null;
  }

  void setShareCallback(void Function()? callback) {
    state = callback;
  }

  void triggerShare() {
    state?.call();
  }
}
