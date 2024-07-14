class LoginResponse {
  final String jwt;
  final int statusCode;
  final String message;

  LoginResponse({
    required this.jwt,
    required this.statusCode,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwt: json['data']['jwt'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
