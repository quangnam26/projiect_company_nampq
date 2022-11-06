import 'package:flutter/material.dart';
import '../../helper/izi_dimensions.dart';
import '../../utils/images_path.dart';
import '../izi_image.dart';

class BackgroundOnBoarding extends StatelessWidget {
  const BackgroundOnBoarding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: Stack(
            children: [
              Positioned(
                right: IZIDimensions.ONE_UNIT_SIZE * 70,
                top: IZIDimensions.ONE_UNIT_SIZE * 30,
                child: SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 250,
                  width: IZIDimensions.ONE_UNIT_SIZE * 250,
                  child: IZIImage(
                    ImagesPath.bg1,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                right: IZIDimensions.ONE_UNIT_SIZE * 50,
                top: IZIDimensions.ONE_UNIT_SIZE * 270,
                child: SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 150,
                  width: IZIDimensions.ONE_UNIT_SIZE * 150,
                  child: IZIImage(
                    ImagesPath.bg2,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: IZIDimensions.ONE_UNIT_SIZE * 30,
                top: IZIDimensions.ONE_UNIT_SIZE * 120,
                child: SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 250,
                  width: IZIDimensions.ONE_UNIT_SIZE * 150,
                  child: Stack(
                    children: [
                      IZIImage(
                        ImagesPath.bg3,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        left: IZIDimensions.ONE_UNIT_SIZE * 40,
                        top: IZIDimensions.ONE_UNIT_SIZE * 90,
                        child: SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 130,
                          width: IZIDimensions.ONE_UNIT_SIZE * 130,
                          child: IZIImage(
                            ImagesPath.bg4,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
