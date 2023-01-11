import 'package:ared/core/extensions/non_null_extensions.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/modules/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;
  final String requiredOtp;

  const OTPScreen({required this.phoneNumber, required this.requiredOtp, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loginBody.copyWith(phoneNumber: phoneNumber);
    return StatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Image.asset(AppImages.logo, width: deviceWidth * 0.5),
                ),
                VerticalSpace(AppSize.s24.h),
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CustomText(AppStrings.enterOtp, fontSize: FontSize.s20, fontWeight: FontWeightManager.bold),
                ),
                VerticalSpace(AppSize.s16.h),
                PinFieldAutoFill(
                  codeLength: 4,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                  ],
                  decoration: BoxLooseDecoration(
                    textStyle: const TextStyle(color: AppColors.black, fontSize: FontSize.s18),
                    strokeColorBuilder: FixedColorBuilder(AppColors.grey.withOpacity(0.5)),
                    gapSpace: AppSize.s12,
                    strokeWidth: AppSize.s1_2.w,
                  ),
                  onCodeChanged: (value) {
                    if (value.orEmpty.isNotEmpty) {
                      authProvider.setOtpLengthValidity(value == requiredOtp);
                      authProvider.loginBody.copyWith(otp: value);
                    }
                  },
                ),
                const Spacer(),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) => authProvider.isLoading
                      ? const LoadingSpinner()
                      : CustomButton(
                          text: AppStrings.log,
                          onPressed: authProvider.isOtpLengthValid
                              ? () async {
                                  final result = await authProvider.login();
                                  result.fold(
                                    (failure) => Alerts.showSnackBar(context, failure.message),
                                    (user) => NavigationService.pushReplacementAll(context, Routes.layoutScreen),
                                  );
                                }
                              : null,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
