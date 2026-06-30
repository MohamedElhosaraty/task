import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/feature/auth/data/model/register_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/login_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, LoginModel>> login(String email, String password);

  Future<Either<Failures, RegisterModel>> register({
  required String email,
  required String username,
  required String password,
  required String passwordConfirmation,
    File? image,
  });
  }
