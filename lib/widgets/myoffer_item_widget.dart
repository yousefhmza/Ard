import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/models/responses/my_offers_response.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyOfferItemWidget extends StatelessWidget {
  final OfferItem offerItem;
  const MyOfferItemWidget({
    required this.offerItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8),
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
          //* Location and edit,show actions
          Row(
            children: [
              SizedBox(width: 12),
              CustomIcon(
                FontAwesomeIcons.locationDot,
                size: 20,
                faIcon: true,
                color: Color(0xffF26060),
              ),
              SizedBox(width: 12),
              Expanded(
                  child: CustomText(
                "${offerItem.title}",
                fontSize: 16,
                color: Color(0xffF26060),
                fontWeight: FontWeight.w700,
              )),
              GestureDetector(
                onTap: () {
                  String activateOrDeactivate = offerItem.active == "yes" ? "تعطيل" : "تفعيل";
                  //Confirm deActivate
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 30),
                          CustomText(
                            "هل انت متأكد من $activateOrDeactivate العرض؟",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 12),
                          dialogActions(
                              yesText: "نعم",
                              noText: "لا",
                              onPressed: () async {
                                OffersProvider offersProvider = Provider.of<OffersProvider>(context, listen: false);
                                bool status = await offersProvider.changeStatusOffer(offerItem.id.toString());
                                if (status)
                                  await offersProvider.getMyOffers();
                                else
                                  Alerts.showToast(" حدث خطأ ما");
                              }),
                          SizedBox(height: 30),
                        ],
                      ));
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomIcon(
                    offerItem.active == "yes" ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash,
                    size: 22,
                    faIcon: true,
                    color: offerItem.active == "yes" ? Colors.green : Color(0xff858585),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigationService.push(context, Routes.myOfferDetails, arguments: {
                    "offerItem": offerItem,
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomIcon(
                    FontAwesomeIcons.penToSquare,
                    size: 22,
                    faIcon: true,
                    color: Color(0xff858585),
                  ),
                ),
              ),
            ],
          ),
          //* Land number
          _singleRow("رقم القطعة", "${offerItem.space}"),
          //* plan number
          _singleRow("رقم المخطط", "${offerItem.space}"),
          //* area size
          Row(
            children: [
              SizedBox(width: 12),
              CustomIcon(Icons.swap_vert, size: 20, color: Color(0xff365D84)),
              SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  "المساحة",
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //confirm delete
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 30),
                          CustomText(
                            "هل انت متأكد من حذف هذا العرض؟",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 12),
                          dialogActions(
                              yesText: "نعم",
                              noText: "لا",
                              onPressed: () async {
                                OffersProvider offersProvider = Provider.of<OffersProvider>(context, listen: false);
                                bool status = await offersProvider.deleteOffer(offerItem.id.toString());
                                if (status)
                                  await offersProvider.getMyOffers();
                                else
                                  Alerts.showToast(" حدث خطأ ما");
                              }),
                          SizedBox(height: 30),
                        ],
                      ));
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomIcon(
                    Icons.delete_forever,
                    size: 22,
                    color: Color(0xffFF0000),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _singleRow(String title, String value) {
    return Row(
      children: [
        SizedBox(width: 24),
        Expanded(
            flex: 2,
            child: CustomText(
              title,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            )),
        Expanded(flex: 4, child: CustomText(value, fontSize: 16, color: Color(0xffF26060))),
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
