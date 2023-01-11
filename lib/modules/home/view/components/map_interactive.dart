import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/modules/home/view/components/land_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mapToolkit;

class InteractiveMap extends StatefulWidget {
  final InteractiveMapParams? interactiveMapParams;
  const InteractiveMap({
    Key? key,
    required this.interactiveMapParams,
  }) : super(key: key);

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  late MapboxMapController mapController;
  var isLight = true;
  bool loadingLayer = false;
  bool mapControllerIsInit = false;
  String shapeSize = '';
  late CameraPosition _kInitialPosition;
  LatLngBounds? _positionBounds;

  @override
  void initState() {
    super.initState();
    if (widget.interactiveMapParams == null)
      _kInitialPosition = CameraPosition(target: LatLng(21.585, 39.230), zoom: 11.0);
    else
      _kInitialPosition = CameraPosition(target: widget.interactiveMapParams!.latLng, zoom: widget.interactiveMapParams!.zoom);
  }

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapControllerIsInit = true;
    mapController.addListener(_onMapChanged);

    mapController.onFeatureDrag.add((
      id, {
      required current,
      required delta,
      required origin,
      required point,
      required eventType,
    }) {
      DragEventType type = eventType;
      switch (type) {
        case DragEventType.start:
          break;
        case DragEventType.drag:
          break;
        case DragEventType.end:
          refreshAreaFills();
          break;
      }
    });
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

  void refreshAreaFills() {
    mapController.clearLines();
    mapController.clearFills();
    List<LatLng> list = [];
    for (var element in mapController.circles) {
      list.add(element.options.geometry!);
    }
    mapController.addFill(
      FillOptions(geometry: [list], fillColor: "#333333", fillOutlineColor: "#333333", draggable: false, fillOpacity: 0.3),
    );

    // draw lines between points
    if (list.length > 1)
      mapController.addLine(LineOptions(
        geometry: [...list, list.first],
      ));
    calculateFillSize(list);
  }

  void calculateFillSize(List<LatLng> list) {
    if (list.length < 3) {
      shapeSize = '';
      return;
    }
    List<mapToolkit.LatLng> mapToolKitLatLngList = [];
    for (var element in list) {
      mapToolKitLatLngList.add(mapToolkit.LatLng(element.latitude, element.longitude));
    }
    num areaInSquareMeters = mapToolkit.SphericalUtil.computeArea(mapToolKitLatLngList);
    shapeSize = areaInSquareMeters.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStrings.calculateArea,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: MapboxMap(
              key: Key("interactive_map"),
              styleString: MapboxStyles.LIGHT,
              accessToken: "sk.eyJ1IjoibWF0cmljbG91ZHMiLCJhIjoiY2xhemRwbWF2MHFheDN2b3EyN21obGFvNSJ9.-TFoJt5QTUOIh0qiP1tT4w",
              onMapCreated: _onMapCreated,
              initialCameraPosition: _kInitialPosition,
              trackCameraPosition: true,
              onCameraIdle: () {},
              onMapClick: (point, latLng) {
                kEcho('on map click');

                mapController.addCircle(CircleOptions(
                  geometry: latLng,
                  circleColor: '#ff0000',
                  circleRadius: 6,
                  circleStrokeColor: '#222222',
                  circleStrokeWidth: 2,
                  draggable: true,
                ));
                refreshAreaFills();
              },
              onAttributionClick: () {},
              onUserLocationUpdated: (location) {},
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            padding: const EdgeInsets.all(24),
            color: Colors.white,
            child: Column(
              children: [
                if (shapeSize.isNotEmpty) CustomText(" المساحة المحددة بالمتر مربع $shapeSize", color: Colors.black, fontSize: 18),
                const CustomText("حدد نقط القياس بالضغط علي الخريطة"),
                const Spacer(),
                if (mapControllerIsInit && mapController.circles.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      mapController.removeCircle(mapController.circles.last);
                      refreshAreaFills();
                      setState(() {});
                    },
                    child: Row(
                      children: const [
                        CustomText("حذف اخر نقطة"),
                        SizedBox(width: 8),
                        CustomIcon(
                          Icons.undo,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
