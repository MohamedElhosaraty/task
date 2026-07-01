import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/helpers/shared_pref_helper.dart';
import 'package:task/core/helpers/shared_prefs_keys.dart';
import 'package:task/core/helpers/toast_helper.dart';
import 'package:task/core/localization/localization_methods.dart';
import 'package:task/core/widgets/custom_picture_picker.dart';
import 'package:task/core/widgets/field_label.dart';
import 'package:task/core/widgets/rounded_text_field.dart';
import 'package:task/feature/profile/ui/cubit/profile_cubit.dart';
import 'package:task/feature/profile/ui/widget/custom_botton_save_change.dart';
import 'package:task/generated/app_string.dart';

import '../../../../core/theming/app_colors.dart';

class CustomProfileData extends StatefulWidget {
  const CustomProfileData({super.key});

  @override
  State<CustomProfileData> createState() => _CustomProfileDataState();
}

class _CustomProfileDataState extends State<CustomProfileData> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _profileImage;
  bool _oldObscurePassword = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController.text = SharedPrefHelper.getString(
      SharedPrefsKeys.username,
    );
    _emailController.text = SharedPrefHelper.getString(SharedPrefsKeys.email);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
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
    return Form(
      key: _formKey,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            _usernameController.text = state.updateProfileModel.data.username;
            _emailController.text = state.updateProfileModel.data.email;
            ToastHelper().showSuccessToast(
              context,
              state.updateProfileModel.message,
            );
            SharedPrefHelper.setData(
              SharedPrefsKeys.username,
              state.updateProfileModel.data.username,
            );
            SharedPrefHelper.setData(
              SharedPrefsKeys.email,
              state.updateProfileModel.data.email,
            );
          }
          if (state is UpdateProfileError) {
            ToastHelper().showErrorToast(context, state.message);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldLabel(text: tr(context, AppStrings.username)),
                  RoundedTextField(
                    controller: _usernameController,
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
                  FieldLabel(text: tr(context, AppStrings.profilePicture)),
                  8.verticalSpace,
                  CustomPicturePicker(image: _profileImage, onTap: _pickImage),
                  12.verticalSpace,
                  FieldLabel(text: tr(context, AppStrings.oldPassword)),
                  8.verticalSpace,
                  RoundedTextField(
                    controller: _oldPasswordController,
                    hint: '.......',
                    obscureText: _oldObscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _oldObscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(
                          () => _oldObscurePassword = !_oldObscurePassword,
                        );
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (value.length < 6) {
                        return tr(context, AppStrings.passwordLength);
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
                        return null;
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
                      if (_passwordController.text.isEmpty) return null;
                      if (value != _passwordController.text) {
                        return tr(context, AppStrings.passwordsDoNotMatch);
                      }
                      return null;
                    },
                  ),
                  30.verticalSpace,
                  CustomBottonSaveChange(
                    usernameController: _usernameController,
                    emailController: _emailController,
                    oldPasswordController: _oldPasswordController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    image: _profileImage,
                  ),
                  24.verticalSpace,
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
