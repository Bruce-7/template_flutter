import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

enum ApiResponseCode {
  // 1xx Informational
  http100Continue(100),
  http101SwitchingProtocols(101),
  http102Processing(102),
  http103EarlyHints(103),

  // 2xx Success
  http200Ok(200),
  http201Created(201),
  http202Accepted(202),
  http203NonAuthoritativeInformation(203),
  http204NoContent(204),
  http205ResetContent(205),
  http206PartialContent(206),
  http207MultiStatus(207),
  http208AlreadyReported(208),
  http226ImUsed(226),

  // 3xx Redirection
  http300MultipleChoices(300),
  http301MovedPermanently(301),
  http302Found(302),
  http303SeeOther(303),
  http304NotModified(304),
  http305UseProxy(305),
  http306Reserved(306),
  http307TemporaryRedirect(307),
  http308PermanentRedirect(308),

  // 4xx Client Error
  http400BadRequest(400),
  http401Unauthorized(401),
  http402PaymentRequired(402),
  http403Forbidden(403),
  http404NotFound(404),
  http405MethodNotAllowed(405),
  http406NotAcceptable(406),
  http407ProxyAuthenticationRequired(407),
  http408RequestTimeout(408),
  http409Conflict(409),
  http410Gone(410),
  http411LengthRequired(411),
  http412PreconditionFailed(412),
  http413RequestEntityTooLarge(413),
  http414RequestUriTooLong(414),
  http415UnsupportedMediaType(415),
  http416RequestedRangeNotSatisfiable(416),
  http417ExpectationFailed(417),
  http418ImATeapot(418),
  http421MisdirectedRequest(421),
  http422UnprocessableEntity(422),
  http423Locked(423),
  http424FailedDependency(424),
  http425TooEarly(425),
  http426UpgradeRequired(426),
  http428PreconditionRequired(428),
  http429TooManyRequests(429),
  http431RequestHeaderFieldsTooLarge(431),
  http451UnavailableForLegalReasons(451),

  // 5xx Server Error
  http500InternalServerError(500),
  http501NotImplemented(501),
  http502BadGateway(502),
  http503ServiceUnavailable(503),
  http504GatewayTimeout(504),
  http505HttpVersionNotSupported(505),
  http506VariantAlsoNegotiates(506),
  http507InsufficientStorage(507),
  http508LoopDetected(508),
  http509BandwidthLimitExceeded(509),
  http510NotExtended(510),
  http511NetworkAuthenticationRequired(511),

  // Custom Error Codes
  badCertificate(700),
  connectionError(800),
  cancel(900),
  unknown(9999);

  final int? value;

  const ApiResponseCode(this.value);

  static ApiResponseCode fromValue(int? value) {
    return ApiResponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ApiResponseCode.unknown,
    );
  }

  int toJson() => value ?? 9999;

  bool get isInformational => value != null && value! >= 100 && value! <= 199;

  bool get isSuccess => value != null && value! >= 200 && value! <= 299;

  bool get isRedirect => value != null && value! >= 300 && value! <= 399;

  bool get isClientError => value != null && value! >= 400 && value! <= 499;

  bool get isServerError => value != null && value! >= 500 && value! <= 599;
}

/// 通用API响应模型
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  // 状态码
  @JsonKey(fromJson: _codeFromJson, toJson: _codeToJson)
  final ApiResponseCode? code;

  final String? message;

  // 响应数据
  final T? data;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  bool get isSuccess => code?.isSuccess ?? false;

  // JSON反序列化：int -> ApiResponseCode
  static ApiResponseCode _codeFromJson(int? value) => ApiResponseCode.fromValue(value);

  // JSON序列化：ApiResponseCode -> int
  static int? _codeToJson(ApiResponseCode? code) => code?.toJson();

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ApiResponseToJson(this, toJsonT);
}
