import 'package:flutter/material.dart';

import '../helpers/app_image_paths.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imagePath;
  final double? width, height;
  const ImageNetworkWidget(
      {super.key, required this.imagePath, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      width: width ?? 80,
      height: height ?? 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        AppImages.logo,
        width: width ?? 80,
        height: height ?? 80,
      ),
    );
  }
}
