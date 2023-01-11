import '../../../extensions/num_extensions.dart';
import 'base_platfrom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../resources/resources.dart';

class LoadingSpinner extends BasePlatformWidget<Center, Center> {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Center createCupertinoWidget(BuildContext context) {
    return Center(child: CupertinoActivityIndicator(radius: AppSize.s24.r));
  }

  @override
  Center createMaterialWidget(BuildContext context) {
    return Center(
      child: SizedBox(
        height: AppSize.s24.r,
        width: AppSize.s24.r,
        child: CircularProgressIndicator(strokeWidth: AppSize.s3.w),
      ),
    );
  }
}
