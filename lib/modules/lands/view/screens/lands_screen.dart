import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/lands/view/screens/lands_list.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class LandsScreen extends StatefulWidget {
  const LandsScreen({Key? key}) : super(key: key);

  @override
  State<LandsScreen> createState() => _LandsScreenState();
}

class _LandsScreenState extends State<LandsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: AuthErrorWidget(
            action: () => () {
                  NavigationService.push(context, Routes.authScreen);
                }),
      );
    }

    return const Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: MainAppbar(title: AppStrings.landRequests),
      body: LandsListWidget(),
    );
  }
}
