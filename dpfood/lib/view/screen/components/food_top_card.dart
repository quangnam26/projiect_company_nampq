// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';

class FoodTopCard extends StatelessWidget {
  const FoodTopCard({
    Key? key,
    required this.image,
    required this.title,
    required this.rate,
    required this.comments,
  }) : super(key: key);
  final String image;
  final String title;
  final double rate;
  final int comments;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: IZIDimensions.ONE_UNIT_SIZE * 150,
      margin: EdgeInsets.only(
        right: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
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
                width: IZIDimensions.ONE_UNIT_SIZE * 150,
                height: IZIDimensions.ONE_UNIT_SIZE * 150,
                child: IZIImage(
                  image,
                ),
              ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
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
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ),
            ],
          ),
          //

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
                  fontWeight: FontWeight.w500,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X * 0.5,
              ),
              if (comments > 0)
                Text(
                  '(${comments > 15 ? '15+' : comments})',
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
    );
  }
}
