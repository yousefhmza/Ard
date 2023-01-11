import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/modules/lands/provider/lands_provider.dart';
import 'package:ared/modules/lands/view/components/land_item_widget.dart';
import 'package:ared/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class LandsListWidget extends StatefulWidget {
  const LandsListWidget({Key? key}) : super(key: key);

  @override
  State<LandsListWidget> createState() => _LandsListWidgetState();
}

class _LandsListWidgetState extends State<LandsListWidget> {
  @override
  void initState() {
    LandsProvider landProvider = Provider.of<LandsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      landProvider.getLands();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LandsProvider landProvider = Provider.of<LandsProvider>(context, listen: true);

    if (landProvider.failure != null) {
      return ErrorView(
          failure: landProvider.failure!,
          refresh: () {
            landProvider.getLands();
          });
    }

    if (landProvider.isLoading) return const Center(child: CircularProgressIndicator());
    if (landProvider.landList.isEmpty) return const EmptyComponent(asset: "assets/images/logo.png", text: AppStrings.emptyOffers);

    return ListView.builder(
      itemCount: landProvider.landList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              NavigationService.push(context, Routes.singleLandScreen, arguments: {
                'land_item': landProvider.landList[index],
              });
            },
            child: LandItemWidget(landItem: landProvider.landList[index]));
      },
    );
  }
}
