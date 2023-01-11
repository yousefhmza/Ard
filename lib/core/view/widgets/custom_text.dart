import 'package:flutter/material.dart';

import '../../extensions/num_extensions.dart';
import '../../resources/resources.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? height;
  final int? maxLines;
  final TextDecoration? decoration;

  const CustomText(
    this.text, {
    this.color,
    this.fontSize = FontSize.s14,
    this.fontWeight = FontWeightManager.regular,
    this.textAlign,
    this.height,
    this.overflow,
    this.maxLines,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: fontSize.sp,
        fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
        fontWeight: fontWeight,
        height: height?.h,
        decoration: decoration,
      ),
    );
  }
}
