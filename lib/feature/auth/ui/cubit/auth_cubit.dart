import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../data/model/login_model.dart';
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
}
