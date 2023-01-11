import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/core/network/models/basic_response.dart';
import 'package:ared/core/view/widgets/platform_widgets/loading_spinner.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/widgets/custom_button.dart';
import '../../../../core/view/widgets/custom_chip.dart';
import '../../../../core/view/widgets/custom_text.dart';
import '../../../../core/view/widgets/custom_text_field.dart';
import '../../../../core/view/widgets/spaces.dart';
import '../../providers/add_offer_provider.dart';

class AddOfferStepTwo extends StatefulWidget {
  const AddOfferStepTwo({Key? key}) : super(key: key);

  @override
  State<AddOfferStepTwo> createState() => _AddOfferStepTwoState();
}

class _AddOfferStepTwoState extends State<AddOfferStepTwo> {
  late final TextEditingController totalPriceController;
  late final AddOfferProvider addOfferProvider;

  @override
  void initState() {
    addOfferProvider = Provider.of<AddOfferProvider>(context, listen: false);
    totalPriceController = TextEditingController(text: addOfferProvider.addOfferBody.totalPrice);
    super.initState();
  }

  void handleTotalPrice(BuildContext context, String area, String meterPrice) {
    if (area.isEmpty || meterPrice.isEmpty) {
      totalPriceController.text = "0";
      return;
    }
    totalPriceController.text = (int.parse(area) * int.parse(meterPrice)).toString();
    addOfferProvider.addOfferBody.copyWith(totalPrice: totalPriceController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddOfferProvider>(
      builder: (context, addOfferProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(AppStrings.meterPrice, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
                        VerticalSpace(AppSize.s12.h),
                        CustomTextField(
                          hintText: AppStrings.dummy100,
                          keyBoardType: TextInputType.number,
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            addOfferProvider.addOfferBody.copyWith(price: value);
                            handleTotalPrice(
                              context,
                              addOfferProvider.addOfferBody.space,
                              addOfferProvider.addOfferBody.price,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  HorizontalSpace(AppSize.s16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(AppStrings.area, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
                        VerticalSpace(AppSize.s12.h),
                        CustomTextField(
                          hintText: AppStrings.dummyArea,
                          keyBoardType: TextInputType.number,
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            addOfferProvider.addOfferBody.copyWith(space: value);
                            handleTotalPrice(
                              context,
                              addOfferProvider.addOfferBody.space,
                              addOfferProvider.addOfferBody.price,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.landPrice, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              CustomTextField(
                controller: totalPriceController,
                readOnly: true,
                keyBoardType: TextInputType.number,
                formatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.advertiseRelation, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              Wrap(
                spacing: AppSize.s8.w,
                runSpacing: AppSize.s8.w,
                children: [
                  CustomChip(
                    label: AppStrings.owner,
                    isSelected: addOfferProvider.addOfferBody.relationship == "owner",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(relationship: "owner");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.client,
                    isSelected: addOfferProvider.addOfferBody.relationship == "client",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(relationship: "client");
                      addOfferProvider.notify();
                    },
                  ),
                  CustomChip(
                    label: AppStrings.median,
                    isSelected: addOfferProvider.addOfferBody.relationship == "median",
                    onSelected: () {
                      addOfferProvider.addOfferBody.copyWith(relationship: "median");
                      addOfferProvider.notify();
                    },
                  ),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.offerDetails, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              CustomTextField(
                hintText: AppStrings.offerDetails,
                minLines: 5,
                maxLines: 5,
                onChanged: (value) => addOfferProvider.addOfferBody.copyWith(offerDetails: value),
              ),
              VerticalSpace(AppSize.s12.h),
              Row(
                children: [
                  Consumer<AddOfferProvider>(
                    builder: (context, addOfferProvider, child) => Checkbox(
                      value: addOfferProvider.addOfferBody.termsAgreed,
                      onChanged: (value) {
                        addOfferProvider.addOfferBody.copyWith(termsAgreed: value);
                        addOfferProvider.notify();
                      },
                      activeColor: AppColors.pink,
                    ),
                  ),
                  const CustomText(AppStrings.agreeOnPP),
                ],
              ),
              VerticalSpace(AppSize.s32.h),
              //
              Consumer<AddOfferProvider>(
                builder: (context, addOfferProvider, child) => addOfferProvider.isLoading
                    ? const LoadingSpinner()
                    : CustomButton(
                        text: AppStrings.save,
                        onPressed: () async {
                          if (addOfferProvider.addOfferBody.offerDetails.isEmpty || addOfferProvider.addOfferBody.relationship.isEmpty || addOfferProvider.addOfferBody.price.isEmpty || addOfferProvider.addOfferBody.space.isEmpty) {
                            Alerts.showToast(AppStrings.fillAllData);
                            return;
                          }

                          if (!addOfferProvider.addOfferBody.termsAgreed) {
                            Alerts.showToast(AppStrings.mustAgreeOnPP);
                            return;
                          }

                          FocusManager.instance.primaryFocus?.unfocus();
                          final result = await addOfferProvider.addOffer();
                          result.fold(
                            (failure) => Alerts.showSnackBar(context, failure.message),
                            (basicResponse) {
                              // Provider.of<LayoutProvider>(context, listen: false).setCurrentIndex(0);
                              if(basicResponse.success)
                              NavigationService.goBack(context);
                              Alerts.showToast(basicResponse.message);
                            },
                          );
                        },
                      ),
              ),
              //* cancel step 3
              // CustomButton(
              //   text: AppStrings.next,
              //   onPressed: () {
              //     if (addOfferProvider.addOfferBody.totalPrice.isEmpty ||
              //         addOfferProvider.addOfferBody.relationship.isEmpty ||
              //         addOfferProvider.addOfferBody.price.isEmpty ||
              //         addOfferProvider.addOfferBody.space.isEmpty ||
              //         addOfferProvider.addOfferBody.offerDetails.isEmpty) {
              //       Alerts.showToast(AppStrings.fillAllData);
              //       return;
              //     }
              //     if (!addOfferProvider.addOfferBody.termsAgreed) {
              //       Alerts.showToast(AppStrings.acceptTermsFirst);
              //       return;
              //     }
              //     Provider.of<AddOfferProvider>(context, listen: false).setCurrentStep(2);
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
