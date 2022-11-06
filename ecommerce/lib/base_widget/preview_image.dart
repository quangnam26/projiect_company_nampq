import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

import 'izi_image.dart';

// ignore: must_be_immutable
class ReviewImagePage extends StatefulWidget {
  String? image;
  ReviewImagePage({this.image});

  @override
  PreviewImageState createState() => PreviewImageState();
}

class PreviewImageState extends State<ReviewImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BLACK,
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: InteractiveViewer(
          maxScale: 9,
          child: IZIImage(
            widget.image.toString(),
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
