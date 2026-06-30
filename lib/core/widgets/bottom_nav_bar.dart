import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/localization/localization_methods.dart';

import '../../generated/app_string.dart';
import '../../generated/assets.dart';
import '../theming/app_colors.dart';
import '../theming/app_text_styles.dart';

class MyBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(top: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background2,
        border: Border(
          top: BorderSide(
            color: AppColors.background2,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        iconSize: 28.w,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(Assets.svgHome),
            icon: SvgPicture.asset(Assets.svgHome, colorFilter: const ColorFilter.mode(AppColors.secondaryLight, BlendMode.srcIn),),
            label: tr(context, AppStrings.home),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(Assets.svgProfile),
            icon: SvgPicture.asset(Assets.svgProfile, colorFilter:const ColorFilter.mode(AppColors.secondaryLight, BlendMode.srcIn),),
            label: tr(context, AppStrings.profile),
          ),
        ],
        unselectedItemColor: AppColors.grey,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: AppTextStyles.font12Medium(context),
        unselectedLabelStyle: AppTextStyles.font12Medium(context),
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: AppColors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}