import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/feature/auth/data/model/login_model.dart';
import 'package:task/feature/auth/data/model/register_model.dart';
import 'package:task/feature/auth/data/service/auth_service.dart';
import 'package:task/feature/auth/domain/repo/auth_repo.dart';

import '../../../../core/error/failures.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl(this.authService);

  @override
  Future<Either<Failures, LoginModel>> login(
      String email,
      String password,
      ) async {
    return await authService.login(email, password);
  }

  Future<Either<Failures, RegisterModel>> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    File? image,
  }) async {
    return await authService.register(
      email: email,
      username: username,
      password: password,
      passwordConfirmation: passwordConfirmation,
      image: image,
    );
  }
}