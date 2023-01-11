import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/resources.dart';

class StatusBar extends StatelessWidget {
  final Scaffold child;
  final bool isLight;

  const StatusBar({required this.child, this.isLight = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: isLight ? Brightness.light : Brightness.dark,
        statusBarBrightness: isLight ? Brightness.dark : Brightness.light,
      ),
      child: child,
    );
  }
}
