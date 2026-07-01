import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/feature/home/ui/cubit/home_cubit.dart';
import 'package:task/feature/home/ui/widget/custom_about_section.dart';
import 'package:task/feature/home/ui/widget/custom_header_card.dart';
import 'package:task/feature/home/ui/widget/custom_home_header.dart';
import 'package:task/feature/home/ui/widget/custom_work_section.dart';

import '../../../../core/theming/app_colors.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          65.verticalSpace,
          const CustomHomeHeader(),
          24.verticalSpace,
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const CircularProgressIndicator(
                  color: AppColors.black,
                );
              }
              if (state is HomeError) {
                return Center(child: Text(state.message));
              }

              if (state is HomeSuccess) {
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ListView(
                        children: [
                          const CustomHeaderCard(),
                          20.verticalSpace,
                          CustomAboutSection(
                            title: state.homeModel.aboutTitle,
                            blocks: state.homeModel.aboutContent,
                          ),
                          20.verticalSpace,
                          CustomWorkSection(
                            title: state.homeModel.workTitle,
                            features: state.homeModel.workFeatures
                                .map((e) => e.title)
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
