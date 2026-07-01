import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/feature/profile/data/model/profile_model.dart';
import 'package:task/feature/profile/data/model/update_profile_mode.dart';

abstract class ProfileRepo {
  Future<Either<Failures, ProfileModel>> getDetails();
  Future<Either<Failures, UpdateProfileModel>> updateProfile({
    required String username,
    required String email,
    required String oldPassword,
    required String password,
    required String confirmPassword,
    File? image,
    required String method,
});
}
