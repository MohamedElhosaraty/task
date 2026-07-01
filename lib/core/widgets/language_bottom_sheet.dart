import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/localization/cubit/localization_cubit.dart';
import 'package:task/core/localization/localization_methods.dart';
import 'package:task/core/theming/app_colors.dart';
import 'package:task/core/theming/app_text_styles.dart';
import 'package:task/core/widgets/custom_gradient_button.dart';
import 'package:task/core/widgets/custom_language_option.dart';
import 'package:task/generated/app_string.dart';

enum AppLanguage { arabic, english }

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late AppLanguage _selected;

  @override
  void initState() {
    super.initState();
    final currentCode = context.read<LocalizationCubit>().currentLocale.languageCode;
    _selected = currentCode == 'ar' ? AppLanguage.arabic : AppLanguage.english;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.hint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          18.verticalSpace,
          Text(
            tr(context, AppStrings.language),
            style: AppTextStyles.font20Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
          20.verticalSpace,
          CustomLanguageOption(
            label: tr(context, AppStrings.ar),
            value: AppLanguage.arabic,
            groupValue: _selected,
            onChanged: (val) => setState(() => _selected = val),
          ),
          12.verticalSpace,
          CustomLanguageOption(
            label: tr(context, AppStrings.en),
            value: AppLanguage.english,
            groupValue: _selected,
            onChanged: (val) => setState(() => _selected = val),
          ),
          24.verticalSpace,
          CustomGradientButton(
            label: tr(context, AppStrings.app),
            onPressed: () {
              final isEnglish = _selected == AppLanguage.english;
              context.read<LocalizationCubit>().changeLanguage(isEnglish);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
