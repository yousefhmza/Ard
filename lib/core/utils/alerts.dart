import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../extensions/num_extensions.dart';
import '../resources/resources.dart';
import '../view/app_views.dart';

class Alerts {
  static Future<void> showLandInfoSheet(BuildContext context, {required Widget child}) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s24.r)),
      ),
      elevation: AppSize.s8.h,
      constraints: BoxConstraints(minHeight: deviceHeight * 0.5, maxHeight: deviceHeight * 0.65),
      builder: (BuildContext context) => child,
    );
  }

  static Future<T?> showAppDialog<T>(
    BuildContext context, {
    required String title,
    required VoidCallback onConfirm,
    required String confirmText,
    String? description,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        description: description,
        confirmText: confirmText,
        onConfirm: onConfirm,
      ),
    );
  }

  static void showToast(String message, [ToastGravity toastGravity = ToastGravity.BOTTOM]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s14.sp,
      textColor: AppColors.black,
      backgroundColor: AppColors.disabledGrey,
    );
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    bool forError = true,
    Duration duration = Time.t4000,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: forError ? AppColors.red : AppColors.primary,
        content: CustomText(message, color: AppColors.white, fontSize: FontSize.s14),
      ),
    );
  }

  static void showActionSnackBar(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Duration duration = Time.longTime,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: AppColors.snackBar,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppPadding.p16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8.r)),
        action: SnackBarAction(label: actionLabel, onPressed: onActionPressed, textColor: AppColors.white),
        content: CustomText(message, color: AppColors.white, fontSize: FontSize.s14),
      ),
    );
  }
}
