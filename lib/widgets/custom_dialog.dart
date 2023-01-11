import 'package:ared/widgets/auth_error.dart';
import 'package:flutter/material.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class DialogAuth extends StatelessWidget {
  const DialogAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.p24.w),
      backgroundColor: AppColors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.all(AppPadding.p16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSize.s8.r),
              ),
              child: AuthErrorWidget(
                action: () {
                  NavigationService.push(context, Routes.authScreen);
                },
              )),
          VerticalSpace(AppSize.s16.h),
        ],
      ),
    );
  }
}
