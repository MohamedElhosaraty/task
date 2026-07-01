import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/feature/profile/data/model/profile_model.dart';
import 'package:task/feature/profile/data/model/update_profile_mode.dart';
import 'package:task/feature/profile/data/service/profile_service.dart';
import 'package:task/feature/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo{

  final ProfileService profileService;

  ProfileRepoImpl(this.profileService);

  @override
  Future<Either<Failures, ProfileModel>> getDetails() async {
    return await profileService.getDetails();
  }

  @override
  Future<Either<Failures, UpdateProfileModel>> updateProfile({
    required String username,
    required String email,
    required String oldPassword,
    required String password,
    required String confirmPassword,
    File? image,
    required String method,
  }) async {
    return await profileService.updateProfile(username: username, email: email, oldPassword: oldPassword, password: password, confirmPassword: confirmPassword, image: image, method: method);
  }
}