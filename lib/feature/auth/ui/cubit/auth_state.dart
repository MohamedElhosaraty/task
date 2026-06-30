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

// ------------ Register ------------ //

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final RegisterModel registerModel;

  RegisterSuccess({required this.registerModel});
}

class RegisterError extends AuthState {
  final String message;

  RegisterError({required this.message});
}

class VerifyLoading extends AuthState {}

class VerifySuccess extends AuthState {}

class VerifyError extends AuthState {}
