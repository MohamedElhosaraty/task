import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/helpers/toast_helper.dart';
import 'package:task/feature/profile/ui/cubit/profile_cubit.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/widgets/custom_gradient_button.dart';
import '../../../../generated/app_string.dart';

class CustomBottonSaveChange extends StatelessWidget {
  const CustomBottonSaveChange({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.oldPasswordController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.image,
  });

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController oldPasswordController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          ToastHelper().showSuccessToast(
            context,
            state.updateProfileModel.message,
          );
        }
        if (state is UpdateProfileError) {
          ToastHelper().showErrorToast(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is UpdateProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58.0),
          child: CustomGradientButton(
            label: tr(context, AppStrings.createNewAccount),
            onPressed: () {
              context.read<ProfileCubit>().updateProfile(
                username: usernameController.text,
                email: emailController.text,
                oldPassword: oldPasswordController.text,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
                image: image,
                method: 'put',
              );
            },
          ),
        );
      },
    );
  }
}
