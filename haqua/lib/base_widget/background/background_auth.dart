import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundAuth extends StatelessWidget {
  const BackgroundAuth({
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
            Container(
              height: double.infinity,
              color: ColorResources.WHITE,
            ),
            Container(
              height: IZIDimensions.iziSize.height * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ],
        ),
      ),
    );
  }
}
