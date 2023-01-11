import 'package:ared/core/resources/app_colors.dart';
import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/view/widgets/custom_text.dart';
import 'package:ared/core/view/widgets/main_appbar.dart';
import 'package:ared/modules/lands/models/lands_list_response.dart';
import 'package:ared/modules/lands/provider/land_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LandScreen extends StatelessWidget {
  final LandItem landItem;
  const LandScreen({required this.landItem});

  @override
  Widget build(BuildContext context) {
    LandProvider provider = Provider.of<LandProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: const MainAppbar(title: AppStrings.orderDetails),
        body: FutureBuilder<LandItem>(
          future: provider.getLandDetails(landItem.id ?? 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return ErrorWidget("${snapshot.error}");

            return Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListView(
                children: [
                  //* Land id
                  _singleRow("رقم الطلب", "${landItem.id}"),
                  const SizedBox(height: 20),
                  //* district
                  _singleRow("المنطقة", "${landItem.area} ${landItem.area}"),
                  //* city
                  _singleRow("المدينة", "${landItem.city}"),
                  //* District
                  _singleRow("الحي", "${landItem.district}"),

                  const Divider(thickness: 1, height: 32),
                  //* Type
                  _singleRow("النوع", "${landItem.offerType}", valueColor: Colors.red),
                  //* Using
                  _singleRow("التخصيص", "${snapshot.data?.using}", valueColor: Colors.red),
                  //* Price
                  _singleRow("المبلغ المطلوب", "${snapshot.data?.price} ر.س", valueColor: Colors.red),
                  const Divider(thickness: 1, height: 32),
                  //* Land id
                  if (snapshot.data?.user != null) ...[
                    //* Licence number
                    _singleRow("رقم ترخيص المعلن", "${snapshot.data?.user?.licenseNumber}", valueColor: Colors.red),

                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        launchUrlString('tel:${snapshot.data?.user?.mobileNumber}');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.red),
                            const SizedBox(width: 12),
                            CustomText("${snapshot.data?.user?.mobileNumber}", fontSize: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ));
  }

  Widget _singleRow(String title, String? value, {Color? valueColor}) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            title,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomText(value ?? "N/A", fontSize: 16, color: valueColor),
      ],
    );
  }
}
