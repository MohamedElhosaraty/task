import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_string.dart';

class CustomHaveAccount extends StatelessWidget {
  const CustomHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.pushReplacementNamed(Routes.loginView);
        },
        child: RichText(
          text: TextSpan(
            style: AppTextStyles.font13Medium(
              context,
            ).copyWith(color: AppColors.textSecondary),
            children: [
              TextSpan(
                text: '${tr(context, AppStrings.haveAccount)} ',
              ),
              TextSpan(
                text: tr(context, AppStrings.login),
                style: AppTextStyles.font13Medium(
                  context,
                ).copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
