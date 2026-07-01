import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/feature/profile/data/model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failures, ProfileModel>> getDetails();
}
