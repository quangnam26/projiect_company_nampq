import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundWhite extends StatelessWidget {
  const BackgroundWhite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width,
                decoration: const BoxDecoration(
                  color: ColorResources.WHITE
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
