import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/offers/view/components/offers_list.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/error_view.dart';
import 'package:ared/widgets/myoffer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class MyOffersScreen extends StatefulWidget {
  const MyOffersScreen({Key? key}) : super(key: key);

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  @override
  void initState() {
    final OffersProvider offersProvider = Provider.of<OffersProvider>(context, listen: false);
    offersProvider.getMyOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OffersProvider offersProvider = Provider.of<OffersProvider>(context, listen: false);
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
      appBar: MainAppbar(title: AppStrings.myOffers),
      body: OffersListWidget(myOffers: true),
    );
  }
}
