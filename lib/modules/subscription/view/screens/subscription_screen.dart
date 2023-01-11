import 'dart:io';

import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/subscription/provider/subscription_provider.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/custom_image.dart';
import 'package:ared/widgets/error_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final SubscriptionProvider provider = Provider.of<SubscriptionProvider>(context, listen: false);
      provider.getSubscriptionInfo();
    });
  }
  @override
  Widget build(BuildContext context) {
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
      appBar: MainAppbar(title: AppStrings.theSubscription),
      body: Consumer<SubscriptionProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (provider.failure != null) {
          return ErrorView(
            failure: provider.failure!,
            refresh: () => provider.getSubscriptionInfo(),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                child: CustomText(
                  "لإضافة اي من العروض يجب الاشتراك في \n الباقة السنوية بقيمة 5000 ريال سعودي",
                  color: Colors.redAccent,
                  fontSize: 18.sp,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff7070708C)),
                ),
                child: Column(
                  children: [
                    titleDesWidget('الاسم كاملا', provider.subscriptionInfo?.content ?? "N/A"),
                    titleDesWidget('البنك', provider.subscriptionInfo?.bankName ?? "N/A"),
                    titleDesWidget('رقم الحساب', provider.subscriptionInfo?.accountNumber ?? "N/A"),
                    titleDesWidget('IBAN', provider.subscriptionInfo?.iban ?? "N/A"),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  CustomText(
                    AppStrings.transferImage,
                    color: AppColors.blue,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s20,
                  ),
                ],
              ),
              VerticalSpace(AppSize.s12.h),
              Builder(builder: (context) {
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
                                SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      PickedFile? pickedFile = await (ImagePicker().getImage(source: ImageSource.camera, imageQuality: 25));

                                      if (pickedFile != null) {
                                        File file = File(pickedFile.path);
                                        provider.transferImage = file;
                                        provider.notifyListeners();
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.camera_alt, color: Colors.grey[500]),
                                          SizedBox(width: 8),
                                          Expanded(child: CustomText(AppStrings.openCamera, color: Colors.grey[500])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      PickedFile? pickedFile = await (ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 25));

                                      if (pickedFile != null) {
                                        File file = File(pickedFile.path);
                                        provider.transferImage = file;
                                        provider.notifyListeners();
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.image, color: Colors.grey[500]),
                                          SizedBox(width: 8),
                                          Expanded(child: CustomText(AppStrings.selectPhoto, color: Colors.grey[500])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
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
                    child: DottedBorder(
                      color: Colors.grey,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(6),
                      padding: EdgeInsets.all(12),
                      dashPattern: [8, 4],
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CustomImage(
                            height: 80.w,
                            urlOrPath: '',
                            width: 80.w,
                            imageAsFile: provider.transferImage,
                          ),
                        ),
                      )),
                    ),
                  ),
                );
              }),
              VerticalSpace(AppSize.s16.h),
              Consumer<SubscriptionProvider>(
                builder: (context, provider, child) => provider.isLoading
                    ? const LoadingSpinner()
                    : CustomButton(
                        text: AppStrings.send,
                        loading: provider.sendBandTransferImageLoading,
                        onPressed: () async {
                          bool status = await provider.sendSubscriptionImage();
                          if (!status) return;
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.p24.w),
                                backgroundColor: AppColors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(AppPadding.p16.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(AppSize.s8.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 8),
                                          Image.asset('assets/images/subscribe_success.png', height: 100, width: 100),
                                          SizedBox(height: 8),
                                          CustomText(
                                            AppStrings.thxMessageForSubscribtion,
                                            fontSize: FontSize.s18,
                                          ),
                                          SizedBox(height: 16),
                                          CustomButton(
                                              text: AppStrings.done,
                                              onPressed: () {
                                                NavigationService.goBack(context);
                                                NavigationService.goBack(context);
                                                NavigationService.goBack(context);
                                                NavigationService.push(context, Routes.transferInfoScreen);
                                              }),
                                        ],
                                      ),
                                    ),
                                    VerticalSpace(AppSize.s16.h),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
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
              fontSize: 16.sp,
              fontWeight: FontWeightManager.bold,
              color: Color(0xff365D84),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomText(
              desc,
              fontSize: 16.sp,
              color: Color(0xff2b2b2b),
            ),
          ),
        ),
      ],
    );
  }
}
