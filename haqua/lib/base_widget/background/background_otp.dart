import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class BackgroundOtp extends StatelessWidget {
  const BackgroundOtp({
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
          alignment: Alignment.center,
          children: [
            Container(
              height: IZIDimensions.iziSize.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorResources.CIRCLE_COLOR_BG3,
              ),
            ),
            Image.asset(
              ImagesPath.logo,
              fit: BoxFit.contain,
              width: IZIDimensions.iziSize.width * 0.5,
              height: IZIDimensions.iziSize.height * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}


// anh