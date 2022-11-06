import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:template/helper/izi_dimensions.dart';

import '../utils/color_resources.dart';

class IZILoaderOverLay extends StatelessWidget {
  const IZILoaderOverLay({Key? key, required this.body}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      closeOnBackButton: true,
      overlayWidget: Center(
        child: SpinKitFadingCircle(
          color: ColorResources.PRIMARY_1,
          size: IZIDimensions.ONE_UNIT_SIZE * 80,
        ),
      ),
      child: body,
    );
  }
}

final spinKitWave = SpinKitWave(
  color: ColorResources.PRIMARY_1,
  size: IZIDimensions.ONE_UNIT_SIZE * 40,
);

void onShowLoaderOverlay() {
  final BuildContext? context = Get.context;
  if (context != null) {
    context.loaderOverlay.show();
  }
}

void onHideLoaderOverlay() {
  final BuildContext? context = Get.context;
  if (context != null) {
    context.loaderOverlay.hide();
  }
}


