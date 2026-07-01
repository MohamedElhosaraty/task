class UpdateProfileModel {
  final String message;
  final UserModel data;
  final String status;

  UpdateProfileModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      message: json['message'],
      data: UserModel.fromJson(json['data']),
      status: json['status'],
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

class UserModel {
  final int id;
  final String username;
  final String email;
  final String image;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
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