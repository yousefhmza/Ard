import 'package:ared/core/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';
import '../../providers/add_offer_provider.dart';

class AddOfferStepOne extends StatelessWidget {
  const AddOfferStepOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddOfferProvider>(
      builder: (context, addOfferProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(AppStrings.offerType, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              Wrap(
                spacing: AppSize.s8.w,
                runSpacing: AppSize.s8.w,
                children: [
                  if (addOfferProvider.offerAttributes?.type != null)
                    ...addOfferProvider.offerAttributes!.type!.map(
                      (e) => CustomChip(
                        label: e.title,
                        isSelected: addOfferProvider.addOfferBody.offerType == e,
                        onSelected: () {
                          addOfferProvider.addOfferBody.copyWith(offerType: e);
                          addOfferProvider.notify();
                        },
                      ),
                    ),
                  // CustomChip(
                  //   label: AppStrings.sell,
                  //   isSelected: addOfferProvider.addOfferBody.offerType == "sell",
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.copyWith(offerType: "sell");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                  // HorizontalSpace(AppSize.s16.w),
                  // CustomChip(
                  //   label: AppStrings.rent,
                  //   isSelected: addOfferProvider.addOfferBody.offerType == "rent",
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.copyWith(offerType: "rent");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.width, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(AppStrings.streetWidth, color: AppColors.grey),
                  CustomText(
                    "${addOfferProvider.addOfferBody.streetWidth} ${AppStrings.meter}",
                    fontWeight: FontWeightManager.bold,
                    color: AppColors.pink,
                    fontSize: FontSize.s16,
                  ),
                ],
              ),
              Slider(
                divisions: 400,
                min: 0,
                max: 200,
                value: double.tryParse(addOfferProvider.addOfferBody.streetWidth) ?? 0.0,
                onChanged: (value) {
                  addOfferProvider.addOfferBody.copyWith(streetWidth: value.roundToDouble().toString());
                  addOfferProvider.notify();
                },
              ),
               VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.streetHeight, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(AppStrings.streetHeight, color: AppColors.grey),
                  CustomText(
                    "${addOfferProvider.addOfferBody.streetHeight} ${AppStrings.meter}",
                    fontWeight: FontWeightManager.bold,
                    color: AppColors.pink,
                    fontSize: FontSize.s16,
                  ),
                ],
              ),
              Slider(
                divisions: 400,
                min: 0,
                max: 200,
                value: double.tryParse(addOfferProvider.addOfferBody.streetHeight) ?? 0.0,
                onChanged: (value) {
                  addOfferProvider.addOfferBody.copyWith(streetHeight: value.roundToDouble().toString());
                  addOfferProvider.notify();
                },
              ),
             
             
              VerticalSpace(AppSize.s12.h),
              const CustomText(AppStrings.face, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s8.h),
              Wrap(
                spacing: AppSize.s8.w,
                runSpacing: AppSize.s8.w,
                children: [
                  CustomChip(
                    label: AppStrings.north,
                    isSelected: addOfferProvider.addOfferBody.view == "north",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "north");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.south,
                    isSelected: addOfferProvider.addOfferBody.view == "south",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "south");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.east,
                    isSelected: addOfferProvider.addOfferBody.view == "east",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "east");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.west,
                    isSelected: addOfferProvider.addOfferBody.view == "west",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "west");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.northEast,
                    isSelected: addOfferProvider.addOfferBody.view == "northEast",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "northEast");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.northWest,
                    isSelected: addOfferProvider.addOfferBody.view == "northWest",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "northWest");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.southEast,
                    isSelected: addOfferProvider.addOfferBody.view == "southEast",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "southEast");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.southWest,
                    isSelected: addOfferProvider.addOfferBody.view == "southWest",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "southWest");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.threeStreets,
                    isSelected: addOfferProvider.addOfferBody.view == "threeStreets",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "threeStreets");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.fourStreets,
                    isSelected: addOfferProvider.addOfferBody.view == "fourStreets",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(view: "fourStreets");
                      addOfferProvider.notify();
                    },
                  ),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.useType, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              Wrap(
                spacing: AppSize.s8.w,
                runSpacing: AppSize.s8.w,
                children: [
                  if (addOfferProvider.offerAttributes?.advertiserAttributeItem != null)
                    ...addOfferProvider.offerAttributes!.advertiserAttributeItem!.map(
                      (e) => CustomChip(
                        label: e.title,
                        isSelected: addOfferProvider.addOfferBody.usage == e,
                        onSelected: () {
                          addOfferProvider.addOfferBody.copyWith(usage: e);
                          addOfferProvider.notify();
                        },
                      ),
                    ),
                  // CustomChip(
                  //   label: AppStrings.residential,
                  //   isSelected: addOfferProvider.addOfferBody.usage == "residential",
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.copyWith(usage: "residential");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                  // CustomChip(
                  //   label: AppStrings.commercial,
                  //   isSelected: addOfferProvider.addOfferBody.usage == "commercial",
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.copyWith(usage: "commercial");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                  // CustomChip(
                  //   label: AppStrings.resCom,
                  //   isSelected: addOfferProvider.addOfferBody.usage == "resCom",
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.copyWith(usage: "resCom");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.services, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              Wrap(
                spacing: AppSize.s8.w,
                runSpacing: AppSize.s8.w,
                children: [
                  if (addOfferProvider.offerAttributes?.service != null)
                    ...addOfferProvider.offerAttributes!.service!.map(
                      (e) => CustomChip(
                        label: e.title,
                        isSelected: addOfferProvider.addOfferBody.services.where((element) => element.id == e.id).isNotEmpty,
                        onSelected: () {
                          addOfferProvider.addOfferBody.services.where((element) => element.id == e.id).isNotEmpty
                              ? addOfferProvider.addOfferBody.services.remove(e)
                              : addOfferProvider.addOfferBody.services.add(e);
                          addOfferProvider.notify();
                        },
                      ),
                    ),

                  // CustomChip(
                  //   label: AppStrings.water,
                  //   isSelected: addOfferProvider.addOfferBody.services.contains("water"),
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.services.contains("water") ? addOfferProvider.addOfferBody.services.remove("water") : addOfferProvider.addOfferBody.services.add("water");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                  // CustomChip(
                  //   label: AppStrings.electricity,
                  //   isSelected: addOfferProvider.addOfferBody.services.contains("electricity"),
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.services.contains("electricity")
                  //         ? addOfferProvider.addOfferBody.services.remove("electricity")
                  //         : addOfferProvider.addOfferBody.services.add("electricity");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                  // CustomChip(
                  //   label: AppStrings.sewage,
                  //   isSelected: addOfferProvider.addOfferBody.services.contains("sewage"),
                  //   onSelected: () {
                  //     addOfferProvider.addOfferBody.services.contains("sewage") ? addOfferProvider.addOfferBody.services.remove("sewage") : addOfferProvider.addOfferBody.services.add("sewage");
                  //     addOfferProvider.notify();
                  //   },
                  // ),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              CustomButton(
                text: AppStrings.next,
                onPressed: () {
                  if (addOfferProvider.addOfferBody.offerType == null ||
                      addOfferProvider.addOfferBody.streetWidth == "0.0" ||
                      addOfferProvider.addOfferBody.view.isEmpty ||
                      addOfferProvider.addOfferBody.usage == null ||
                      addOfferProvider.addOfferBody.services.isEmpty) {
                    Alerts.showToast(AppStrings.fillAllData);
                    return;
                  }
                  Provider.of<AddOfferProvider>(context, listen: false).setCurrentStep(1);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
