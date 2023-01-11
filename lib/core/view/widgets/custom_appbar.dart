import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/resources.dart';
import '../../extensions/num_extensions.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? bgColor;
  final Widget? flexibleSpace;
  final bool hasDarkStatusBar;
  final double toolbarHeight;

  const CustomAppbar({
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.bgColor = AppColors.white,
    this.elevation = AppSize.s4,
    this.flexibleSpace,
    this.centerTitle = true,
    this.hasDarkStatusBar = true,
    this.toolbarHeight = AppSize.s100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight.h,
      flexibleSpace: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (leading != null) leading!,
              const Spacer(),
              if (title != null) title!,
              const Spacer(),
              if (actions != null) ...?actions,
            ],
          ),
        ),
      ),
      bottom: bottom,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSize.s24.r))),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: hasDarkStatusBar ? Brightness.dark : Brightness.light,
        statusBarBrightness: hasDarkStatusBar ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight.h);
}
