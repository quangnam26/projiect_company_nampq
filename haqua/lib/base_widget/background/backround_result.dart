import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class BackgroundResult extends StatelessWidget {
  const BackgroundResult({
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
                decoration: const BoxDecoration(color: ColorResources.WHITE),
                child: IZIImage(
                  ImagesPath.confetti,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
