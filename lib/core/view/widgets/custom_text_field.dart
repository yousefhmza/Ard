import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extensions/num_extensions.dart';
import '../../resources/resources.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;

  const CustomTextField({
    this.hintText = "",
    this.prefix,
    this.suffix,
    this.validator,
    this.readOnly = false,
    this.obscureText = false,
    this.keyBoardType,
    this.controller,
    this.formatters,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.maxLines,
    this.minLines,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      obscureText: obscureText,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      inputFormatters: formatters,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      initialValue: initialValue,
      keyboardType: keyBoardType,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontFamily: FontConstants.englishFontFamily,
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeightManager.regular,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefix != null ? Padding(padding: EdgeInsets.all(AppPadding.p8.w), child: prefix) : null,
        prefixIconConstraints: const BoxConstraints(minWidth: AppSize.s0, minHeight: AppSize.s0),
        suffixIcon: suffix != null ? Padding(padding: EdgeInsets.all(AppPadding.p8.w), child: suffix) : null,
        suffixIconConstraints: const BoxConstraints(minWidth: AppSize.s0, minHeight: AppSize.s0),
      ),
    );
  }
}
