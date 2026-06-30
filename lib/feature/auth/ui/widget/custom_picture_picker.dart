import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/feature/auth/ui/widget/custom_border_painter.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_string.dart';

class CustomPicturePicker extends StatelessWidget {

  final File? image;
  final VoidCallback onTap;

  const CustomPicturePicker({super.key,required  this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: CustomPaint(
        painter: CustomBorderPainter(
          color: AppColors.primary.withOpacity(0.5),
          radius: 14,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            borderRadius: BorderRadius.circular(14),
          ),
          child: image != null
              ? Image.file(
                image!,
                fit: BoxFit.cover,
              )
              : Column(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
              10.verticalSpace,
              Text(
                tr(context, AppStrings.allowedFiles),
                style: AppTextStyles.font13Medium(context).copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              2.horizontalSpace,
              Text(
                tr(context, AppStrings.maxSize),
                style: TextStyle(fontSize: 11.sp, color: AppColors.hint),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
