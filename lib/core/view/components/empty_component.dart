import 'package:flutter/material.dart';

import '../../extensions/num_extensions.dart';
import '../../resources/resources.dart';
import '../app_views.dart';

class EmptyComponent extends StatelessWidget {
  final String asset;
  final String text;

  const EmptyComponent({required this.asset, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(asset, width: AppSize.s100.w, height: AppSize.s100.w, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: CustomText(
              text,
              textAlign: TextAlign.center,
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ],
      ),
    );
  }
}
