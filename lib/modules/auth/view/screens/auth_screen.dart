import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      isLight: true,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.authBg), fit: BoxFit.cover),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.p16.w),
            decoration: BoxDecoration(color: AppColors.black.withOpacity(0.25)),
            child: SafeArea(
              child: Column(
                children: [
                  const VerticalSpace(AppSize.s24),
                  Image.asset(AppImages.logo, width: deviceWidth * 0.5),
                  const Spacer(),
                  CustomButton(
                    text: AppStrings.login,
                    onPressed: () => NavigationService.push(context, Routes.phoneNumberScreen),
                  ),
                  const VerticalSpace(AppSize.s16),
                  CustomButton(
                    text: AppStrings.signup,
                    color: AppColors.white,
                    textColor: AppColors.black,
                    onPressed: () => NavigationService.push(context, Routes.signupScreen),
                  ),
                  const VerticalSpace(AppSize.s16),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.white, endIndent: AppSize.s12.w)),
                      const CustomText(AppStrings.or, color: AppColors.white, fontSize: FontSize.s12),
                      Expanded(child: Divider(color: AppColors.white, indent: AppSize.s12.w)),
                    ],
                  ),
                  const VerticalSpace(AppSize.s16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () {},
                          color: AppColors.white,
                          child: Image.asset(AppImages.google, height: AppSize.s24.w, width: AppSize.s24.w),
                        ),
                      ),
                      const HorizontalSpace(AppSize.s16),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {},
                          color: AppColors.white,
                          child: Image.asset(AppImages.facebook, height: AppSize.s24.w, width: AppSize.s24.w),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpace(AppSize.s16),
                  GestureDetector(
                    onTap: (){
                      currentUser = null;
                      NavigationService.pushReplacementAll(context, Routes.layoutScreen);
                    },
                    child: const CustomText(AppStrings.loginAsVisitor,color: Colors.white)),
                  const VerticalSpace(AppSize.s16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
