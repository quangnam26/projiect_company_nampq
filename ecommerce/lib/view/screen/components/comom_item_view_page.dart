import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/components/common_image_page.dart';

// ignore: must_be_immutable
class CommomItemViewPage extends StatelessWidget {
  void Function()? onTapDetail;
  ProductResponse? productResponse;
  String? image;
  String? discountPercent;
  String? name;
  String? price;
  String? star;
  String? countSold;
  String? promotionalPrice;
  double? ratingNumberAvg;
  bool isGridView;

  CommomItemViewPage(
      {Key? key,
      this.onTapDetail,
      this.productResponse,
      this.image,
      this.discountPercent,
      this.name,
      this.price,
      this.star,
      this.countSold,
      this.isGridView = false,
      this.promotionalPrice,
      this.ratingNumberAvg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapDetail,
      child: Container(
        margin: EdgeInsets.only(
            right: isGridView ? 0 : IZIDimensions.SPACE_SIZE_4X),
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
        width: IZIDimensions.iziSize.width * .435,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          color: ColorResources.WHITE,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    CommomImagePage(url: image),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_1X,
                            horizontal: IZIDimensions.SPACE_SIZE_3X),
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.BORDER_RADIUS_7X),
                          border: Border.all(
                            width: 2,
                            color: ColorResources.RED_COLOR_2,
                          ),
                        ),
                        child: IZIText(
                          text: "$discountPercent% OFF",
                          style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: ColorResources.RED_COLOR_2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: IZIDimensions.ONE_UNIT_SIZE * 50,
              padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_1X / 2),
              margin:
                  EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
              child: IZIText(
                textAlign: TextAlign.start,
                text: name!,
                maxLine: 2,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.PRIMARY_9),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_1X / 2),
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IZIText(
                    text: price!,
                    style: TextStyle(
                      color: ColorResources.NEUTRALS_5,
                      decoration: TextDecoration.lineThrough,
                      wordSpacing: 5.0,
                      fontFamily: 'Roboto',
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    promotionalPrice ?? "",
                    style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        color: ColorResources.RED,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                            rating: IZIValidate.nullOrEmpty(ratingNumberAvg)
                                ? 0
                                : ratingNumberAvg!,
                            itemSize: IZIDimensions.FONT_SIZE_H6,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: ColorResources.YELLOW_PRIMARY2,
                              );
                            }),
                        Container(
                          margin: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_1X),
                          child: IZIText(
                            text: star!,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.PRIMARY_7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    // EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X),
                    child: IZIText(
                      text: "Đã bán $countSold",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.PRIMARY_7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
