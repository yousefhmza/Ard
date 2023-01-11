import '../../extensions/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import '../app_views.dart';

class MainAppbar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MainAppbar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      toolbarHeight: AppSize.s86,
      title: CustomText(title, fontWeight: FontWeightManager.bold, fontSize: FontSize.s20, textAlign: TextAlign.center),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.s86.h);
}
