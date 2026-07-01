import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/feature/home/data/model/home_model.dart';
import 'package:task/feature/home/data/service/home_service.dart';
import 'package:task/feature/home/domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {

  final HomeService homeService;

  HomeRepoImpl(this.homeService);

  @override
  Future<Either<Failures, HomeModel>> getHome() async {
    return await homeService.getHome();
  }
}