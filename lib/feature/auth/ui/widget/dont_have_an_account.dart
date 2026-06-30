import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_string.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.font13Medium(context).copyWith(
            color: AppColors.textSecondary,
          ),
          children: [
            TextSpan(text: tr(context, AppStrings.dontHaveAccount)),
            TextSpan(
              text: tr(context, AppStrings.createAccount),
              style: AppTextStyles.font13Medium(context).copyWith(
                color: AppColors.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO: navigate to sign up
                },
            ),
          ],
        ),
      ),
    );
  }
}
