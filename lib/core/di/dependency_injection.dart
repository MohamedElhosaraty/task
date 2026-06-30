import 'package:get_it/get_it.dart';

import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/data/service/login_service.dart';
import '../../feature/auth/domain/repo/auth_repo.dart';
import '../../feature/auth/ui/cubit/auth_cubit.dart';
import '../api/api_manager.dart';
import '../api/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔧 Core
  getIt.registerLazySingleton<ApiManager>(
    () => ApiManager(dio: DioFactory.getDio()),
  );

  // 📦 Data Sources
  getIt.registerLazySingleton<LoginService>(
    () => LoginService(getIt<ApiManager>()),
  );

  // 📚 Repositories

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<LoginService>()),
  );

  // 🧠 Cubits
   getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
}
