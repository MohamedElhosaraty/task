import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/feature/home/data/model/home_model.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/api_constants.dart';

class HomeService {

  final ApiManager apiManager;

  HomeService(this.apiManager);

  Future<Either<Failures, HomeModel>> getHome() async {
    try {
      final response = await apiManager.get(endPoint: ApiConstants.home);
      final homeModel = HomeModel.fromJson(response.data);
      return Right(homeModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}