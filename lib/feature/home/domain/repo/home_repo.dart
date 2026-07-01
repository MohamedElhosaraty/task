import 'package:dartz/dartz.dart';
import 'package:task/feature/home/data/model/home_model.dart';

import '../../../../core/error/failures.dart';

abstract class HomeRepo {
  Future<Either<Failures, HomeModel>> getHome();
}
