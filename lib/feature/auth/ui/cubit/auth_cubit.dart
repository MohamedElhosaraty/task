import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../data/model/login_model.dart';
import '../../data/model/register_model.dart';
import '../../domain/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final result = await authRepo.login(email, password);

    result.fold(
      (failure) {
        emit(LoginError(message: failure.error));
      },
      (loginModel) async {
        await SharedPrefHelper.setSecuredString('token', loginModel.data.token);
        emit(LoginSuccess(loginModel: loginModel));
      },
    );
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
    File? image,
  }) async {
    emit(RegisterLoading());

    final result = await authRepo.register(
      email: email,
      username: username,
      password: password,
      passwordConfirmation: passwordConfirmation,
      image: image,
    );

    result.fold(
          (failure) => emit(RegisterError(message: failure.error)),
          (signUpModel) => emit(RegisterSuccess(registerModel: signUpModel)),
    );
  }

  Future<void> verify({
    required String email,
    required String code,
  }) async {
    emit(VerifyLoading());

    final result = await authRepo.verify(
      email: email,
      code: code,
    );

    result.fold(
          (failure) => emit(VerifyError()),
          (signUpModel) => emit(VerifySuccess()),
    );
  }
}
