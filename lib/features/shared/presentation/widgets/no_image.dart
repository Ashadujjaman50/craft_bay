import 'package:craft_bay/app/assets_paths.dart';
import 'package:flutter/material.dart';

class NoImage extends StatelessWidget {
  const NoImage({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsPaths.noImagePng,
      fit: .scaleDown,
      height: height,
      width: width,
    );
  }
}