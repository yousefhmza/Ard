import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/app_colors.dart';
import 'package:ared/core/resources/font_manager.dart';
import 'package:ared/core/resources/values_manager.dart';
import 'package:ared/core/view/widgets/custom_text.dart';
import 'package:ared/core/view/widgets/custom_text_field.dart';
import 'package:ared/core/view/widgets/spaces.dart';
import 'package:flutter/material.dart';

class CustomInputTextWithTitle extends StatelessWidget {
  final String title;
  final String initValue;
  final Function(String val) onChange;
  final TextInputType textInputType;
  final bool enableEditing;
  const CustomInputTextWithTitle({
    super.key,
    required this.initValue,
    required this.title,
    required this.onChange,
    this.enableEditing = true,
    this.textInputType = TextInputType.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          color: AppColors.blue,
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s16,
        ),
        VerticalSpace(AppSize.s8.h),
        CustomTextField(
          hintText: title,
          initialValue: initValue,
          readOnly: !enableEditing,
          keyBoardType: textInputType,
          onChanged: onChange,
          prefix: textInputType != TextInputType.phone
              ? null
              : SizedBox(
                  width: AppSize.s72.w,
                  child: Row(
                    children: const [
                      CustomText("🇸🇦", fontSize: FontSize.s20),
                      CustomText(" 966+ |"),
                    ],
                  ),
                ),
        ),
        VerticalSpace(AppSize.s12.h),
      ],
    );
  }
}
