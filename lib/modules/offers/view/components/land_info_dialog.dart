import 'package:flutter/material.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';

import '../../../../core/view/app_views.dart';

class LandInfoDialog extends StatelessWidget {
  const LandInfoDialog({Key? key}) : super(key: key);

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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppSize.s8.r),
                        ),
                        child: const CustomText(
                          "الاندلس",
                          color: AppColors.white,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    HorizontalSpace(AppSize.s8.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p8.w),
                        decoration: BoxDecoration(
                          color: AppColors.pink,
                          borderRadius: BorderRadius.circular(AppSize.s8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CustomText(
                              "320${AppStrings.meterSquare}",
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            CustomIcon(Icons.fullscreen),
                          ],
                        ),
                      ),
                    ),
                    HorizontalSpace(AppSize.s8.w),
                    const CustomIcon(Icons.location_on, color: AppColors.black),
                    HorizontalSpace(AppSize.s8.w),
                    InkWell(
                      onTap: () => NavigationService.goBack(context),
                      child: const CustomIcon(Icons.cancel, color: AppColors.pink),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(AppStrings.landNumber, fontWeight: FontWeightManager.bold),
                    HorizontalSpace(AppSize.s8.w),
                    const CustomText("2457", fontWeight: FontWeightManager.bold, color: AppColors.pink),
                    HorizontalSpace(AppSize.s32.w),
                    const CustomText(AppStrings.planNumber, fontWeight: FontWeightManager.bold),
                    HorizontalSpace(AppSize.s8.w),
                    const CustomText("546", fontWeight: FontWeightManager.bold, color: AppColors.pink),
                  ],
                ),
              ],
            ),
          ),
          VerticalSpace(AppSize.s16.h),
          CustomButton(
            text: AppStrings.next,
            onPressed: () async {
              await NavigationService.goBack(context);
              // ignore: use_build_context_synchronously
              await NavigationService.push(context, Routes.addOfferScreen);
            },
          ),
        ],
      ),
    );
  }
}
