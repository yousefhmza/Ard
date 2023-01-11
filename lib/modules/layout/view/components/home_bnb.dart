import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:ared/widgets/dialog_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/widgets/custom_icon.dart';
import '../../../../core/view/widgets/spaces.dart';
import '../../../../modules/layout/view/widgets/bnb_icon.dart';
import '../../../../modules/layout/view/widgets/bnb_path_clipper.dart';

class HomeBNB extends StatelessWidget {
  final LayoutProvider layoutProvider;

  const HomeBNB(this.layoutProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:0),
      child: SizedBox(
        height: AppSize.s86.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: BNBPathClipper(),
                child: Container(
                  height: AppSize.s56.h,
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s6.w),
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                    ),
                    shape: StadiumBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const BNBIcon(index: 0, icon: Icons.home, label: AppStrings.home),
                      const BNBIcon(index: 1, icon: Icons.local_offer_rounded, label: AppStrings.offers),
                      const BNBIcon(index: 2, icon: Icons.note_add_sharp, label: AppStrings.requestLand),
                      HorizontalSpace(AppSize.s48.w),
                      const BNBIcon(index: -1, icon: Icons.location_city, label: AppStrings.bulk),
                      const BNBIcon(index: 4, icon: Icons.notifications_active, label: AppStrings.notifications),
                      const BNBIcon(index: 5, icon: Icons.more_horiz, label: AppStrings.more),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  if (currentUser == null) {
                    showDialog(context: context, builder: (BuildContext context) => const DialogAuth());
                  } else {
                    layoutProvider.setCurrentIndex(3);
                  }
                },
                child: Container(
                  width: AppSize. s48.w,
                  height: AppSize.s48.w,
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [
                      // BoxShadow(
                      //   offset: Offset(AppSize.s0, AppSize.s4.h),
                      //   blurRadius: AppSize.s4.r,
                      //   spreadRadius: AppSize.s1.r,
                      //   color: AppColors.grey,
                      // ),
                    ],
                  ),
                  child: const CustomIcon(Icons.add_rounded, size: AppSize.s32),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
