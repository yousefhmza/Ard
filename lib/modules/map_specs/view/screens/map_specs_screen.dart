import 'package:ared/modules/map_specs/provider/map_specs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';
import '../../../../modules/map_specs/view/widgets/map_color_item.dart';

class MapSpecsScreen extends StatelessWidget {
  const MapSpecsScreen({Key? key}) : super(key: key);

  // Will be a model
  static const List<String> titles = [
    AppStrings.residential,
    AppStrings.commercial,
    AppStrings.flats,
    AppStrings.facilities,
    AppStrings.warehouses,
    AppStrings.governmental,
    AppStrings.projects,
    AppStrings.artificial,
  ];
  static const List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    final MapSpecsProvider mapSpecsProvider = Provider.of<MapSpecsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: const MainAppbar(title: AppStrings.mapSpecs),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(AppSize.s16.h),
            ListTile(
              tileColor: AppColors.white,
              title: const CustomText(
                AppStrings.showMyOffers,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s16,
              ),
              trailing: Selector<MapSpecsProvider, bool>(
                selector: (context, mapSpecsProvider) => mapSpecsProvider.showMyOffers,
                builder: (context, value, child) {
                  return Switch.adaptive(
                    value: value,
                    onChanged: (value) => mapSpecsProvider.setMapSpecs(showMyOffers: value),
                    activeColor: AppColors.pink,
                  );
                },
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            ListTile(
              tileColor: AppColors.white,
              title: const CustomText(
                AppStrings.showPriceMark,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s16,
              ),
              trailing: Selector<MapSpecsProvider, bool>(
                selector: (context, mapSpecsProvider) => mapSpecsProvider.showPriceMark,
                builder: (context, value, child) {
                  return Switch.adaptive(
                    value: value,
                    onChanged: (value) => mapSpecsProvider.setMapSpecs(showPriceMark: value),
                    activeColor: AppColors.pink,
                  );
                },
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            ListTile(
              tileColor: AppColors.white,
              title: const CustomText(
                AppStrings.showMapColors,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s16,
              ),
              trailing: Selector<MapSpecsProvider, bool>(
                selector: (context, mapSpecsProvider) => mapSpecsProvider.showMapColors,
                builder: (context, value, child) {
                  return Switch.adaptive(
                    value: value,
                    onChanged: (value) => mapSpecsProvider.setMapSpecs(showMapColors: value),
                    activeColor: AppColors.pink,
                  );
                },
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            Container(
              padding: EdgeInsets.all(AppPadding.p16.w),
              margin: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSize.s16.r),
              ),
              child: Row(
                children: const [
                  CustomIcon(Icons.height, color: AppColors.primary),
                  CustomText(
                    AppStrings.measureSpaces,
                    color: AppColors.primary,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                  ),
                ],
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
              child: const CustomText(
                AppStrings.mapColors,
                color: AppColors.pink,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
              child: CustomDropDownField<String>(
                value: "1",
                onChanged: (value) {},
                hintText: "hintText",
                items: const [
                  DropdownMenuItem(value: "1", child: CustomText("استخدام الارض")),
                  DropdownMenuItem(value: "2", child: CustomText("المساحة")),
                  DropdownMenuItem(value: "3", child: CustomText("سعر المتر")),
                  DropdownMenuItem(value: "4", child: CustomText("قيمة الصفقة")),
                ],
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(AppPadding.p16.w),
              itemCount: titles.length,
              itemBuilder: (context, index) => MapColorItem(title: titles[index], color: colors[index]),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: deviceWidth / 2,
                mainAxisSpacing: AppSize.s8.w,
                crossAxisSpacing: AppSize.s8.w,
                childAspectRatio: 3.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
