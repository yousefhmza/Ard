//image from network or assets
import 'dart:io';

import 'package:ared/core/extensions/num_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';

class CustomImage extends StatelessWidget {
  final String urlOrPath;
  final File? imageAsFile;
  final double width;
  final double height;

  const CustomImage({
    required this.imageAsFile,
    required this.urlOrPath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (imageAsFile != null) return Image.file(imageAsFile!,
      fit: BoxFit.cover,
      width: width,
      height: width,);
    return CachedNetworkImage(
      imageUrl: urlOrPath,
      fit: BoxFit.cover,
      width: width,
      height: width,
      errorWidget: (vtx, url, obj) {
        return errorWidget();
      },
      progressIndicatorBuilder: (context, url, progress) {
        return CircularProgressIndicator(value: progress.downloaded / 100);
      },
    );
  }


  Widget errorWidget() {
    return Icon(
      Icons.camera_alt,
      size: width,
      color: AppColors.grey,
    );
  }
}

// Future<bool> checkPermissionStatus() async {
//   LocationPermission per = await Geolocator.checkPermission();
//   if (per == LocationPermission.deniedForever) return false;
//   if (per == LocationPermission.denied) {
//     return false;
//   }
//
//   position.value = await Geolocator.getCurrentPosition();
//   return true;
// }
//
// Future<bool> requestPermission() async {
//   LocationPermission per = await Geolocator.checkPermission();
//   if (per == LocationPermission.deniedForever) {
//     permissionGranted.value = false;
//     return false;
//   }
//   if (per == LocationPermission.denied) {
//     LocationPermission per = await Geolocator.requestPermission();
//     if (per == LocationPermission.denied) {
//       return false;
//     } else if (per == LocationPermission.deniedForever) {
//       permissionGranted.value = false;
//       return false;
//     }
//   }
//   position.value = await Geolocator.getCurrentPosition();
//   permissionGranted.value = true;
//   return true;
// }
