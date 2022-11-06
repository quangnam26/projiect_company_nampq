import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_preview_image/izi_preview_image_controller.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZIPreviewImagesPage extends GetView<IZIPreviewImagesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: IZIPreviewImagesController(),
      builder: (IZIPreviewImagesController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return Container(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          color: ColorResources.WHITE,
          child: SafeArea(
            child: Stack(
              children: [
                //Image
                InteractiveViewer(
                  maxScale: 9,
                  child: IZIImage(
                    controller.imageUrl.toString(),
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.iziSize.height,
                    fit: BoxFit.contain,
                  ),
                ),

                //Icon Back Button
                Container(
                  width: IZIDimensions.iziSize.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                    vertical: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: ColorResources.BLACK,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
