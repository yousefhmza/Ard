import 'package:flutter/material.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/widgets/custom_icon.dart';

class HomeAppbarAction extends StatelessWidget {
  final bool isLeading;

  const HomeAppbarAction({required this.isLeading, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLeading ? () => NavigationService.push(context, Routes.searchScreen) : () => NavigationService.push(context, Routes.mapSpecsScreen),
      child: Ink(
        width: AppSize.s56.w,
        height: AppSize.s40.h,
        decoration: BoxDecoration(
          color: isLeading ? Color(0xffF26060): AppColors.primary,
          borderRadius: BorderRadiusDirectional.horizontal(
            end: isLeading ? Radius.circular(AppSize.s12.r) : Radius.zero,
            start: isLeading ? Radius.zero : Radius.circular(AppSize.s12.r),
          ),
        ),
        child: CustomIcon(isLeading ? Icons.search : Icons.layers),
      ),
    );
  }
}
