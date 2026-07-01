import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/feature/profile/data/model/profile_model.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/api_constants.dart';

class ProfileService {

  final ApiManager apiManager;

  ProfileService(this.apiManager);

  Future<Either<Failures, ProfileModel>> getDetails() async {
    try {
      final response = await apiManager.get(endPoint: ApiConstants.profile);
      final profileModel = ProfileModel.fromJson(response.data);
      return Right(profileModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}