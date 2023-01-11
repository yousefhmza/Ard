import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/models/responses/my_offers_response.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/error_view.dart';
import 'package:ared/widgets/myoffer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class OffersListWidget extends StatelessWidget {
  final bool myOffers;
  OffersListWidget({ this.myOffers = false});

  @override
  Widget build(BuildContext context) {
    List<OfferItem> offersList = [];
    final OffersProvider offersProvider = Provider.of<OffersProvider>(context, listen: true);
    offersList = myOffers ? offersProvider.myOffersList : offersProvider.offersList;

    if (offersProvider.failure != null)
      return ErrorView(
          failure: offersProvider.failure!,
          refresh: () {
            myOffers ? offersProvider.getMyOffers() : offersProvider.getAllOffers();
          });

    if (offersProvider.isLoading) return Center(child: CircularProgressIndicator());
    if (offersList.isEmpty) return EmptyComponent(asset: "assets/images/logo.png", text: AppStrings.emptyOffers);
    return ListView.builder(
      itemCount: offersList.length,
      itemBuilder: (context, index) {
        return MyOfferItemWidget(offerItem: offersList[index]);
      },
    );
  }
}
