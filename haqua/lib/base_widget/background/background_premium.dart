import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          // color: Colors.red,
          color: ColorResources.PRIMARY_APP,
          width: IZIDimensions.iziSize.width,
          height: MediaQuery.of(context).padding.top + kToolbarHeight,
          child: Stack(
            children: [
              Positioned(
                top: -IZIDimensions.ONE_UNIT_SIZE * 120,
                left: -IZIDimensions.ONE_UNIT_SIZE * 80,
                child: Container(
                  height: IZIDimensions.iziSize.width * 0.4,
                  width: IZIDimensions.iziSize.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorResources.WHITE.withOpacity(.3),
                        ColorResources.WHITE.withOpacity(.3),
                        ColorResources.WHITE.withOpacity(.3),
                        ColorResources.PRIMARY_LIGHT_APP.withOpacity(.3),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -IZIDimensions.ONE_UNIT_SIZE * 90,
                right: -IZIDimensions.ONE_UNIT_SIZE * 80,
                child: Container(
                  height: IZIDimensions.iziSize.height * 0.4,
                  width: IZIDimensions.iziSize.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorResources.WHITE.withOpacity(.3),
                        ColorResources.WHITE.withOpacity(.3),
                        ColorResources.WHITE.withOpacity(.3),
                        ColorResources.PRIMARY_LIGHT_APP.withOpacity(.3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
