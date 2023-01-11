import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(currentUser == null) {
      return Scaffold(
      backgroundColor: AppColors.lightGrey,
        body: AuthErrorWidget(action: () =>(){
        NavigationService.push(context, Routes.authScreen);
    }),
      );
    }

    return const Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: MainAppbar(title: AppStrings.notifications),
      body: Center(
        child: EmptyComponent(asset: AppImages.noNotifications, text: AppStrings.noNotifications),
      ),
    );
  }
}
