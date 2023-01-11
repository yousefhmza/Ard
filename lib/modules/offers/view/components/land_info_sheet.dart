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
import 'package:ared/modules/home/view/components/land_info_sheet.dart';
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

  const LandInfoSheet({
    Key? key,
    required this.latLng,
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
          ), const SizedBox(height: 30),
        ],
      ),
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
