import 'package:flutter/material.dart';

import '../../extensions/num_extensions.dart';
import '../../resources/resources.dart';
import 'custom_text.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;
  final Color backgroundColor ;
  final Color borderColor ;

  const CustomChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
     this.backgroundColor = AppColors.white,
     this.borderColor = AppColors.grey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: Time.t300,
        padding: EdgeInsets.symmetric(vertical: AppPadding.p4.w, horizontal: AppPadding.p24.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pink :backgroundColor,
          borderRadius: BorderRadius.circular(AppSize.s8.r),
          border: Border.all(color: isSelected ? AppColors.pink :borderColor, width: AppSize.s1_2.w),
        ),
        child: CustomText(
          label,
          fontWeight: isSelected ? FontWeightManager.bold : FontWeightManager.semiBold,
          color: isSelected ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}
