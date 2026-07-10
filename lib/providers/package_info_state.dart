import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_state.g.dart';

@Riverpod(keepAlive: true)
class PackageInfoState extends _$PackageInfoState {
  @override
  Future<PackageInfo> build() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
