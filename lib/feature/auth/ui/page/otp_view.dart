import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/auth/ui/cubit/auth_cubit.dart';
import 'package:task/feature/auth/ui/widget/otp_view_body.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theming/app_colors.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: OtpViewBody(
          email: email,
        ),
      ),
    );
  }
}
