import 'package:flutter/material.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../modules/home/view/widgets/home_appbar_action.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/services/responsive_service.dart';
import '../../../../core/view/widgets/custom_appbar.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s100.h + ResponsiveService.deviceTopPadding(),
      child: CustomAppbar(
        title: Image.asset(AppImages.logo, height: AppSize.s72.h),
        leading: const HomeAppbarAction(isLeading: true),
        actions: const [HomeAppbarAction(isLeading: false)],
      ),
    );
  }
}
