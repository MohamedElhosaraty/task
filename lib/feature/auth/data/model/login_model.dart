class LoginModel {
  final String message;
  final Data data;
  final String status;

  LoginModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'] ?? '',
      data: Data.fromJson(json['data'] ?? {}),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
      'status': status,
    };
  }
}

class Data {
  final String token;
  final String username;
  final String email;

  Data({
    required this.token,
    required this.username,
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'email': email,
    };
  }
}