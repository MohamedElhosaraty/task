import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/login_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, LoginModel>> login(String email, String password);
}