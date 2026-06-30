import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/feature/auth/data/model/login_model.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';

class LoginService {
  final ApiManager apiManager;

  LoginService(this.apiManager);

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
}