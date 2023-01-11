// ignore_for_file: unused_element

import 'dart:io';

import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/di_container.dart';
import 'package:ared/modules/home/provider/realestate_provider.dart';
import 'package:ared/modules/home/view/components/map_interactive.dart';
import 'package:ared/widgets/dialog_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LandInfoSheet extends StatelessWidget {
  final LatLng latLng;
  final double zoom;
  final bool canViewAllLandDetails;

  const LandInfoSheet({
    Key? key,
    required this.latLng,
    required this.canViewAllLandDetails,
    required this.zoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RealestateProvider realestateProvider = Provider.of<RealestateProvider>(context, listen: false);
    bool loadingLandReport = false;
    bool loadingSendRealestateApprisal = false;
    return SingleChildScrollView(
      child: Column(
        children: [
          VerticalSpace(AppSize.s16.h),
          Container(
            width: AppSize.s100.w,
            height: AppSize.s4.h,
            decoration: ShapeDecoration(shape: const StadiumBorder(), color: AppColors.grey.withOpacity(0.5)),
          ),
          VerticalSpace(AppSize.s16.h),
          //* Logo
          Row(
            children: [
              Spacer(),
              Image.asset(AppImages.logo, width: 60, height: 60),
              SizedBox(width: 8),
              CustomText(AppStrings.landInfo, fontSize: FontSize.s18, fontWeight: FontWeight.bold),
              SizedBox(width: 8),
              Spacer(),
            ],
          ),
          SizedBox(height: 12),
          //*Header Title & rate
          Container(
            color: AppColors.accent,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                SizedBox(width: 8),
                const Expanded(
                    child: CustomText(
                  'الحمراء الروضة',
                  color: Colors.white,
                  fontSize: FontSize.s18,
                  fontWeight: FontWeight.bold,
                )),
                Icon(Icons.star, color: Colors.yellow[600]),
                const SizedBox(width: 4),
                const CustomText(
                  '4.5',
                  color: Colors.white,
                  fontSize: FontSize.s16,
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          //*Body Area size ,number,land ...
          Column(
            children: [
              const SizedBox(height: 12),
              const SingleDescItem(name: AppStrings.area, value: "1231.175 ${AppStrings.meterSquare}"),
              const SingleDescItem(name: AppStrings.planNumber, value: "15698"),
              const SingleDescItem(name: AppStrings.landNumber, value: "458"),
              const SingleDescItem(name: AppStrings.landType, value: "سكنى (فلل)"),
              const SizedBox(height: 12),
            ],
          ),

          //*Area properties
          Column(
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _DetailsRow(image: AppImages.key, title: "ايجار"),
                    _DetailsRow(image: AppImages.road, title: "6 متر"),
                    _DetailsRow(image: AppImages.spot, title: "شرق"),
                    _DetailsRow(image: AppImages.building, title: "تجاري"),
                  ],
                ),
              ),
            ],
          ),

          //* Owner info and price
          if (canViewAllLandDetails) ...[
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Divider(color: Colors.grey[500]!)),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  circularAvatar(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: const [
                        CustomText(' محمد طارق ', color: Colors.black, fontSize: FontSize.s16, fontWeight: FontWeight.bold),
                        CustomText('  ( وكيل )  ', color: Colors.red, fontSize: FontSize.s16),
                      ],
                    ),
                  ),
                  contactWidget(false),
                  const SizedBox(width: 12),
                  contactWidget(true),
                ],
              ),
            ),
            const SingleDescItem(name: AppStrings.landPrice, value: "32,000 ر.س", icon: FontAwesomeIcons.moneyBillWave),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),

            //*Advertiser Info
            Column(
              children: [
                SizedBox(height: 12),
                SingleDescItem(
                  name: AppStrings.licenceNumber,
                  value: currentUser?.licenseNumber ?? '',
                  valueColor: Colors.black,
                  nameColor: AppColors.accent,
                ),
                GestureDetector(
                  onTap: () {
                    if (currentUser?.mobileNumber != null) launchUrl(Uri(scheme: 'tel', path: currentUser?.mobileNumber ?? ''));
                  },
                  child: SingleDescItem(
                    name: AppStrings.phoneNumber,
                    value: currentUser?.mobileNumber ?? '',
                    valueColor: Colors.black,
                    nameColor: AppColors.accent,
                  ),
                ),
                SingleDescItem(
                  name: AppStrings.publishDate,
                  value: "11/08/2022",
                  valueColor: Colors.black,
                  nameColor: AppColors.accent,
                ),
                SizedBox(height: 12),
              ],
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),

            //*Actions Add to favorite ,open on google map And share
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    flex: 3,
                    child: _SpecialAction(image: AppImages.star, text: "إضافة للمفضلة", isVertical: false),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                        onTap: () async {
                          String googleUrl = 'https://www.google.com/maps/search/?api=1&query=21.585,39.230';
                          if (await canLaunchUrl(Uri.parse(googleUrl))) {
                            await launchUrl(Uri.parse(googleUrl));
                          } else {
                            Alerts.showToast('تعذر الفتح علي خرائط جوجل');
                          }
                        },
                        child: const _SpecialAction(image: AppImages.location, text: "فتح على الخرائط", isVertical: false)),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                        onTap: () {
                          Share.share('رقم القطع ٣٣ \n رقم المخطط ٢٨١٣٨٥ \n السعر ٣,٩٨٠ \n المساحة ١٢٣١.١٧٥ متر مربع');
                        },
                        child: const _SpecialAction(image: AppImages.share, text: "مشاركة", isVertical: false)),
                  ),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),

            //*Date & Views & Comments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    flex: 2,
                    child: _SpecialAction(
                      icon: Icons.remove_red_eye,
                      textSize: 18,
                      text: "125",
                      isVertical: false,
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: _SpecialAction(
                      icon: Icons.calendar_month,
                      text: "11/08/2022",
                      textSize: 18,
                      isVertical: false,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                        onTap: () => NavigationService.push(context, Routes.commentsScreen, arguments: {'id': 1}),
                        child: const _SpecialAction(
                          icon: Icons.comment,
                          trailingIcon: Icons.arrow_forward_ios,
                          textSize: 18,
                          text: "250",
                          isVertical: false,
                        )),
                  ),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0), child: Divider(color: Colors.grey[500]!)),

            //* Actions report & rate my land
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(child: StatefulBuilder(builder: (context, setState) {
                    return CustomButton(
                      color: AppColors.primary,
                      child: loadingLandReport
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const CustomText(
                              AppStrings.landFile,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      onPressed: () async {
                        if (loadingLandReport) return;
                        loadingLandReport = true;
                        setState(() {});
                        try {
                          await sl<Dio>().download(
                            "https://firebasestorage.googleapis.com/v0/b/e-commerce-poc-fa0c8.appspot.com/o/Ared_report.pdf?alt=media&token=50120029-5fc2-4cf3-812e-5393534c3177",
                            File(await getDownloadPath()).path,
                            onReceiveProgress: (value, total) async {
                              print(value / total * 100);
                              print(total);
                              if (value == total) {
                                Alerts.showToast("تم التحميل");
                                OpenFile.open(File(await getDownloadPath()).path);
                              }
                            },
                          );
                        } catch (e) {}
                        loadingLandReport = false;
                        setState(() {});
                      },
                    );
                  })),
                  const SizedBox(width: 8),
                  Expanded(child: StatefulBuilder(builder: (context, setState) {
                    return CustomButton(
                      color: AppColors.red,
                      child: loadingSendRealestateApprisal
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const CustomText(
                              AppStrings.requestRateMyLand,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      onPressed: () async {
                        if (loadingSendRealestateApprisal) return;
                        loadingSendRealestateApprisal = true;
                        setState(() {});
                        await realestateProvider.sendRequest();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                                insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.p24.w),
                                backgroundColor: AppColors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 32),
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey[200]!, width: 12),
                                            borderRadius: BorderRadius.circular(64),
                                          ),
                                          child: const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.green,
                                            size: 60,
                                          )),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                        child: CustomText(
                                          AppStrings.successSendRateMyLand,
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      CustomButton(
                                        width: MediaQuery.of(context).size.width / 3,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: AppStrings.done,
                                      ),
                                      const SizedBox(height: 32),
                                    ],
                                  ),
                                ));
                          },
                        );
                        loadingSendRealestateApprisal = false;
                        setState(() {});
                      },
                    );
                  })),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),

            SizedBox(height: 8),
            //* Calculate Area size
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InteractiveMap(interactiveMapParams: InteractiveMapParams(latLng: latLng, zoom: zoom))),
                );
              },
              child: Row(
                children: [
                  SizedBox(width: 24),
                  CustomIcon(FontAwesomeIcons.penRuler, color: AppColors.red, faIcon: true),
                  SizedBox(width: 12),
                  CustomText("قياس المسافات", color: AppColors.black, fontWeight: FontWeightManager.bold),
                  SizedBox(width: 12),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0), child: Divider(color: Colors.grey[500]!)),
          ],
          //* report
          GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String name = '';
                    String email = '';
                    String comment = '';
                    return CustomDialog(
                      backgroundColor: AppColors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                CustomText(AppStrings.reportAds),
                                SizedBox(height: 8),
                                //*Name
                                CustomTextField(
                                  initialValue: name,
                                  hintText: AppStrings.name,
                                  keyBoardType: TextInputType.name,
                                  onChanged: (val) {
                                    name = val;
                                  },
                                ),
                                VerticalSpace(AppSize.s16.h),

                                //*Email
                                CustomTextField(
                                  initialValue: email,
                                  hintText: AppStrings.email,
                                  keyBoardType: TextInputType.emailAddress,
                                  onChanged: (val) {
                                    email = val;
                                  },
                                ),
                                VerticalSpace(AppSize.s16.h),

                                //*Note
                                CustomTextField(
                                  initialValue: comment,
                                  hintText: AppStrings.comment,
                                  keyBoardType: TextInputType.text,
                                  onChanged: (val) {
                                    comment = val;
                                  },
                                ),
                                VerticalSpace(AppSize.s16.h),

                                SizedBox(height: 12),
                                CustomButton(
                                  width: MediaQuery.of(context).size.width / 3,
                                  onPressed: () async {
                                    if (currentUser == null) {
                                      showDialog(context: context, builder: (BuildContext context) => const DialogAuth());
                                    } else {
                                      await realestateProvider.sendReport(
                                        comment: comment,
                                        email: email,
                                        name: name,
                                      );
                                      NavigationService.goBack(context);
                                      Alerts.showToast(AppStrings.sendSuccessfully);
                                    }
                                  },
                                  text: AppStrings.send,
                                ),

                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  SizedBox(width: 24),
                  CustomIcon(Icons.report_problem, color: AppColors.red),
                  SizedBox(width: 12),
                  CustomText(AppStrings.reportAds, color: AppColors.red, fontWeight: FontWeightManager.bold),
                  SizedBox(width: 12),
                ],
              )),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<String> getDownloadPath() async {
    final List<Directory>? directories = await getExternalStorageDirectories(type: StorageDirectory.documents);
    return "${directories![0].path}/Andalus.pdf";
  }

  Widget circularAvatar() {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60), boxShadow: [
        BoxShadow(
          color: Colors.grey[300]!,
          offset: const Offset(0, 0),
          spreadRadius: 2,
          blurRadius: 4,
        )
      ]),
      padding: const EdgeInsets.all(4),
      child: const Icon(Icons.person, color: Colors.grey, size: 26),
    );
  }

  Widget contactWidget(bool isWhatsapp) {
    late Widget contactIcon;
    if (isWhatsapp) contactIcon = const CustomIcon(Icons.whatsapp, size: 26, color: Colors.white);
    if (!isWhatsapp) contactIcon = const CustomIcon(Icons.phone, size: 26, color: AppColors.white);
    return GestureDetector(
      onTap: () {
        if (isWhatsapp) {
          openWhatsApp('966570666690');
        } else {
          launchUrlString('tel:966115103315');
        }
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: isWhatsapp ? Colors.green : AppColors.primary, borderRadius: BorderRadius.circular(60), boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: const Offset(1, 1),
            spreadRadius: 2,
            blurRadius: 4,
          )
        ]),
        padding: const EdgeInsets.all(4),
        child: contactIcon,
      ),
    );
  }
}

