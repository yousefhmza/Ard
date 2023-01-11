import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/models/responses/my_offers_response.dart';
import 'package:ared/modules/lands/models/lands_list_response.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LandItemWidget extends StatelessWidget {
  final LandItem landItem;
  const LandItemWidget({
    required this.landItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          //* Land id
          _singleRow("رقم الطلب", "${landItem.id}"),
          //* city
          _singleRow("المدينة", "${landItem.city}"),
          //* district
          _singleRow("المنطقة", "${landItem.district} ${landItem.area}"),

           Divider(thickness: 1, height: 16),
          //* Land id
          _singleRow("النوع", "${landItem.offerType}"),
        SizedBox(height: 12),
        ],  
      ),
    );
  }

  Widget _singleRow(String title, String value) {
    return Row(
      children: [
        CustomText(
          title,
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        Spacer(),
        CustomText(value, fontSize: 16),
      ],
    );
  }

  dialogActions({
    required String yesText,
    required String noText,
    required Function onPressed,
  }) {
    bool isLoading = false;
    return StatefulBuilder(
      builder: (context, setState) {
        if (isLoading) return Center(child: CircularProgressIndicator());
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              text: "$yesText",
              onPressed: () async {
                isLoading = true;
                setState(() {});
                await onPressed();

                isLoading = false;
                setState(() {});
                Navigator.pop(context);
              },
              color: Color(0xffF26060),
              textColor: Colors.white,
              width: 100,
            ),
            CustomButton(
              text: "$noText",
              onPressed: () {
                if (isLoading) return;
                Navigator.pop(context);
              },
              color: Color(0xff858585),
              textColor: Colors.white,
              width: 100,
            ),
          ],
        );
      },
    );
  }
}
