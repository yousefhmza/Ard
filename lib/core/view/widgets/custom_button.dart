import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final bool loading;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    this.onPressed,
    this.text,
    this.child,
    this.width = double.infinity,
    this.height,
    this.loading = false,
    this.color,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8.r),
            color: onPressed == null ? AppColors.disabledGrey : color,
            gradient: onPressed != null && color == null
                ? const LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primary],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )
                : null,
          ),
          child: InkWell(
            onTap: () {
              if (loading) return;
              if (onPressed != null) onPressed!();
            },
            borderRadius: BorderRadius.circular(AppSize.s8.r),
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p8.w),
              child: Center(
                child: loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      )
                    : text != null
                        ? CustomText(text!, color: textColor ?? AppColors.white, fontWeight: FontWeightManager.bold)
                        : child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
