import 'package:flutter/material.dart';
import 'package:task/core/widgets/language_bottom_sheet.dart';
import '../theming/app_colors.dart';

class CustomChangeLanguage extends StatelessWidget {
  const CustomChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => const LanguageBottomSheet(),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'English',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.language, size: 18, color: AppColors.primaryDark),
          ],
        ),
      ),
    );
  }
}

