// ignore_for_file: unused_element

import 'dart:math';

import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/models/responses/my_offers_response.dart';
import 'package:ared/modules/home/view/components/land_info_sheet.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyOfferDetails extends StatefulWidget {
  final OfferItem offerItem;
  const MyOfferDetails({
    required this.offerItem,
    Key? key,
  }) : super(key: key);

  @override
  State<MyOfferDetails> createState() => _MyOfferDetailsState();
}

class _MyOfferDetailsState extends State<MyOfferDetails> with SingleTickerProviderStateMixin {
  late AnimationController rotateAnimation;
  @override
  void initState() {
    rotateAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 10000));
    super.initState();
  }

  @override
  void dispose() {
    rotateAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null)
      return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: AuthErrorWidget(
          action: () => () {
            NavigationService.push(context, Routes.authScreen);
          },
        ),
      );

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: MainAppbar(title: AppStrings.myOffers),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: ListView(
          children: [
            SizedBox(height: 12),
            SingleDescItem(
              name: AppStrings.offerNumber,
              value: "${widget.offerItem.id}",
              valueColor: Colors.black,
            ),
            SizedBox(height: 8),
            //*Header Title & rate
            Container(
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Icon(Icons.location_on, color: AppColors.accent),
                  SizedBox(width: 8),
                  CustomText(
                    "${widget.offerItem.title}",
                    color: AppColors.accent,
                    fontSize: FontSize.s18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            //*Body Area size ,number,land ...
            Column(
              children: [
                const SizedBox(height: 12),
                SingleDescItem(name: AppStrings.area, value: "${widget.offerItem.space} ${AppStrings.meterSquare}"),
                SingleDescItem(name: AppStrings.planNumber, value: "${widget.offerItem.space}"),
                SingleDescItem(name: AppStrings.landNumber, value: "${widget.offerItem.space}"),
                SingleDescItem(name: AppStrings.landType, value: "${widget.offerItem.using}"),
                const SizedBox(height: 12),
              ],
            ),

            //*Area properties
            Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 4,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...widget.offerItem.service.map((element) {
                        return _DetailsRow(image: AppImages.key, title: element.title);
                      }).toList(),
                      // _DetailsRow(image: AppImages.key, title: "ايجار"),
                      // _DetailsRow(image: AppImages.road, title: "6 متر"),
                      // _DetailsRow(image: AppImages.spot, title: "شرق"),
                      // _DetailsRow(image: AppImages.building, title: "تجاري"),
                    ],
                  ),
                ),
              ],
            ),

            //* Owner info and price
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Divider(color: Colors.grey[500]!)),

            SingleDescItem(name: AppStrings.price, value: "${widget.offerItem.price} ر.س", faIcon: FontAwesomeIcons.moneyBillWave),
            SingleDescItem(
              name: AppStrings.publishDate,
              value: "${widget.offerItem.createdAt?.year}/${widget.offerItem.createdAt?.month}/${widget.offerItem.createdAt?.day}",
              faIcon: FontAwesomeIcons.calendarDays,
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Divider(color: Colors.grey[500]!)),

            //Rotate animation
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (rotateAnimation.isAnimating) return;

                  rotateAnimation.forward(from: 0);
                  OffersProvider offersProvider = Provider.of<OffersProvider>(context, listen: false);
                  String status = await offersProvider.offerRenew(widget.offerItem.id.toString());
                  if (status.isEmpty)
                    await offersProvider.getMyOffers();
                  else
                    Alerts.showToast(status);
                  rotateAnimation.stop();
                },
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: rotateAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: rotateAnimation.value * 12 * pi,
                          child: child,
                        );
                      },
                      child: FaIcon(FontAwesomeIcons.arrowsRotate, color: Colors.green, size: 60),
                    ),
                    SizedBox(height: 12),
                    CustomText(AppStrings.refresh, color: Colors.black, fontSize: FontSize.s18, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
            //* Refresh Button

            const SizedBox(height: 12),
          ],
        ),
      ),
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
