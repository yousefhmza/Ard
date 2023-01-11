import 'package:ared/core/extensions/num_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../resources/resources.dart';
import '../../app_views.dart';

class AppDialog extends BasePlatformWidget<AlertDialog, CupertinoAlertDialog> {
  final String title;
  final VoidCallback onConfirm;
  final String confirmText;
  final String? description;

  const AppDialog({
    required this.title,
    required this.onConfirm,
    required this.confirmText,
    this.description,
    Key? key,
  }) : super(key: key);

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(title, fontWeight: FontWeightManager.bold),
      content: description != null ? CustomText(description!) : null,
      actions: [
        CustomTextButton(text: AppStrings.cancel, onPressed: () => NavigationService.goBack(context)),
        CustomTextButton(
          text: confirmText,
          onPressed: () {
            NavigationService.goBack(context);
            onConfirm();
          },
        ),
      ],
    );
  }

  @override
  AlertDialog createMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: CustomText(title, fontWeight: FontWeightManager.bold),
      titlePadding: EdgeInsets.all(AppPadding.p12.w).copyWith(bottom: AppSize.s8.h),
      content: description != null ? CustomText(description!) : null,
      contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p12.w),
      actions: [
        CustomTextButton(
          text: AppStrings.cancel,
          onPressed: () => NavigationService.goBack(context),
          textColor: AppColors.pink,
        ),
        CustomTextButton(
          text: confirmText,
          onPressed: () {
            NavigationService.goBack(context);
            onConfirm();
          },
        ),
      ],
    );
  }
}
