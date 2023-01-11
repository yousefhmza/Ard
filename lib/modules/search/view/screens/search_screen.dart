import '../../../../core/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/view/app_views.dart';
import '../../../../core/resources/resources.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: const MainAppbar(title: AppStrings.search),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(AppSize.s16.h),
            Center(child: Image.asset(AppImages.map, width: AppSize.s100.w)),
            VerticalSpace(AppSize.s16.h),
            const Center(
              child: CustomText(AppStrings.searchTitle1, fontWeight: FontWeightManager.bold, fontSize: FontSize.s18),
            ),
            const Center(
              child:
                  CustomText(AppStrings.searchTitle2, fontWeight: FontWeightManager.semiBold, fontSize: FontSize.s16),
            ),
            VerticalSpace(AppSize.s32.h),
            const CustomText(AppStrings.chartNumber, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
            VerticalSpace(AppSize.s8.h),
            const CustomTextField(hintText: Constants.empty),
            VerticalSpace(AppSize.s24.h),
            const CustomText(AppStrings.pieceNumber, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
            VerticalSpace(AppSize.s8.h),
            const CustomTextField(hintText: Constants.empty),
            VerticalSpace(AppSize.s24.h),
            const CustomText(AppStrings.buildingAddress, fontWeight: FontWeightManager.bold, fontSize: FontSize.s16),
            VerticalSpace(AppSize.s8.h),
            const CustomTextField(hintText: AppStrings.neiCity),
            VerticalSpace(AppSize.s32.h),
            CustomButton(text: AppStrings.determineBuilding, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
