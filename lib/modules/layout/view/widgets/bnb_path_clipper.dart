import 'package:flutter/material.dart';
import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';

class BNBPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double childHeight = size.height;
    final double childWidth = size.width;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(childWidth * 0.4 + 6, 0);
    path.arcToPoint(Offset(childWidth * 0.6 - 6, 0), radius: Radius.circular(AppSize.s24.r), clockwise: false);
    path.lineTo(childWidth, 0);
    path.lineTo(childWidth, childHeight);
    path.lineTo(0, childHeight);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => oldClipper != this;
}
