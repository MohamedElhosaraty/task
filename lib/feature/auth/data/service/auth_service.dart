import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/feature/auth/data/model/login_model.dart';
import 'package:task/feature/auth/data/model/register_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';

class AuthService {
  final ApiManager apiManager;

  AuthService(this.apiManager);

  Future<Either<Failures, LoginModel>> login(
      String email,
      String password,
      ) async {
    try {
      final response = await apiManager.post(
        endPoint: ApiConstants.login,
        data: {"email": email, "password": password},
      );
      final loginModel = LoginModel.fromJson(response.data);
      return Right(loginModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  Future<Either<Failures, RegisterModel>> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    File? image,
  }) async {
    try {
      final fileName = image!.path.split('/').last;

      final formData = FormData.fromMap({
        'email': email,
        'username': username,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      final response = await apiManager.post(
        endPoint: ApiConstants.register,
        data: formData
      );

      final signUpModel = RegisterModel.fromJson(response.data);
      return Right(signUpModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}