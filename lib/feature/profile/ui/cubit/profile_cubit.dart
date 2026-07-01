import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/profile/domain/repo/profile_repo.dart';

import '../../data/model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  Future<void> getDetails() async {
    emit(ProfileLoading());
    final result = await profileRepo.getDetails();
    result.fold(
          (failure) => emit(ProfileError(failure.error)),
          (profileModel) => emit(ProfileSuccess(profileModel)),
    );
  }
}
