class CommonResponse {
  final dynamic data;
  final int statusCode;
  final String message;

  CommonResponse({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      data: json['data'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
