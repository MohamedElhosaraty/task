import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/widgets/custom_gradient_button.dart';
import '../../../../generated/app_string.dart';

class CustomBottonSaveChange extends StatelessWidget {
  const CustomBottonSaveChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 58.0),
      child: CustomGradientButton(
        label: tr(context, AppStrings.saveChange),
        onPressed: () {
        },
      ),
    );
    //   BlocConsumer<AuthCubit, AuthState>(
    //   listener: (context, state) {
    //     if (state is RegisterSuccess) {
    //       ToastHelper().showSuccessToast(
    //         context,
    //         state.registerModel.message,
    //       );
    //       context.pushReplacementNamed(
    //         Routes.otpView,
    //         arguments: _emailController.text,
    //       );
    //     }
    //     if (state is RegisterError) {
    //       ToastHelper().showErrorToast(context, state.message);
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is RegisterLoading) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     return CustomGradientButton(
    //       label: tr(context, AppStrings.createNewAccount),
    //       onPressed: () {
    //         context.read<AuthCubit>().register(
    //           email: _emailController.text,
    //           username: _usernameController.text,
    //           password: _passwordController.text,
    //           passwordConfirmation: _confirmPasswordController.text,
    //           image: _profileImage,
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
