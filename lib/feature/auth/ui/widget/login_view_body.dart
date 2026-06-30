import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helpers/toast_helper.dart';
import 'package:task/core/localization/localization_methods.dart';
import 'package:task/core/theming/app_text_styles.dart';
import 'package:task/core/widgets/custom_gradient_button.dart';
import 'package:task/feature/auth/ui/cubit/auth_cubit.dart';
import 'package:task/feature/auth/ui/widget/custom_remember.dart';
import 'package:task/feature/auth/ui/widget/dont_have_an_account.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/custom_change_language.dart';
import '../../../../core/widgets/rounded_text_field.dart';
import '../../../../generated/app_string.dart';
import '../../../../generated/assets.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              const CustomChangeLanguage(),
              const SizedBox(height: 100),
              Center(child: Image.asset(Assets.imageLogo)),
              100.verticalSpace,
              Text(
                tr(context, AppStrings.login),
                textAlign: TextAlign.center,
                style: AppTextStyles.font20Bold(
                  context,
                ).copyWith(color: AppColors.black),
              ),
              24.verticalSpace,
              Text(
                tr(context, AppStrings.email),
                style: AppTextStyles.font10Medium(
                  context,
                ).copyWith(color: AppColors.black),
              ),
              6.verticalSpace,
              RoundedTextField(
                controller: _emailController,
                hint: 'Tharad@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr(context, AppStrings.enterEmail);
                  }
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return tr(context, AppStrings.enterEmailCorrect);
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              Text(
                tr(context, AppStrings.password),
                style: AppTextStyles.font10Medium(
                  context,
                ).copyWith(color: AppColors.black),
              ),
              6.verticalSpace,
              RoundedTextField(
                controller: _passwordController,
                hint: '••••••••',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(context, AppStrings.enterPassword);
                  }
                  if (value.length < 6) {
                    return tr(context, AppStrings.passwordLength);
                  }
                  return null;
                },
              ),
              8.verticalSpace,
              const CustomRemember(),
              40.verticalSpace,
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    ToastHelper().showSuccessToast(context, "Login Success");
                  }
                  if (state is LoginError) {
                    ToastHelper().showErrorToast(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomGradientButton(
                    label: tr(context, AppStrings.login),
                    onPressed: () {
                      context.read<AuthCubit>().login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    },
                  );
                },
              ),
              12.verticalSpace,
              const DontHaveAnAccount(),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
