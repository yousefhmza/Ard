import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/validators.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/alerts.dart';
import '../../provider/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.registrationBody.resetValues();
    return StatusBar(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(color: AppColors.black),
                  const VerticalSpace(AppSize.s16),
                  Center(child: Image.asset(AppImages.logo, width: deviceWidth * 0.3)),
                  const VerticalSpace(AppSize.s16),
                  const Center(child: CustomText(AppStrings.signIn, fontWeight: FontWeightManager.bold)),
                  const VerticalSpace(AppSize.s16),
                  const CustomText(AppStrings.fullName, fontWeight: FontWeightManager.bold, color: AppColors.blue),
                  const VerticalSpace(AppSize.s6),
                  CustomTextField(
                    validator: Validators.notEmptyValidator,
                    onSaved: (value) => authProvider.registrationBody.copyWith(name: value),
                  ),
                  const VerticalSpace(AppSize.s16),
                  const CustomText(AppStrings.phoneNumber, fontWeight: FontWeightManager.bold, color: AppColors.blue),
                  const VerticalSpace(AppSize.s6),
                  CustomTextField(
                    prefix: SizedBox(
                      width: AppSize.s72.w,
                      child: Row(children: const [CustomText("🇸🇦", fontSize: FontSize.s20), CustomText(" 966+ |")]),
                    ),
                    keyBoardType: TextInputType.phone,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validators.notEmptyValidator,
                    onSaved: (value) => authProvider.registrationBody.copyWith(mobile: value),
                  ),
                  const VerticalSpace(AppSize.s16),
                  const CustomText(AppStrings.email, fontWeight: FontWeightManager.bold, color: AppColors.blue),
                  const VerticalSpace(AppSize.s6),
                  CustomTextField(
                    validator: Validators.notEmptyValidator,
                    onSaved: (value) => authProvider.registrationBody.copyWith(email: value),
                  ),
                  const VerticalSpace(AppSize.s16),
                  const CustomText(AppStrings.docType, fontWeight: FontWeightManager.bold, color: AppColors.blue),
                  const VerticalSpace(AppSize.s6),
                  CustomDropDownField<String>(
                    validator: Validators.notEmptyValidator,
                    onChanged: (value) => authProvider.registrationBody.copyWith(idType: value),
                    items: const [
                      DropdownMenuItem<String>(value: "هوية وطنية", child: CustomText(AppStrings.natId)),
                    ],
                  ),
                  const VerticalSpace(AppSize.s16),
                  const CustomText(AppStrings.natIdNumber, fontWeight: FontWeightManager.bold, color: AppColors.blue),
                  const VerticalSpace(AppSize.s6),
                  CustomTextField(
                    validator: Validators.notEmptyValidator,
                    onSaved: (value) => authProvider.registrationBody.copyWith(idNumber: value),
                  ),
                  // const VerticalSpace(AppSize.s16),
                  // const CustomText(AppStrings.licenceNumber, fontWeight: FontWeightManager.bold, color: AppColors.primary),
                  // const VerticalSpace(AppSize.s6),
                  // CustomTextField(
                  //   validator: Validators.notEmptyValidator,
                  //   onSaved: (value) => authProvider.registrationBody.copyWith(licenseNumber: value),
                  // ),
                  const VerticalSpace(AppSize.s24),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) => authProvider.isLoading
                        ? const LoadingSpinner()
                        : CustomButton(
                            text: AppStrings.signup,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                FocusManager.instance.primaryFocus?.unfocus();
                                final result = await authProvider.register();
                                result.fold(
                                  (failure) => Alerts.showSnackBar(context, failure.message),
                                  (otp) => NavigationService.pushReplacement(
                                    context,
                                    Routes.otpScreen,
                                    arguments: {
                                      "phone_number": authProvider.registrationBody.mobile,
                                      "required_otp": otp,
                                    },
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
