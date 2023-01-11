import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatelessWidget {
  final refresh;

  GeneralErrorWidget({required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8),
          Icon(Icons.error, color: Colors.red, size: 120),
          SizedBox(height: 8),
          CustomText(AppStrings.someThingWentWrongTryAgainLater),
          SizedBox(height: 8),
          CustomButton(text: AppStrings.retry, onPressed: () => refresh()),
        ],
      ),
    );
  }
}
