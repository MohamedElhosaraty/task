import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_string.dart';
import '../../../../generated/assets.dart';

class CustomHeaderCard extends StatelessWidget {

  const CustomHeaderCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.55),
            AppColors.primary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            Assets.imageHomeCard,
          ),
          16.verticalSpace,
          Text(
            tr(context, AppStrings.training),
            textAlign: TextAlign.center,
            style: AppTextStyles.font16Bold(context).copyWith(
              color: AppColors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}