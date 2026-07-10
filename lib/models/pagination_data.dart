import 'package:easy_refresh/easy_refresh.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationData<T> {
  // 以下都是本地数据
  @JsonKey(includeFromJson: false, includeToJson: false)
  final EasyRefreshController refreshController;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int offset;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final int limit;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool noMore;

  // 以下都是服务端响应数据
  final List<T>? results;

  // 总记录数
  final int? count;

  // 下一页地址：http://127.0.0.1:8000/data/?is_active=true&limit=20&offset=20"
  final String? next;

  // 上一页地址：http://127.0.0.1:8000/data/?is_active=true&limit=20&offset=0"
  final String? previous;

  PaginationData({
    EasyRefreshController? refreshController,
    this.offset = 0,
    this.limit = 20,
    this.noMore = false,
    this.count,
    this.results,
    this.next,
    this.previous,
  }) : refreshController = refreshController ??
            EasyRefreshController(
              controlFinishRefresh: true,
              controlFinishLoad: true,
            );

  // 提供默认构造方法
  factory PaginationData.defaultController({
    int offset = 0,
    int limit = 20,
    bool noMore = false,
    int count = 0,
    List<T>? results,
  }) {
    return PaginationData<T>(
      refreshController: EasyRefreshController(
        controlFinishRefresh: true,
        controlFinishLoad: true,
      ),
      noMore: noMore,
      offset: offset,
      limit: limit,
      count: count,
      results: results ?? <T>[],
    );
  }

  PaginationData<T> copyWith({
    required int? count,
    required List<T>? results,
    required String? next,
    required String? previous,
    bool? noMore,
    EasyRefreshController? refreshController,
    int? offset,
    int? limit,
  }) {
    return PaginationData<T>(
      refreshController: refreshController ?? this.refreshController,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      noMore: noMore ?? this.noMore,
      count: count,
      results: results,
      next: next,
      previous: previous,
    );
  }

  factory PaginationData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$PaginationDataToJson(this, toJsonT);
}
