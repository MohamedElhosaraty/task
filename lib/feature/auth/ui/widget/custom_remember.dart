import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_string.dart';

class CustomRemember extends StatefulWidget {
  const CustomRemember({super.key});

  @override
  State<CustomRemember> createState() => _CustomRememberState();
}

class _CustomRememberState extends State<CustomRemember> {

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          child: Text(
            tr(context, AppStrings.forgotPassword),

            style: AppTextStyles.font10Medium(context).copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              tr(context, AppStrings.remember),
              style: AppTextStyles.font13Medium(context).copyWith(
                color: AppColors.black,
              ),
            ),
            6.horizontalSpace,
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (val) {
                  setState(() => _rememberMe = val ?? false);
                },
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: const BorderSide(color: AppColors.hint),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