class SingleDescItem extends StatelessWidget {
  final String name;
  final String value;
  final IconData? icon;
  final IconData? faIcon;
  final Color valueColor;
  final bool valueBold;
  final Color? nameColor;
  const SingleDescItem({
    Key? key,
    required this.name,
    required this.value,
    this.valueBold = false,
    this.nameColor,
    this.valueColor = AppColors.accent,
    this.icon,
    this.faIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      child: Row(
        children: [
          if (icon != null) Icon(icon!, color: Colors.redAccent),
          if (faIcon != null) FaIcon(faIcon, color: Colors.redAccent),
          if (icon != null || faIcon != null) SizedBox(width: 8),
          Expanded(
              child: CustomText(
            name,
            color: nameColor ?? Colors.black,
            fontSize: FontSize.s16,
            fontWeight: FontWeight.bold,
          )),
          CustomText(
            value,
            color: valueColor,
            fontSize: FontSize.s16,
            fontWeight: valueBold ? FontWeight.bold : FontWeight.normal,
          ),
        ],
      ),
    );
  }
}

class _BottomStackContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Color titleColor;
  final String subtitle;
  final Color subtitleColor;
  final String trailingText;
  final Color trailingTextColor;
  final IconData? trailingIcon;
  final Color trailingColor;
  final Function? onTap;
  final String? trailingTitle;

  const _BottomStackContainer({
    required this.color,
    required this.title,
    required this.titleColor,
    required this.subtitle,
    required this.subtitleColor,
    required this.trailingText,
    required this.trailingTextColor,
    this.trailingTitle,
    required this.trailingColor,
    this.onTap,
    Key? key,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool trailingLoading = false;
    return Container(
      height: deviceHeight * 0.15,
      color: color,
      child: ListTile(
        title: CustomText(title, color: titleColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s18),
        subtitle: CustomText(
          subtitle,
          color: subtitleColor,
          fontWeight: FontWeightManager.semiBold,
          fontSize: FontSize.s16,
        ),
        trailing: StatefulBuilder(builder: (context, setState) {
          if (trailingLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2.8,
              child: const LoadingSpinner(),
            );
          }
          return InkWell(
            onTap: () async {
              trailingLoading = true;
              setState(() {});
              await onTap!();
              trailingLoading = false;
              setState(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.8,
              decoration: BoxDecoration(
                color: trailingColor,
                borderRadius: BorderRadius.circular(AppSize.s8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (trailingTitle != null) CustomText(trailingTitle!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: CustomText(
                          trailingText,
                          fontSize: FontSize.s14,
                          color: trailingTextColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      if (trailingIcon != null) HorizontalSpace(AppSize.s2.w),
                      if (trailingIcon != null) CustomIcon(trailingIcon!, color: trailingTextColor, size: AppSize.s24),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s100.w,
      width: deviceWidth * 0.35,
      child: Card(
        elevation: AppSize.s4.h,
        color: AppColors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(value, fontSize: FontSize.s16, color: AppColors.pink, fontWeight: FontWeightManager.bold),
            CustomText(title, fontSize: FontSize.s16),
          ],
        ),
      ),
    );
  }
}

class _SpecialAction extends StatelessWidget {
  final String? image;
  final IconData? icon;
  final IconData? trailingIcon;
  final String text;
  final double? textSize;
  final bool isVertical;

  const _SpecialAction({this.image, this.icon, this.trailingIcon, this.textSize, this.isVertical = true, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVertical) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null) ...[
            SizedBox(width: 4),
            Image.asset(image!, height: 18),
            SizedBox(width: 4),
          ],
          if (icon != null) ...[
            SizedBox(width: 4),
            Icon(icon, color: Colors.redAccent, size: 22),
            SizedBox(width: 4),
          ],
          HorizontalSpace(AppSize.s4.h),
          Expanded(
              child: Row(
            children: [
              CustomText(text, fontWeight: FontWeightManager.bold, fontSize: textSize ?? FontSize.s12),
              const SizedBox(width: 8),
              if (trailingIcon != null) Icon(trailingIcon, color: Colors.grey[500], size: AppSize.s16.h),
            ],
          )),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (image != null) Image.asset(image!, height: AppSize.s32.h),
        VerticalSpace(AppSize.s4.h),
        CustomText(text, fontWeight: FontWeightManager.bold, fontSize: FontSize.s12),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(title, fontSize: FontSize.s16, fontWeight: FontWeightManager.bold),
        HorizontalSpace(AppPadding.p8.w),
        CustomText(
          value,
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.bold,
          color: AppColors.red,
        ),
      ],
    );
  }
}

class _DetailsRow extends StatelessWidget {
  final String image;
  final String title;

  const _DetailsRow({required this.image, required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(image, width: deviceWidth * 0.055),
        const HorizontalSpace(AppSize.s8),
        CustomText(title, fontSize: FontSize.s14, fontWeight: FontWeightManager.bold),
      ],
    );
  }
}

class InteractiveMapParams {
  LatLng latLng;
  double zoom;

  InteractiveMapParams({required this.latLng, required this.zoom});
}

openWhatsApp(String phone) async {
  bool status = await canLaunchUrl(Uri(path: 'https://api.whatsapp.com/send?phone=$phone'));
  if (status)
    launchUrl(Uri(path: 'https://api.whatsapp.com/send?phone=$phone'));
  else {
    bool status2 = await canLaunchUrl(Uri(path: 'https://wsend.co/$phone'));

    if (status2) launchUrl(Uri(path: 'https://wsend.co/$phone'));
  }
}
