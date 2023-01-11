import 'package:flutter/material.dart';

class CustomDialog extends Dialog {
  const CustomDialog({
    super.insetPadding,
    super.child,
    super.backgroundColor,
    super.elevation,
    super.alignment,
    super.clipBehavior,
    super.insetAnimationCurve,
    super.insetAnimationDuration,
    super.shape,
    Key? key,
  }) : super(key: key);
}
