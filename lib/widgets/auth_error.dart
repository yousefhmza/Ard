import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/view/widgets/custom_button.dart';
import 'package:ared/core/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AuthErrorWidget extends StatelessWidget {
  final Function action;

  const AuthErrorWidget({required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          const Icon(
            Icons.warning,
            color: Colors.orange,
            size: 130,
          ),
          const SizedBox(height: 8),
          const CustomText(AppStrings.requireLoginMessage),
          const SizedBox(height: 8),
          CustomButton(
              text: AppStrings.login,
              onPressed: () {
                NavigationService.push(context, Routes.authScreen);
              }),
        ],
      ),
    );
  }
}
