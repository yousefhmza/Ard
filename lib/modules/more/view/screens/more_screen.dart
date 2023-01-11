import 'package:ared/core/utils/globals.dart';
import 'package:ared/main.dart';
import 'package:ared/modules/auth/provider/auth_provider.dart';
import 'package:ared/modules/more/view/widget/more_item.dart';
import 'package:ared/modules/profile/models/response/profile_response.dart';
import 'package:ared/modules/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/app_views.dart';
import '../../models/option_model.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  List<Option> options(BuildContext context) => [
        //Profile

        Option(
          title: AppStrings.profile,
          icon: Icons.person,
          onTap: () => NavigationService.push(context, Routes.profileScreen),
        ),

        //Offers
        //Subscription
        Option(
          title: AppStrings.subscription,
          icon: Icons.subscriptions,
          onTap: () async {
            var myAppModel = getIt.get<ProfileProvider>();
            ProfileResponse? user = await myAppModel.getProfile();
            if (user == null || user.subscription == null) {
              NavigationService.push(context, Routes.paymentMethodScreen);
            } else {
              NavigationService.push(context, Routes.transferInfoScreen, arguments: {
                "subscription": user.subscription,
              });
            }
          },
        ),

        //* My offers
        Option(title: AppStrings.myOffers, icon: Icons.request_page, onTap: () => NavigationService.push(context, Routes.myOffers)),
        //* My orders
        Option(
          title: AppStrings.myOrders,
          icon: Icons.request_page,
          onTap: () {},
        ), //* My orders
        Option(
          title: AppStrings.landRequests,
          icon: Icons.request_page,
          onTap: () {
            NavigationService.push(context, Routes.landRequestsScreen);
          },
        ),
        //* My orders
        Option(
          title: AppStrings.favorite,
          icon: Icons.request_page,
          onTap: () {},
        ),
        //Help
        //About
        //Policy
        if (currentUser != null)
          Option(
            title: AppStrings.logout,
            icon: Icons.logout,
            onTap: () => Alerts.showAppDialog(
              context,
              title: AppStrings.logoutConfirm,
              onConfirm: () async {
                final result = await Provider.of<AuthProvider>(context, listen: false).logout();
                result.fold(
                  (failure) => Alerts.showSnackBar(context, failure.message),
                  (message) {
                    Alerts.showToast(message);
                    NavigationService.pushReplacementAll(context, Routes.authScreen);
                  },
                );
              },
              confirmText: AppStrings.logout,
            ),
          ),
        if (currentUser == null)
          Option(
              title: AppStrings.login,
              icon: Icons.login,
              onTap: () {
                NavigationService.pushReplacementAll(context, Routes.authScreen);
              }),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(title: AppStrings.more),
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        color: AppColors.lightGrey,
        child: ListView.separated(
          itemCount: options(context).length,
          padding: EdgeInsets.symmetric(vertical: AppPadding.p16.w),
          itemBuilder: (context, index) => MoreItem(options(context)[index]),
          separatorBuilder: (context, index) => VerticalSpace(AppSize.s16.h),
        ),
      ),
    );
  }
}
