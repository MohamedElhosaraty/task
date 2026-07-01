class ProfileModel {
  final String? message;
  final UserModel? data;
  final String status;

  ProfileModel({
    this.message,
    this.data,
    required this.status,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      message: json['message'],
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.toJson(),
      'status': status,
    };
  }
}

class UserModel {
  final int id;
  final String username;
  final String email;
  final String? image;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'image': image,
    };
  }
}