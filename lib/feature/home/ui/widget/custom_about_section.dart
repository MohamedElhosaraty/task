import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomAboutSection extends StatelessWidget {
  final String blocks;
  final String title;

  const CustomAboutSection({super.key, required this.blocks,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.font19Bold(
            context,
          ).copyWith(color: AppColors.black),
        ),
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            blocks,
            style: AppTextStyles.font15Medium(
              context,
            ).copyWith(color: AppColors.textSecondary, height: 1.7),
          ),
        ),
      ],
    );
  }
}
