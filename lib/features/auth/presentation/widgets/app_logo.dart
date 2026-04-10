import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/assets_paths.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 100, this.width = 100});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPaths.logoSvg, height: height, width: width);
  }
}