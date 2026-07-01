

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/home/domain/repo/home_repo.dart';

import '../../data/model/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;

  Future<void> getHome() async {
    emit(HomeLoading());
    final result = await homeRepo.getHome();
    result.fold(
      (failure) => emit(HomeError(message: failure.error)),
      (homeModel) => emit(HomeSuccess(homeModel: homeModel)),
    );
  }
}
