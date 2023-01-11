import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/network/dio_requests_arguments.dart';
import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/modules/offers/providers/add_offer_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import 'land_info_dialog.dart';
import 'land_info_sheet.dart';

class AddOfferMap extends StatefulWidget {
  const AddOfferMap({Key? key}) : super(key: key);

  @override
  State<AddOfferMap> createState() => _AddOfferMapState();
}

class _AddOfferMapState extends State<AddOfferMap> {
  late MapboxMapController mapController;
  var isLight = true;
  bool loadingLayer = false;
  static const CameraPosition _kInitialPosition = CameraPosition(target: LatLng(21.585, 39.230), zoom: 11.0);

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  handleLayer() async {
    if (mapController.cameraPosition!.zoom < 13) return;
    if (loadingLayer) return;
    loadingLayer = true;
    LatLngBounds latLngBounds = await mapController.getVisibleRegion();
    setState(() {});

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    try {
      Uint8List res = await networkGetMapImageLayer(
        bBox: '${latLngBounds.southwest.longitude},${latLngBounds.southwest.latitude},${latLngBounds.northeast.longitude},${latLngBounds.northeast.latitude}',
        height: '$height',
        width: '$width',
      );
      mapController.removeLayer('sydney_layer');
      mapController.removeSource('sydney_source');
      mapController.addImageSource(
        'sydney_source',
        res,
        LatLngQuad(
          topLeft: LatLng(latLngBounds.northeast.latitude, latLngBounds.southwest.longitude),
          topRight: LatLng(latLngBounds.northeast.latitude, latLngBounds.northeast.longitude),
          bottomRight: LatLng(latLngBounds.southwest.latitude, latLngBounds.northeast.longitude),
          bottomLeft: LatLng(latLngBounds.southwest.latitude, latLngBounds.southwest.longitude),
        ),
      );
      mapController.addImageLayer('sydney_layer', 'sydney_source');
    } catch (e) {
      setState(() {
        loadingLayer = false;
      });
    }

    setState(() {
      loadingLayer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapboxMap(
              key: Key("offers_map"),
            styleString: MapboxStyles.LIGHT,
            accessToken: "sk.eyJ1IjoibWF0cmljbG91ZHMiLCJhIjoiY2xhemRwbWF2MHFheDN2b3EyN21obGFvNSJ9.-TFoJt5QTUOIh0qiP1tT4w",
            onMapCreated: _onMapCreated,
            initialCameraPosition: _kInitialPosition,
            trackCameraPosition: true,
            onCameraIdle: () => handleLayer(),
            onMapClick: (point, latLng) {
              AddOfferProvider profileProvider = Provider.of<AddOfferProvider>(context, listen: false);
               Alerts.showLandInfoSheet(context,
                    child: LandInfoSheet(
                      latLng: latLng,
                      zoom: mapController.cameraPosition!.zoom,
                    ));
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FutureBuilder<bool>(
                      future: profileProvider.checkLicenceNumberStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CustomDialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.p24.w),
                            backgroundColor: AppColors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      CircularProgressIndicator(),
                                      SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.data != null && !snapshot.data!)
                          return CustomDialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.p24.w),
                            backgroundColor: AppColors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.4,
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 24),
                                      Row(
                                        children: [
                                          Spacer(),
                                          InkWell(
                                            onTap: () => NavigationService.goBack(context),
                                            child: const CustomIcon(Icons.cancel, color: AppColors.pink),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      const CustomText(
                                        AppStrings.enterLicenceNumberNote,
                                        fontWeight: FontWeightManager.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 18),
                                      CustomButton(
                                        text: AppStrings.addLicenceNumber,
                                        onPressed: () async {
                                          await NavigationService.goBack(context);
                                          // ignore: use_build_context_synchronously
                                          await NavigationService.push(context, Routes.profileScreen);
                                        },
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );

                        return LandInfoDialog();
                      },
                    );
                  });
           
           
            },
            onAttributionClick: () {},
            onUserLocationUpdated: (location) {},
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 6,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: AppColors.red),
                  SizedBox(width: 12),
                  CustomText("حدد القطعة التي تريدهالتظهر لك تفاصيلها"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class AddOfferMap extends StatelessWidget {
//   const AddOfferMap({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       zoomControlsEnabled: false,
//       myLocationEnabled: true,
//       polygons: {
//         Polygon(
//           consumeTapEvents: true,
//           polygonId: const PolygonId("add-offer-polygon"),
//           fillColor: AppColors.pink.withOpacity(0.5),
//           strokeColor: AppColors.pink,
//           strokeWidth: AppSize.s2.w.toInt(),
//           points: const [
//             LatLng(21.492500, 39.177570),
//             LatLng(21.582500, 39.167570),
//             LatLng(21.672500, 39.157570),
//             LatLng(21.462500, 39.247570),
//             LatLng(21.492500, 39.177570),
//           ],
//           onTap: () => showDialog(context: context, builder: (BuildContext context) => const LandInfoDialog()),
//         ),
//       },
//       initialCameraPosition: const CameraPosition(target: LatLng(21.492500, 39.177570), zoom: 12),
//     );
//   }
// }
