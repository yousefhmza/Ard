import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/myoffer_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentUser == null)
      return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: AuthErrorWidget(
            action: () => () {
                  NavigationService.push(context, Routes.authScreen);
                }),
      );

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: MainAppbar(title: AppStrings.offers),
      body: Center(
        child: EmptyComponent(asset: AppImages.noOffers, text: AppStrings.noOffers),
      ),
    
    );
  }
}
