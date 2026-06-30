import 'package:dartz/dartz.dart';
import 'package:task/feature/auth/data/model/login_model.dart';
import 'package:task/feature/auth/data/service/login_service.dart';
import 'package:task/feature/auth/domain/repo/auth_repo.dart';

import '../../../../core/error/failures.dart';

class AuthRepoImpl implements AuthRepo {
  final LoginService loginService;

  AuthRepoImpl(this.loginService);

  @override
  Future<Either<Failures, LoginModel>> login(
      String email,
      String password,
      ) async {
    return await loginService.login(email, password);
  }
}