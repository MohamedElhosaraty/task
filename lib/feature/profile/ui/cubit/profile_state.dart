part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;
  ProfileSuccess(this.profileModel);
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}


// ------------------ update profile ------------------ //


final class UpdateProfileLoading extends ProfileState{}

final class UpdateProfileSuccess extends ProfileState{
  final UpdateProfileModel updateProfileModel;
  UpdateProfileSuccess(this.updateProfileModel);
}

final class UpdateProfileError extends ProfileState{
  final String message;
  UpdateProfileError(this.message);
}
