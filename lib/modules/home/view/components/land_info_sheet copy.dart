// import 'package:ared/config/routing/navigation_services.dart';
// import 'package:ared/config/routing/routes.dart';
// import 'package:ared/core/extensions/num_extensions.dart';
// import 'package:ared/core/resources/resources.dart';
// import 'package:ared/core/view/widgets/custom_button.dart';
// import 'package:ared/core/view/widgets/custom_icon.dart';
// import 'package:ared/core/view/widgets/custom_text.dart';
// import 'package:ared/core/view/widgets/spaces.dart';
// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
//
// class LandInfoSheet extends StatelessWidget {
//   final LatLng? latLng;
//   const LandInfoSheet({Key? key, required this.latLng}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         VerticalSpace(AppSize.s16.h),
//         Container(
//           width: AppSize.s100.w,
//           height: AppSize.s4.h,
//           decoration: ShapeDecoration(shape: const StadiumBorder(), color: AppColors.grey.withOpacity(0.5)),
//         ),
//         VerticalSpace(AppSize.s16.h),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 VerticalSpace(AppSize.s16.h),
//                 SizedBox(
//                   height: deviceHeight * 0.25,
//                   child: Stack(
//                     children: [
//                       const Align(
//                         alignment: Alignment.topCenter,
//                         child: _BottomStackContainer(
//                           color: AppColors.primary,
//                           title: "الحمراء",
//                           titleColor: AppColors.white,
//                           subtitle: "الحمراء- الروضة",
//                           subtitleColor: AppColors.white,
//                           trailingText: "320${AppStrings.meterSquare}",
//                           trailingColor: AppColors.white,
//                           trailingTextColor: AppColors.pink,
//                           trailingIcon: Icons.fullscreen,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: const [
//                             _InfoCard(title: "رقم المخطط", value: "15698"),
//                             _InfoCard(title: "رقم القطعة", value: "546"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 VerticalSpace(AppSize.s32.h),
//                 SizedBox(
//                   height: deviceHeight * 0.25,
//                   child: Stack(
//                     children: [
//                       const Align(
//                         alignment: Alignment.topCenter,
//                         child: _BottomStackContainer(
//                           color: AppColors.lightGrey,
//                           title: "نوع القطعة",
//                           titleColor: AppColors.black,
//                           subtitle: "سكنى (فلل)",
//                           subtitleColor: AppColors.pink,
//                           trailingText: "تقرير الارض",
//                           trailingColor: AppColors.primary,
//                           trailingTextColor: AppColors.white,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: SizedBox(
//                           height: AppSize.s100.w,
//                           width: deviceWidth * 0.9,
//                           child: Card(
//                             elevation: AppSize.s4.h,
//                             color: AppColors.white,
//                             margin: EdgeInsets.zero,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(AppSize.s16.r),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
//                               child: Row(
//                                 children: [
//                                   Image.asset(AppImages.money, height: AppSize.s72.h),
//                                   HorizontalSpace(AppSize.s16.w),
//                                   const CustomText(
//                                     "السعر",
//                                     fontWeight: FontWeightManager.bold,
//                                     fontSize: FontSize.s16,
//                                   ),
//                                   const Spacer(),
//                                   const CustomText(
//                                     "32.000 ر.س",
//                                     fontWeight: FontWeightManager.bold,
//                                     color: AppColors.pink,
//                                     fontSize: FontSize.s16,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 VerticalSpace(AppSize.s24.h),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
//                   child: Row(
//                     children: [
//                       const CustomText("تواصل مع المعلن", fontSize: FontSize.s16, fontWeight: FontWeightManager.bold),
//                       const Spacer(),
//                       const CustomIcon(Icons.phone, size: AppSize.s40, color: AppColors.primary),
//                       HorizontalSpace(AppSize.s16.w),
//                       const CustomIcon(Icons.whatsapp, size: AppSize.s40, color: Colors.green),
//                     ],
//                   ),
//                 ),
//                 VerticalSpace(AppSize.s24.h),
//                 Container(
//                   height: deviceHeight * 0.15,
//                   color: AppColors.lightGrey,
//                   width: double.infinity,
//                   padding: EdgeInsets.all(AppPadding.p16.w),
//                   child: Card(
//                     elevation: AppSize.s4.h,
//                     color: AppColors.white,
//                     margin: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s16.r)),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Expanded(
//                           child: _SpecialAction(image: AppImages.star, text: "إضافة للمفضلة"),
//                         ),
//                         Expanded(
//                           child: _SpecialAction(image: AppImages.location, text: "فتح على الخرائط"),
//                         ),
//                         Expanded(
//                           child: _SpecialAction(image: AppImages.share, text: "مشاركة"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 VerticalSpace(AppSize.s24.h),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ListTile(
//                         leading: CustomIcon(Icons.calendar_today_outlined, color: AppColors.black, size: AppSize.s32),
//                         title: CustomText("تاريخ النشر", fontSize: FontSize.s14, fontWeight: FontWeightManager.bold),
//                         subtitle: CustomText(
//                           "11/8/2022",
//                           fontSize: FontSize.s12,
//                           fontWeight: FontWeightManager.bold,
//                           color: AppColors.pink,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         leading: CustomIcon(Icons.remove_red_eye_outlined, color: AppColors.black, size: AppSize.s32),
//                         title: CustomText("عدد المشاهدات", fontSize: FontSize.s14, fontWeight: FontWeightManager.bold),
//                         subtitle: CustomText(
//                           "117",
//                           fontSize: FontSize.s12,
//                           fontWeight: FontWeightManager.bold,
//                           color: AppColors.pink,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 VerticalSpace(AppSize.s24.h),
//                 InkWell(
//                   onTap: () => NavigationService.push(context, Routes.commentsScreen),
//                   child: Container(
//                     color: AppColors.lightGrey,
//                     width: double.infinity,
//                     height: AppSize.s48.h,
//                     padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const CustomIcon(Icons.messenger_outline, color: AppColors.primary),
//                         HorizontalSpace(AppSize.s8.w),
//                         const CustomText(
//                           "عدد التعليقات",
//                           color: AppColors.primary,
//                           fontSize: FontSize.s16,
//                           fontWeight: FontWeightManager.bold,
//                         ),
//                         const Spacer(),
//                         const CustomIcon(Icons.arrow_forward_ios, color: AppColors.primary, size: FontSize.s16),
//                       ],
//                     ),
//                   ),
//                 ),
//                 VerticalSpace(AppSize.s8.h),
//                 const ListTile(
//                   horizontalTitleGap: AppSize.s0,
//                   leading: CustomIcon(Icons.report_problem, color: AppColors.red),
//                   title: CustomText("ابلاغ عن الاعلان", color: AppColors.red, fontWeight: FontWeightManager.bold),
//                 ),
//                 VerticalSpace(AppSize.s8.h),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
//                   child: CustomButton(
//                     text: "انشاء عرض",
//                     onPressed: () {},
//                   ),
//                 ),
//                 VerticalSpace(AppSize.s16.h),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _BottomStackContainer extends StatelessWidget {
//   final Color color;
//   final String title;
//   final Color titleColor;
//   final String subtitle;
//   final Color subtitleColor;
//   final String trailingText;
//   final Color trailingTextColor;
//   final IconData? trailingIcon;
//   final Color trailingColor;
//
//   const _BottomStackContainer({
//     required this.color,
//     required this.title,
//     required this.titleColor,
//     required this.subtitle,
//     required this.subtitleColor,
//     required this.trailingText,
//     required this.trailingTextColor,
//     this.trailingIcon,
//     required this.trailingColor,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: deviceHeight * 0.15,
//       color: color,
//       child: ListTile(
//         title: CustomText(title, color: titleColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s18),
//         subtitle: CustomText(
//           subtitle,
//           color: subtitleColor,
//           fontWeight: FontWeightManager.semiBold,
//           fontSize: FontSize.s16,
//         ),
//         trailing: Container(
//           width: AppSize.s100.w,
//           height: AppSize.s48,
//           decoration: BoxDecoration(
//             color: trailingColor,
//             borderRadius: BorderRadius.circular(AppSize.s8.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomText(trailingText, fontSize: FontSize.s16, color: trailingTextColor),
//               if (trailingIcon != null) HorizontalSpace(AppSize.s4.w),
//               if (trailingIcon != null) CustomIcon(trailingIcon!, color: trailingTextColor, size: AppSize.s32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _InfoCard extends StatelessWidget {
//   final String title;
//   final String value;
//
//   const _InfoCard({required this.title, required this.value, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: AppSize.s100.w,
//       width: deviceWidth * 0.35,
//       child: Card(
//         elevation: AppSize.s4.h,
//         color: AppColors.white,
//         margin: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppSize.s16.r),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomText(value, fontSize: FontSize.s16, color: AppColors.pink, fontWeight: FontWeightManager.bold),
//             CustomText(title, fontSize: FontSize.s16),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _SpecialAction extends StatelessWidget {
//   final String image;
//   final String text;
//
//   const _SpecialAction({required this.image, required this.text, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(image, height: AppSize.s32.h),
//         VerticalSpace(AppSize.s4.h),
//         CustomText(text, fontWeight: FontWeightManager.bold, fontSize: FontSize.s12),
//       ],
//     );
//   }
// }
