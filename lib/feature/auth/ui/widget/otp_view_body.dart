import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/core/helpers/extensions.dart';
import 'package:task/core/routing/routes.dart';
import 'package:task/core/theming/app_text_styles.dart';
import 'package:task/feature/auth/ui/cubit/auth_cubit.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/custom_gradient_button.dart';
import '../../../../generated/app_string.dart';
import '../../../../generated/assets.dart';

class OtpViewBody extends StatefulWidget {
  final String email;

  const OtpViewBody({
    super.key,
    required this.email,
  });

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

class _OtpViewBodyState extends State<OtpViewBody> {
  final TextEditingController _otpController = TextEditingController();
  late StreamController<ErrorAnimationType> _errorController;

  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _errorController = StreamController<ErrorAnimationType>.broadcast();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _errorController.close();
    super.dispose();
  }


  Future<void> _resend() async {
    if (_remainingSeconds > 0) return;
    _otpController.clear();
    _startTimer();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            80.verticalSpace,
            Image.asset(Assets.imageLogo),
            116.verticalSpace,
            Text(
              tr(context, AppStrings.verify),
              textAlign: TextAlign.center,
              style: AppTextStyles.font20Bold(context).copyWith(
                color: AppColors.black,
              ),
            ),
            8.verticalSpace,
            Text(
              tr(context, AppStrings.verifyMessage),
              textAlign: TextAlign.center,
              style: AppTextStyles.font13Medium(context).copyWith(
                color: AppColors.secondary,
              ),
            ),
            40.verticalSpace,
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _otpController,
              autoFocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textStyle: AppTextStyles.font20Bold(context).copyWith(
                color: AppColors.black,
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12.r),
                fieldHeight: 56.h,
                fieldWidth: 52.w,
                borderWidth: 1.2,
                activeColor: AppColors.primary,
                selectedColor: AppColors.primary,
                inactiveColor: Colors.grey[300]!,
                errorBorderColor: Colors.red,
                activeFillColor: Colors.grey[50]!,
                selectedFillColor: Colors.grey[50]!,
                inactiveFillColor: Colors.grey[50]!,
              ),
              enableActiveFill: true,
              errorAnimationController: _errorController,
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      tr(context, AppStrings.dontGetCode),
                      style: AppTextStyles.font13Medium(context).copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: _remainingSeconds == 0 ? _resend : null,
                      child: Text(
                        tr(context, AppStrings.resend),
                        style: AppTextStyles.font13Medium(context).copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.primary,
                        )
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_formatTime(_remainingSeconds)} Sec',
                  style: AppTextStyles.font13Medium(context).copyWith(
                      color: AppColors.secondary
                  ),
                ),
              ],
            ),
            40.verticalSpace,
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is VerifySuccess) {
                  ToastHelper().showSuccessToast(
                    context, "Verified Successfully"
                  );
                   context.pushReplacementNamed(Routes.loginView);
                }
                if (state is VerifyError) {
                  ToastHelper().showErrorToast(
                    context,
                    "Verification Failed",
                  );
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomGradientButton(
                  label: tr(context, AppStrings.continue1),
                  onPressed: () {
                    context.read<AuthCubit>().verify(
                      email: widget.email, code: _otpController.text,
                  );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}