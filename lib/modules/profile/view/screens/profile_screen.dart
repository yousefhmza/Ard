import 'dart:io';

import 'package:ared/modules/profile/provider/profile_provider.dart';
import 'package:ared/modules/profile/view/screens/custom_input_text_title.dart';
import 'package:ared/widgets/custom_image.dart';
import 'package:ared/widgets/error_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider profileProvider;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightGrey,
        appBar: CustomAppbar(
          toolbarHeight: AppSize.s86,
          leading: const BackButton(),
          actions: [
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return Visibility(
                  visible: !profileProvider.isLoading && !profileProvider.isLoadingUpdate,
                  replacement: Container(width: 50),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.grey,
                        size: AppSize.s20,
                      ),
                      Switch(
                        onChanged: (value) {
                          profileProvider.switchEnableEditing(value);
                        },
                        value: profileProvider.enableEditing,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                );
              },
            )
          ],
          title: const CustomText(
            AppStrings.profile,
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s18,
            textAlign: TextAlign.center,
          ),
        ),
        body: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            if (profileProvider.isLoading || (profileProvider.failure == null && profileProvider.userData == null)) return const LoadingSpinner();

            if (profileProvider.failure != null) {
              return ErrorView(
                  failure: profileProvider.failure!,
                  refresh: () {
                    profileProvider.getProfile();
                  });
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(AppPadding.p16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* User image

                  CustomText(
                    AppStrings.advertiserImage,
                    color: AppColors.blue,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16,
                  ),
                  VerticalSpace(AppSize.s8.h),
                  GestureDetector(
                    onTap: () {
                      profileProvider.pickImage(context);
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
                        child: Center(child: UserImage(profileProvider.userData?.image ?? "", profileProvider.userData?.imageAsFile)),
                      ),
                    ),
                  ),
                  VerticalSpace(AppSize.s16.h),
                  //* User Name
                  CustomInputTextWithTitle(
                    initValue: profileProvider.userData!.name,
                    enableEditing: profileProvider.enableEditing,
                    title: AppStrings.fullName,
                    onChange: (val) {
                      profileProvider.userData!.name = val;
                    },
                  ),
                  VerticalSpace(AppSize.s16.h),
                  //*Phone
                  CustomInputTextWithTitle(
                    initValue: profileProvider.userData!.mobileNumber,
                    enableEditing: profileProvider.enableEditing,
                    title: AppStrings.phoneNumber,
                    textInputType: TextInputType.phone,
                    onChange: (val) {
                      profileProvider.userData!.mobileNumber = val;
                    },
                  ),
                  VerticalSpace(AppSize.s16.h),

                  //*Email
                  CustomInputTextWithTitle(
                    initValue: profileProvider.userData!.email,
                    enableEditing: profileProvider.enableEditing,
                    title: AppStrings.email,
                    textInputType: TextInputType.emailAddress,
                    onChange: (val) {
                      profileProvider.userData!.email = val;
                    },
                  ),
                  VerticalSpace(AppSize.s16.h),

                  //*More info
                  CustomInputTextWithTitle(
                    initValue: profileProvider.userData!.moreInfo,
                    enableEditing: profileProvider.enableEditing,
                    title: AppStrings.extraInfo,
                    textInputType: TextInputType.text,
                    onChange: (val) {
                      profileProvider.userData!.moreInfo = val;
                    },
                  ),
                  VerticalSpace(AppSize.s16.h),
                  //*Dicumentation type
                  const CustomText(
                    AppStrings.docType,
                    color: AppColors.blue,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16,
                  ),
                  VerticalSpace(AppSize.s8.h),
                  CustomDropDownField<String>(
                    hintText: AppStrings.natId,
                    value: AppStrings.natId,
                    onChanged: (val) {
                      profileProvider.userData!.idType = val!;
                    },
                    items: const [
                      DropdownMenuItem<String>(value: AppStrings.natId, child: CustomText(AppStrings.natId)),
                    ],
                  ),
                  VerticalSpace(AppSize.s16.h),

                  //*Nationality number
                  CustomInputTextWithTitle(
                    initValue: profileProvider.userData!.idNumber,
                    enableEditing: profileProvider.enableEditing,
                    title: AppStrings.natIdNumber,
                    textInputType: TextInputType.text,
                    onChange: (val) {
                      profileProvider.userData!.idNumber = val;
                    },
                  ),
                  VerticalSpace(AppSize.s16.h),
                  //*License number
                  CustomInputTextWithTitle(
                    initValue: profileProvider.userData!.licenseNumber,
                    enableEditing: profileProvider.enableEditing,
                    title: AppStrings.licenceNumber,
                    textInputType: TextInputType.text,
                    onChange: (val) {
                      profileProvider.userData!.licenseNumber = val;
                    },
                  ),
                  VerticalSpace(AppSize.s16.h),
                  if (profileProvider.enableEditing)
                    Consumer<ProfileProvider>(
                      builder: (context, providerData, child) => providerData.isLoadingUpdate
                          ? const LoadingSpinner()
                          : CustomButton(
                              text: AppStrings.save,
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                await profileProvider.updateProfile(context);
                              },
                            ),
                    ),
                  VerticalSpace(AppSize.s16.h),
                ],
              ),
            );
          },
        ));
  }
}

class UserImage extends StatelessWidget {
  final String imageUrl;
  final File? imageAsFile;
  const UserImage(this.imageUrl, this.imageAsFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CustomImage(
          height: 80.w,
          urlOrPath: imageUrl,
          width: 80.w,
          imageAsFile: imageAsFile,
        ),
      ),
    );
  }
}
