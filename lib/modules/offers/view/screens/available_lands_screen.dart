import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/widgets/custom_appbar.dart';
import '../components/add_offer_map.dart';

class AvailableLandsScreen extends StatelessWidget {
  const AvailableLandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AddOfferMap(),
        SizedBox(
          height: AppSize.s100.h,
          child: const CustomAppbar(
            title: CustomText(
              AppStrings.addNewOffer,
              fontWeight: FontWeightManager.bold,
              fontSize: FontSize.s20,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
