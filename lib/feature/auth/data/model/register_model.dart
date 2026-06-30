class RegisterModel {
  final String message;
  final SignUpData data;
  final String status;

  RegisterModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['message'] ?? '',
      data: SignUpData.fromJson(json['data'] ?? {}),
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

class SignUpData {
  final String email;
  final String image;
  final String username;
  final int otp;

  SignUpData({
    required this.email,
    required this.image,
    required this.username,
    required this.otp,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      username: json['username'] ?? '',
      otp: json['otp'] is int
          ? json['otp']
          : int.tryParse(json['otp'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'username': username,
      'otp': otp,
    };
  }
}