import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/services/responsive_service.dart';
import 'package:ared/modules/home/view/widgets/home_top_map_properties.dart';
import 'package:flutter/material.dart';

import '../components/home_appbar.dart';
import '../components/home_map_2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeMap2(),
        const HomeAppbar(),
        Positioned(
          left: 0,
          right: 0,
          top: AppSize.s100.h + ResponsiveService.deviceTopPadding() + 20.h,
          child: HomeTopMapTaps(),
        ),
      ],
    );
  }
}
