// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:ared/core/extensions/num_extensions.dart';
// import '../../../../core/resources/resources.dart';
// import '../../../../core/utils/alerts.dart';
// import 'land_info_sheet.dart';

// class HomeMap extends StatelessWidget {
//   const HomeMap({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       zoomControlsEnabled: false,
//       myLocationEnabled: true,
//       polygons: {
//         Polygon(
//           consumeTapEvents: true,
//           polygonId: const PolygonId("home-polygon"),
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
//           onTap: () => Alerts.showLandInfoSheet(context, child: const LandInfoSheet()),
//         ),
//       },
//       initialCameraPosition: const CameraPosition(target: LatLng(21.492500, 39.177570), zoom: 12),
//     );
//   }
// }
