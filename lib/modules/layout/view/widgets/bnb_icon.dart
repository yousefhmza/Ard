import 'package:ared/core/view/app_views.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';

class BNBIcon extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;

  const BNBIcon({required this.index, required this.icon, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LayoutProvider layoutCubit = Provider.of<LayoutProvider>(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => layoutCubit.setCurrentIndex(index),
        child: AnimatedContainer(
          duration: Time.t300,
          curve: Curves.easeInOut,
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   color: index == layoutCubit.currentScreenIndex ? AppColors.white : AppColors.transparent,
          // ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                index == layoutCubit.currentScreenIndex
                    ? CustomIcon(icon, color: Color(0xffF26060), size: 20.h)
                    : CustomIcon(
                        icon,
                        size: 16.h,
                      ),
                CustomText(
                  label,
                  color: index == layoutCubit.currentScreenIndex ? Color(0xffF26060) : AppColors.white,
                  fontSize: 10,
                ),
              ],
            ),
          ),
        ),
        // child: AnimatedContainer(
        //   duration: Time.t300,
        //   curve: Curves.easeInOut,
        //   padding: EdgeInsets.symmetric(horizontal: AppSize.s4.w),
        //   decoration: ShapeDecoration(
        //     shape: const StadiumBorder(),
        //     color: index == layoutCubit.currentScreenIndex ? AppColors.white : AppColors.transparent,
        //   ),
        //   child: index == layoutCubit.currentScreenIndex
        //       ? Row(
        //           children: [
        //             CustomIcon(icon, color: AppColors.pink),
        //             Expanded(child: FittedBox(child: CustomText(label, color: AppColors.pink))),
        //           ],
        //         )
        //       : CustomIcon(icon),
        // ),
      ),
    );
  }
}
