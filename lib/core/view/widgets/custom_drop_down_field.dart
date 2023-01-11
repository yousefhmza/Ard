import 'package:flutter/material.dart';

import '../../extensions/num_extensions.dart';
import '../../resources/resources.dart';

class CustomDropDownField<T> extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final T? value;
  final TextInputType? keyBoardType;
  final bool hasShadow;

  const CustomDropDownField({
    this.hintText = "",
    this.onChanged,
    this.items,
    this.prefix,
    this.suffix,
    this.validator,
    this.keyBoardType,
    this.value,
    this.hasShadow = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items,
      onChanged: onChanged,
      validator: validator,
      value: value,
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
