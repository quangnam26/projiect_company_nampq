import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:template/helper/izi_dimensions.dart';

class IZIGlass extends StatelessWidget {
  final double? width, height;
  final Widget child;
  const IZIGlass({
    Key? key,
    this.height,
    this.width,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      width: width ?? IZIDimensions.iziSize.width * 0.8,
      height: height ?? IZIDimensions.iziSize.height * 0.6,
      borderColor: Colors.transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          IZIDimensions.BORDER_RADIUS_7X,
        ),
        bottomRight: Radius.circular(
          IZIDimensions.BORDER_RADIUS_7X,
        ),
      ),
      frostedOpacity: 0.05,
      blur: 20,
      child: child,
    );
  }
}
