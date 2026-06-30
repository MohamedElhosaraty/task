part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}

class LoginError extends AuthState {
  final String message;

  LoginError({required this.message});
}
