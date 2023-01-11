import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/utils/validators.dart';
import 'package:ared/modules/auth/provider/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController phoneController = TextEditingController(text: kDebugMode ? '01010101010' : '');

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loginBody.resetValues();
    return StatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Image.asset(AppImages.logo, width: deviceWidth * 0.5),
                  ),
                  const VerticalSpace(AppSize.s24),
                  const CustomText(
                    AppStrings.welcome,
                    color: AppColors.pink,
                    fontSize: FontSize.s24,
                    fontWeight: FontWeightManager.bold,
                  ),
                  const VerticalSpace(AppSize.s24),
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomText(AppStrings.phoneNumber, fontSize: FontSize.s20, fontWeight: FontWeightManager.bold),
                  ),
                  const VerticalSpace(AppSize.s16),
                  CustomTextField(
                    prefix: SizedBox(
                      width: AppSize.s72.w,
                      child: Row(children: const [CustomText("🇸🇦", fontSize: FontSize.s20), CustomText(" 966+ |")]),
                    ),
                    keyBoardType: TextInputType.phone,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validators.notEmptyValidator,
                    controller: phoneController,
                  ),
                  const Spacer(),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) => authProvider.isLoading
                        ? const LoadingSpinner()
                        : CustomButton(
                            text: AppStrings.next,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                final result = await authProvider.updateOtp(phoneController.text.trim());
                                result.fold(
                                  (failure) => Alerts.showSnackBar(context, failure.message),
                                  (otp) => NavigationService.pushReplacement(
                                    context,
                                    Routes.otpScreen,
                                    arguments: {"phone_number": phoneController.text.trim(), "required_otp": otp},
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
