import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/feature/profile/data/model/profile_model.dart';
import 'package:task/feature/profile/data/model/update_profile_mode.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/api_constants.dart';

class ProfileService {
  final ApiManager apiManager;

  ProfileService(this.apiManager);

  Future<Either<Failures, ProfileModel>> getDetails() async {
    try {
      final response = await apiManager.get(endPoint: ApiConstants.profile);
      final profileModel = ProfileModel.fromJson(response.data);
      return Right(profileModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  Future<Either<Failures, UpdateProfileModel>> updateProfile({
    required String username,
    required String email,
    required String oldPassword,
    required String password,
    required String confirmPassword,
    File? image,
    required String method,
  }) async {
    try {
      final fileName = image!.path.split('/').last;
      final formData = FormData.fromMap({
        'username': username,
        'email': email,
        'password': oldPassword,
        'new_password': password,
        'new_password_confirmation': confirmPassword,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
        '_method': method,
      });
      final response = await apiManager.post(
        endPoint: ApiConstants.updateProfile,
        data: formData,
      );
      final updateProfileModel = UpdateProfileModel.fromJson(response.data);
      return Right(updateProfileModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}
