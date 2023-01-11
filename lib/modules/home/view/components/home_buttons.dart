import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/widgets/spaces.dart';
import '../../../../modules/home/view/widgets/home_button.dart';

class HomeButtons extends StatelessWidget {
  final Function() changeMapStyle;
  final Function() switchMode;
  final Function() goToInteractiveMap;
  final bool viewModeIsMap;
  const HomeButtons({
    Key? key,
    required this.changeMapStyle,
    required this.switchMode,
    required this.viewModeIsMap,
    required this.goToInteractiveMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewModeIsMap) ...[
          VerticalSpace(AppSize.s16.h),
          HomeButton(onPressed: () {
            goToInteractiveMap();
          }, icon: Icons.design_services_rounded),

          VerticalSpace(AppSize.s16.h),
          HomeButton(onPressed: () => switchMode(), icon: Icons.list),
          VerticalSpace(AppSize.s16.h),
          HomeButton(
              onPressed: () {
                //TODO save this value for futures uses
                changeMapStyle();
              },
              icon: Icons.satellite_alt),
          VerticalSpace(AppSize.s16.h),
          HomeButton(onPressed: () {}, icon: Icons.my_location),
        ],
        if (!viewModeIsMap) ...[
          VerticalSpace(AppSize.s16.h),
          HomeButton(onPressed: () => switchMode(), icon: Icons.location_on),
        ]
      ],
    );
  }
}
