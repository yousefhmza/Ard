import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  final Color? textColor;

  const CustomTextButton({
    this.onPressed,
    required this.text,
    this.textColor,
    this.fontWeight = FontWeightManager.medium,
    this.textSize = FontSize.s14,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text,
        color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: textSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
