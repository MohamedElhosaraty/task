import 'package:get_it/get_it.dart';
import 'package:task/feature/home/data/service/home_service.dart';
import 'package:task/feature/home/domain/repo/home_repo.dart';
import 'package:task/feature/profile/data/repo/profile_repo_impl.dart';
import 'package:task/feature/profile/ui/cubit/profile_cubit.dart';

import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/data/service/auth_service.dart';
import '../../feature/auth/domain/repo/auth_repo.dart';
import '../../feature/auth/ui/cubit/auth_cubit.dart';
import '../../feature/home/data/repo/home_repo_impl.dart';
import '../../feature/home/ui/cubit/home_cubit.dart';
import '../../feature/profile/data/service/profile_service.dart';
import '../../feature/profile/domain/repo/profile_repo.dart';
import '../api/api_manager.dart';
import '../api/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerLazySingleton<ApiManager>(
    () => ApiManager(dio: DioFactory.getDio()),
  );

  // 📦 Data Sources
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<ApiManager>()),
  );

  getIt.registerLazySingleton<HomeService>(
    () => HomeService(getIt<ApiManager>()),
  );

  getIt.registerLazySingleton<ProfileService>(
    () => ProfileService(getIt<ApiManager>()),
  );

  // 📚 Repositories

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthService>()),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt<HomeService>()),
  );

  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(getIt<ProfileService>()),
  );

  // 🧠 Cubits
   getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
   getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
   getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<ProfileRepo>()));
}
