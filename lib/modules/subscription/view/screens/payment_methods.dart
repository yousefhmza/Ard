import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/app_colors.dart';
import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: MainAppbar(title: AppStrings.paymentMethods),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            _singlePaymentMethod(
              title: AppStrings.mada,
              image: "assets/images/payment_mada.png",
              onTap: () {
                Alerts.showToast(AppStrings.soon);
              },
            ),
            _singlePaymentMethod(
              title: AppStrings.visa,
              image: "assets/images/payment_visa.png",
              onTap: () {
                Alerts.showToast(AppStrings.soon);
              },
            ),
            _singlePaymentMethod(
              title: AppStrings.bankTransfer,
              image: "assets/images/payment_bt.png",
              onTap: () {
                NavigationService.push(context, Routes.subscriptionScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _singlePaymentMethod({
    required String title,
    required String image,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          child: Row(
            children: [
              Expanded(
                  child: CustomText(
                title,
                fontSize: 18,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              )),
              Image.asset(image, width: 60, height: 40),
              SizedBox(width: 12),
            ],
          )),
    );
  }
}
