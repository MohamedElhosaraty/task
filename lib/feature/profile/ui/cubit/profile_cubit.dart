import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/profile/data/model/update_profile_mode.dart';
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

  Future<void> updateProfile({
    required String username,
    required String email,
    required String oldPassword,
    required String password,
    required String confirmPassword,
    File? image,
    required String method,
  }) async {
    emit(UpdateProfileLoading());
    final result = await profileRepo.updateProfile(
      username: username,
      email: email,
      oldPassword: oldPassword,
      password: password,
      confirmPassword: confirmPassword,
      image: image,
      method: method,
    );
    result.fold(
      (failure) => emit(UpdateProfileError(failure.error)),
      (updateProfileModel) => emit(UpdateProfileSuccess(updateProfileModel)),
    );
  }
}
