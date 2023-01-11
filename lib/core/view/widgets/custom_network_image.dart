import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;

  const CustomNetworkImage({required this.image, this.height, this.width, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: image,
      width: width,
      height: height,
      placeholder: AppImages.placeholder,
      fit: BoxFit.cover,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (_, __, ___) => Image.asset(AppImages.placeholder, fit: BoxFit.cover),
    );
  }
}
