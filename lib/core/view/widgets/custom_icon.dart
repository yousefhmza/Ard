import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../extensions/num_extensions.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final bool faIcon;
  final Color? color;
  final double? size;

  const CustomIcon(
    this.icon, {
    this.faIcon = false,
    this.color,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(faIcon)
      return FaIcon(
        icon,
        color: color ?? Theme.of(context).iconTheme.color,
        size: size?.sp ?? Theme.of(context).iconTheme.size?.sp,
      );
    return Icon(
      icon,
      color: color ?? Theme.of(context).iconTheme.color,
      size: size?.sp ?? Theme.of(context).iconTheme.size?.sp,
    );
  }
}
