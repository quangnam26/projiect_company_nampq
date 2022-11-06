import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import '../../utils/color_resources.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({
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
          height: IZIDimensions.iziSize.height,
          width: IZIDimensions.iziSize.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1,0.4 ,1],
              colors: [
                ColorResources.PRIMARY_3,
                ColorResources.PRIMARY_2,
                ColorResources.PRIMARY_2,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
