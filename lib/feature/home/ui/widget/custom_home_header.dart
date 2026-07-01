import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helpers/shared_pref_helper.dart';
import 'package:task/core/helpers/shared_prefs_keys.dart';
import 'package:task/core/localization/localization_methods.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_string.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${tr(context, AppStrings.hello)} ${SharedPrefHelper.getString(SharedPrefsKeys.username)} !',
              textAlign: TextAlign.start,
              style: AppTextStyles.font16Bold(
                context,
              ).copyWith(color: AppColors.white),
            ),
          ),
          12.horizontalSpace,
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.white,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
