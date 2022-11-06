import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class IZIImageCard extends StatelessWidget {
  const IZIImageCard({
    Key? key,
    required this.image,
    required this.isAddImage,
    this.onDelete,
    //this.imageUrl
  }) : super(key: key);
  final String image;
  // final String? imageUrl;
  final bool isAddImage;
  final Function? onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.GREY,
          borderRadius: BorderRadius.circular(
            IZIDimensions.BORDER_RADIUS_3X,
          ),
        ),
        height: IZIDimensions.ONE_UNIT_SIZE * 150,
        width: IZIDimensions.ONE_UNIT_SIZE * 150,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_3X,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: ImagesPath.placeholder,
                  image: image,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                    ImagesPath.placeholder,
                  ),
                ),
              ),
            ),
            if (isAddImage)
              GestureDetector(
                onTap: () => onDelete!(),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: ColorResources.RED,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
