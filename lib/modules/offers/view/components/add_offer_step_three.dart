import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/widgets/custom_button.dart';
import '../../../../core/view/widgets/custom_text.dart';
import '../../../../core/view/widgets/custom_text_field.dart';
import '../../../../core/view/widgets/platform_widgets/loading_spinner.dart';
import '../../../../core/view/widgets/spaces.dart';
import '../../providers/add_offer_provider.dart';

class AddOfferStepThree extends StatelessWidget {
  const AddOfferStepThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddOfferProvider>(
      builder: (context, addOfferProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(AppStrings.advertiserNumber, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              const CustomTextField(hintText: AppStrings.addAdvertiserNumber),
              VerticalSpace(AppSize.s32.h),
              const CustomText(AppStrings.licenceNumber, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
              VerticalSpace(AppSize.s12.h),
              const CustomTextField(hintText: AppStrings.addLicenceNumber),
              VerticalSpace(AppSize.s32.h),
              Consumer<AddOfferProvider>(
                builder: (context, addOfferProvider, child) => addOfferProvider.isLoading
                    ? const LoadingSpinner()
                    : CustomButton(
                        text: AppStrings.save,
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final result = await addOfferProvider.addOffer();
                          result.fold(
                            (failure) => Alerts.showSnackBar(context, failure.message),
                            (res) {
                              // Provider.of<LayoutProvider>(context, listen: false).setCurrentIndex(0);
                              if(res.success)
                              NavigationService.goBack(context);
                              Alerts.showToast(res.message);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
