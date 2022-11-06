import 'package:flutter/material.dart';
import 'package:template/helper/izi_validate.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';

class NearByCard extends StatelessWidget {
  NearByCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.rate,
    required this.comments,
    this.km,
  }) : super(key: key);
  final String image;
  final String title;
  final String description;
  final double rate;
  final int comments;
  final String? km;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: IZIDimensions.ONE_UNIT_SIZE * 180,
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_4X,
        ),
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
                width: IZIDimensions.ONE_UNIT_SIZE * 140,
                height: IZIDimensions.ONE_UNIT_SIZE * 140,
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
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_4X * 1.8,
                  ),
                  child: Text(
                    description,
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.NEUTRALS_4,
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    ),
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
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X * 0.5,
                    ),
                    if (comments > 0)
                      Text(
                        '(${comments < 15 ? comments : '$comments+'})',
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.NEUTRALS_4,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    if (!IZIValidate.nullOrEmpty(km))
                      SizedBox(
                        width: IZIDimensions.SPACE_SIZE_4X,
                      ),
                    if (!IZIValidate.nullOrEmpty(km))
                      Text(
                        '$km',
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.NEUTRALS_4,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
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
