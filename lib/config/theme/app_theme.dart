import '../../core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../core/resources/resources.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,

    // Appbar
    appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: AppColors.black)),

    // Text
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontFamily: FontConstants.arabicFontFamily, color: AppColors.black),
    ),

    // Icons
    iconTheme: const IconThemeData(color: AppColors.white, size: AppSize.s24),

    // Progress indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primary),

    // Text field
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      hintStyle: TextStyle(
        color: AppColors.grey,
        fontSize: FontSize.s14.sp,
        fontFamily: FontConstants.arabicFontFamily,
      ),
      contentPadding: EdgeInsets.all(AppPadding.p12.w),
      errorStyle: TextStyle(fontSize: FontSize.s12.sp, fontFamily: FontConstants.arabicFontFamily),
      errorMaxLines: 2,
      border: InputBorder.none,
      disabledBorder: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: AppSize.s1.w, color: AppColors.grey),
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: AppSize.s1.w, color: AppColors.red),
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: AppSize.s1.w, color: AppColors.grey),
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: AppSize.s1.w, color: AppColors.grey),
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
    ),
  );
}
