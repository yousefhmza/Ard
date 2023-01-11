import 'package:flutter/material.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class MapColorItem extends StatelessWidget {
  final String title;
  final Color color;

  const MapColorItem({required this.title, required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //square 
          HorizontalSpace(AppSize.s20.w),
          Container(
            width: AppSize.s24.w,
            height: AppSize.s24.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSize.s2.r),
            ),
          ),
          HorizontalSpace(AppSize.s8.w),
          Expanded(child: CustomText(title, fontWeight: FontWeightManager.semiBold, fontSize: FontSize.s18)),
        ],
      ),
    );
  }
}
