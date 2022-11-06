import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';

class CommomImagePage extends StatelessWidget {
  String? url;
  CommomImagePage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
        child: IZIImage(
          url ?? "",
          width: double.infinity,
        ),
      ),
    );
  }
}
