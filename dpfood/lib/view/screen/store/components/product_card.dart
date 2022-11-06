import 'package:flutter/material.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.onTap,
    required this.image,
  }) : super(key: key);
  final String name;
  final String price;
  final Function onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.BLUR_RADIUS_4X,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 3,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: ColorResources.NEUTRALS_2,
                          fontWeight: FontWeight.w500,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        onTap();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_1X,
                          right: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.ONE_UNIT_SIZE * 5,
                          ),
                          border: Border.all(
                            color: ColorResources.PRIMARY_4,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: ColorResources.PRIMARY_4,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_3X,
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: ColorResources.NEUTRALS_4,
                    fontWeight: FontWeight.w500,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: IZIDimensions.ONE_UNIT_SIZE * 140,
            height: IZIDimensions.ONE_UNIT_SIZE * 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
              child: IZIImage(
                image,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
