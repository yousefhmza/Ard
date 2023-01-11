import 'dart:io';

import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/profile/models/response/profile_response.dart';
import 'package:ared/modules/subscription/provider/subscription_provider.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class TransferInfoScreen extends StatelessWidget {
  final Subscription subscription;
  const TransferInfoScreen({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final SubscriptionProvider provider = Provider.of<SubscriptionProvider>(context, listen: false);
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: AuthErrorWidget(
            action: () => () {
                  NavigationService.push(context, Routes.authScreen);
                }),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: const MainAppbar(title: AppStrings.transferInfo),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff7070708c)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  titleDesWidget('الاسم كاملا', 'الاسم كاملا'),
                  titleDesWidget('البنك', 'البنك'),
                  titleDesWidget('رقم الحساب', 'رقم الحساب'),
                  titleDesWidget('IBAN', 'IBAN'),
                  const Divider(),
                  Row(
                    children: const [
                      CustomText(
                        AppStrings.transferImage,
                        color: AppColors.blue,
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSize.s16,
                      ),
                    ],
                  ),
                  VerticalSpace(AppSize.s12.h),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 150,
                                color: Colors.red,
                                child: Container(
                                  color: Colors.white,
                                  height: 25.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            PickedFile? pickedFile = await (ImagePicker().getImage(source: ImageSource.camera, imageQuality: 25));

                                            if (pickedFile != null) {
                                              File file = File(pickedFile.path);
                                              provider.transferImage = file;
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.camera_alt, color: Colors.grey[500]),
                                                const SizedBox(width: 8),
                                                Expanded(child: CustomText(AppStrings.openCamera, color: Colors.grey[500])),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            PickedFile? pickedFile = await (ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 25));

                                            if (pickedFile != null) {
                                              File file = File(pickedFile.path);
                                              provider.transferImage = file;
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.image, color: Colors.grey[500]),
                                                const SizedBox(width: 8),
                                                Expanded(child: CustomText(AppStrings.selectPhoto, color: Colors.grey[500])),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomImage(
                            height: 80.w,
                            urlOrPath: '',
                            width: 80.w,
                            imageAsFile: null,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  titleDesWidget('تاريخ الاشتراك', '12/9/2022'),
                  titleDesWidget('نهاية الإشتراك', '3/10/2022'),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            VerticalSpace(AppSize.s16.h),
            CustomButton(
                text: AppStrings.save,
                onPressed: () {
                  NavigationService.goBack(context);
                  NavigationService.goBack(context);
                }),
          ],
        ),
      ),
    );
  }

  Widget titleDesWidget(String title, String desc) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomText(
              title,
              fontSize: 16,
              fontWeight: FontWeightManager.bold,
              color: const Color(0xff365D84),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomText(
              desc,
              fontSize: 16,
              color: const Color(0xff2b2b2b),
            ),
          ),
        ),
      ],
    );
  }
}
