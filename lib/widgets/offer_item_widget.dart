import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:flutter/material.dart';

class OfferItemWidget extends StatelessWidget {
  const OfferItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xff7070708C),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          //* Location and edit,show actions
          Row(
            children: [
              Expanded(child: CustomText("الحمراء- الروضة", fontSize: 16,fontWeight: FontWeight.bold, color: Color(0xffF26060))),
              CustomIcon(Icons.star, size: 16, color: Color(0xffFFEE00)),
              CustomText("4.3", fontSize: 14, color: Color(0xff000000),fontWeight: FontWeight.bold),
            ],
          ),
          //* Area size
          _singleRow("المساحة", "320 m"),
          //* Land number
          _singleRow("رقم القطعة", "557"),
          //* Land type
          _singleRow("نوع القطعة", "صناعى"),
        ],
      ),
    );
  }

  Widget _singleRow(String title, String value) {
    return Row(
      children: [
        CustomText(title, fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),
        Spacer(),
        CustomText(value, fontSize: 16, color: Colors.black),
      ],
    );
  }
}
