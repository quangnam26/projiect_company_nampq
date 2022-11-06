import 'package:flutter/material.dart';
import 'package:template/helper/izi_validate.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';

class NearByCard extends StatelessWidget {
  const NearByCard({
    Key? key,
    required this.image,
    required this.title,
    required this.rate,
    required this.comments,
    this.km,
  }) : super(key: key);
  final String image;
  final String title;
  final double rate;
  final int comments;
  final double? km;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: IZIDimensions.ONE_UNIT_SIZE * 180,
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              IZIDimensions.ONE_UNIT_SIZE * 10,
            ),
            child: Banner(
              message: 'Promo',
              location: BannerLocation.topStart,
              color: ColorResources.PRIMARY_3,
              child: SizedBox(
                width: IZIDimensions.ONE_UNIT_SIZE * 180,
                height: IZIDimensions.ONE_UNIT_SIZE * 180,
                child: IZIImage(
                  image,
                ),
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: IZIImage(
                        ImagesPath.promo,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: ColorResources.NEUTRALS_4,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
                //
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: ColorResources.PRIMARY_3,
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Text(
                      rate.toString(),
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.NEUTRALS_3,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Text(
                      '(${comments > 15 ? 15 : comments}+)',
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.NEUTRALS_4,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                      ),
                    ),
                    if(!IZIValidate.nullOrEmpty(km))
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    if(!IZIValidate.nullOrEmpty(km))
                    Text(
                      '${km}km',
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.NEUTRALS_4,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
