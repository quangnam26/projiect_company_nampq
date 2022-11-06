import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZILoading {
  final isLoadingKit = SpinKitFadingCube(
    size: IZIDimensions.ONE_UNIT_SIZE * 65,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? ColorResources.PRIMARY_APP : ColorResources.BOTTOM_BAR_DASHBOAD,
        ),
      );
    },
  );

  final spinKitLoadImage = const SpinKitFadingCircle(
    color: ColorResources.BOTTOM_BAR_DASHBOAD,
    duration: Duration(milliseconds: 2400),
  );
}
