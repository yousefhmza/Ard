import 'package:flutter/material.dart';

import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/modules/more/models/option_model.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class MoreItem extends StatelessWidget {
  final Option option;

  const MoreItem(this.option, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
      child: ListTile(
        onTap: option.onTap,
        tileColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        // leading: Container(
        //   width: AppSize.s40.w,
        //   height: AppSize.s40.w,
        //   decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
        //   child: CustomIcon(option.icon, color: AppColors.white),
        // ),
        trailing: option.title == AppStrings.logout ? CustomIcon(Icons.logout, color: AppColors.red) : null,
        title: CustomText(
          option.title,
          fontWeight: FontWeightManager.bold,
          color: AppColors.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}
