import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/feature/profile/data/model/profile_model.dart';
import 'package:task/feature/profile/data/service/profile_service.dart';
import 'package:task/feature/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo{

  final ProfileService profileService;

  ProfileRepoImpl(this.profileService);

  @override
  Future<Either<Failures, ProfileModel>> getDetails() async {
    return await profileService.getDetails();
  }
}