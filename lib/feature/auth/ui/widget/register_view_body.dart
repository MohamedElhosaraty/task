import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/helpers/toast_helper.dart';
import 'package:task/feature/auth/ui/cubit/auth_cubit.dart';
import 'package:task/feature/auth/ui/widget/custom_have_account.dart';
import 'package:task/feature/auth/ui/widget/custom_picture_picker.dart';
import 'package:task/feature/auth/ui/widget/field_label.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_gradient_button.dart';
import '../../../../core/widgets/rounded_text_field.dart';
import '../../../../generated/app_string.dart';
import '../../../../generated/assets.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _profileImage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
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
              40.verticalSpace,
              Center(child: Image.asset(Assets.imageLogo)),
              40.verticalSpace,
              Text(
                tr(context, AppStrings.createNewAccount),
                style: AppTextStyles.font20Bold(
                  context,
                ).copyWith(color: AppColors.black),
              ),
              24.verticalSpace,
              FieldLabel(text: tr(context, AppStrings.profilePicture)),
              8.verticalSpace,
              CustomPicturePicker(image: _profileImage, onTap: _pickImage),
              12.verticalSpace,
              FieldLabel(text: tr(context, AppStrings.username)),
              8.verticalSpace,
              RoundedTextField(
                controller: _usernameController,
                hint: 'thar22',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr(context, AppStrings.usernameRequired);
                  }
                  if (value.trim().length < 3) {
                    return tr(context, AppStrings.usernameTooShort);
                  }
                  return null;
                },
              ),
              12.verticalSpace,
              FieldLabel(text: tr(context, AppStrings.email)),
              8.verticalSpace,
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
              12.verticalSpace,
              FieldLabel(text: tr(context, AppStrings.password)),
              8.verticalSpace,
              RoundedTextField(
                controller: _passwordController,
                hint: '.......',
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

              12.verticalSpace,

              FieldLabel(text: tr(context, AppStrings.confirmPassword)),
              8.verticalSpace,
              RoundedTextField(
                controller: _confirmPasswordController,
                hint: '.......',
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(context, AppStrings.confirmPasswordRequired);
                  }
                  if (value != _passwordController.text) {
                    return tr(context, AppStrings.passwordsDoNotMatch);
                  }
                  return null;
                },
              ),

              40.verticalSpace,

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    ToastHelper().showSuccessToast(
                      context,
                      state.registerModel.message,
                    );
                    context.pushReplacementNamed(
                      Routes.otpView,
                      arguments: _emailController.text,
                    );
                  }
                  if (state is RegisterError) {
                    ToastHelper().showErrorToast(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomGradientButton(
                    label: tr(context, AppStrings.createNewAccount),
                    onPressed: () {
                      context.read<AuthCubit>().register(
                        email: _emailController.text,
                        username: _usernameController.text,
                        password: _passwordController.text,
                        passwordConfirmation: _confirmPasswordController.text,
                        image: _profileImage,
                      );
                    },
                  );
                },
              ),

              12.verticalSpace,
              const CustomHaveAccount(),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
