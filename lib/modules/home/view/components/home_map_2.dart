import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/network/dio_requests_arguments.dart';
import 'package:ared/core/resources/values_manager.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/main.dart';
import 'package:ared/modules/home/view/components/home_buttons.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:ared/modules/offers/providers/add_offer_provider.dart';
import 'package:ared/modules/offers/view/components/offers_list.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:ared/widgets/dialog_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import 'land_info_sheet.dart';

class HomeMap2 extends StatefulWidget {
  const HomeMap2({Key? key}) : super(key: key);

  @override
  State<HomeMap2> createState() => _HomeMap2State();
}

class _HomeMap2State extends State<HomeMap2> {
  late MapboxMapController mapController;
  var isLight = true;
  bool loadingLayer = false;
  bool viewModeIsMap = true;
  bool? canViewAllLandDetails;
  AddOfferProvider profileProvider = getIt.get<AddOfferProvider>();

  String mapStyle = MapboxStyles.LIGHT;
  static const CameraPosition _kInitialPosition = CameraPosition(target: LatLng(21.585, 39.230), zoom: 11.0);
  LatLngBounds? _positionBounds;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController.addListener(_onMapChanged);
  }

  void _onMapChanged() async {
    LatLngBounds latLngBounds = await mapController.getVisibleRegion();
    setState(() {
      _extractMapInfo();
    });
    // mapController.addImageLayer("sydney_layer", "sydney_source");
  }

  void _extractMapInfo() {
    final position = mapController.cameraPosition;
    kEcho('_extractMapInfo position ${position.toString()}');
    // if (position != null) _position = position;
  }

  @override
  void initState() {
    super.initState();
    //perform action before build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AddOfferProvider profileProvider = getIt.get<AddOfferProvider>();
      canViewAllLandDetails = await profileProvider.checkLicenceNumberStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (canViewAllLandDetails == null)
            FutureBuilder<bool>(
              future: profileProvider.checkLicenceNumberStatus(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) canViewAllLandDetails = snapshot.data!;
                return Container();
              },
            ),
          if (viewModeIsMap)
            MapboxMap(
              key: const Key("map"),
              styleString: mapStyle,
              accessToken: "sk.eyJ1IjoibWF0cmljbG91ZHMiLCJhIjoiY2xhemRwbWF2MHFheDN2b3EyN21obGFvNSJ9.-TFoJt5QTUOIh0qiP1tT4w",
              onMapCreated: _onMapCreated,
              initialCameraPosition: _kInitialPosition,
              trackCameraPosition: true,
              onCameraIdle: () {
                handleLayer();
              },
              onMapClick: (point, latLng) {
                kEchoError('onMapClick');
                OffersProvider offersProvider = getIt.get<OffersProvider>();
                offersProvider.offerViewCount("1");
                Alerts.showLandInfoSheet(context,
                    child: LandInfoSheet(
                      latLng: latLng,
                      canViewAllLandDetails: canViewAllLandDetails ?? false,
                      zoom: mapController.cameraPosition!.zoom,
                    ));
              },
              onAttributionClick: () {
                kEchoError('onAttributionClick');
              },
              onUserLocationUpdated: (location) {
                kEcho('onUserLocationUpdated');
                kEcho(
                    "new location: ${location.position}, alt.: ${location.altitude}, bearing: ${location.bearing}, speed: ${location.speed}, horiz. accuracy: ${location.horizontalAccuracy}, vert. accuracy: ${location.verticalAccuracy}");
              },
            ),
          if (!viewModeIsMap) Container(padding: EdgeInsets.only(top: AppSize.s100.h + 50), child: OffersListWidget()),
          PositionedDirectional(
            start: AppSize.s16.w,
            bottom: AppSize.s100.h,
            child: HomeButtons(
              viewModeIsMap: viewModeIsMap,
              goToInteractiveMap: () {
                LayoutProvider layoutProvider = Provider.of<LayoutProvider>(context, listen: false);
                if (currentUser == null) {
                  showDialog(context: context, builder: (BuildContext context) => const DialogAuth());
                } else {
                  layoutProvider.setCurrentIndex(3);
                }
              },
              changeMapStyle: () {
                if (mapStyle == MapboxStyles.SATELLITE) {
                  mapStyle = MapboxStyles.LIGHT;
                } else {
                  mapStyle = MapboxStyles.SATELLITE;
                }
                setState(() {});
              },
              switchMode: () {
                viewModeIsMap = !viewModeIsMap;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  handleLayer() async {
    if (mapController.cameraPosition!.zoom < 13) return;
    if (loadingLayer) return;
    loadingLayer = true;
    LatLngBounds latLngBounds = await mapController.getVisibleRegion();
    _positionBounds = latLngBounds;
    setState(() {});

    if (false) {
      final ByteData bytes = await rootBundle.load('assets/images/test.png');
      final Uint8List list = bytes.buffer.asUint8List();
      mapController.removeLayer('sydney_source');
      setState(() {});
      mapController.addImageSource(
        'sydney_source',
        list,
        const LatLngQuad(
          topLeft: LatLng(21.57597, 39.1867),
          topRight: LatLng(21.57597, 39.2540),
          bottomRight: LatLng(21.53830, 39.2540),
          bottomLeft: LatLng(21.53830, 39.1867),
        ),
      );
      mapController.addImageLayer('sydney_layer', 'sydney_source');
    } else {
      int randomNumber = Random().nextInt(1000);
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
        kEchoError('$e');
        loadingLayer = false;
        setState(() {});
      }
    }

    // String bBox = '${latLngBounds.southwest.longitude},${latLngBounds.southwest.latitude},${latLngBounds.northeast.longitude},${latLngBounds.northeast.longitude}';
    // String bBox = '39.044864247002252,21.53476837041949565,39.43315253549579324,21.66751395566158322';
    // return;
    // sLng,sLat,hLng,hLat

    //? TOP & RIGHT are higher
    // mapController.addImageLayer('sydney_layer', 'sydney_source');
    loadingLayer = false;
    setState(() {});
  }

  static Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }
}
