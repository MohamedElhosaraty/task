import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_text_styles.dart';

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel({super.key, required this.text});


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.font13Medium(context).copyWith(color: AppColors.textPrimary), // A
    );
  }
}
