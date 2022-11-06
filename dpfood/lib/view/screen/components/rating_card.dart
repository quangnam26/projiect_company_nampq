import 'package:flutter/material.dart';
import 'package:template/data/model/review/shop_reactions.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';

import '../../../base_widget/izi_image.dart';
import '../../../helper/izi_text_style.dart';
import '../../../utils/color_resources.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({
    Key? key,
    required this.userName,
    required this.date,
    this.rating,
    this.reactions,
    this.comment,
    this.images,
  }) : super(key: key);
  final String userName;
  final String date;
  final int? rating;
  final ShopReactions? reactions;
  final String? comment;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_1X,
        left: IZIDimensions.SPACE_SIZE_1X,
        right: IZIDimensions.SPACE_SIZE_1X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_2X,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //image
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  IZIDimensions.ONE_UNIT_SIZE * 100,
                ),
                child: SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 50,
                  width: IZIDimensions.ONE_UNIT_SIZE * 50,
                  child: IZIImage(''),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: textStyleH6.copyWith(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.NEUTRALS_2,
                    ),
                  ),
                  if (!IZIValidate.nullOrEmpty(rating) && rating! > 0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          rating!,
                          (index) {
                            return Icon(
                              index < rating! ? Icons.star : Icons.star_border,
                              color: index < rating! ? ColorResources.PRIMARY_3 : ColorResources.NEUTRALS_4,
                              size: IZIDimensions.ONE_UNIT_SIZE * 25,
                            );
                          },
                        )
                      ],
                    ),
                ],
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),

              //Đánh giá
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Container(
            margin: EdgeInsets.only(
              left: IZIDimensions.SPACE_SIZE_4X * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!IZIValidate.nullOrEmpty(comment))
                  Container(
                    margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Text(
                      comment!,
                      style: textStyleH6,
                    ),
                  ),
                // dánh giá
                if (!IZIValidate.nullOrEmpty(reactions))
                  Container(
                    margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Wrap(
                      runSpacing: IZIDimensions.SPACE_SIZE_1X,
                      children: [
                        ...List.generate(6, (index) {
                          return IZIValidate.nullOrEmpty(reactionTitle(reactions: reactions!, index: index))
                              ? const SizedBox()
                              : FittedBox(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorResources.NEUTRALS_6,
                                      borderRadius: BorderRadius.circular(
                                        100,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      vertical: IZIDimensions.ONE_UNIT_SIZE * 4,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          IZIDimensions.ONE_UNIT_SIZE * 50,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                        vertical: IZIDimensions.ONE_UNIT_SIZE * 4,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            getReactionIcon(reactions: reactions!, index: index),
                                            color: ColorResources.PRIMARY_3,
                                            size: IZIDimensions.ONE_UNIT_SIZE * 25,
                                          ),
                                          SizedBox(
                                            width: IZIDimensions.SPACE_SIZE_1X,
                                          ),
                                          Text(
                                            reactionTitle(reactions: reactions!, index: index),
                                            style: TextStyle(
                                              color: ColorResources.NEUTRALS_3,
                                              fontWeight: FontWeight.w500,
                                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        })
                      ],
                    ),
                  ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                if (!IZIValidate.nullOrEmpty(images))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        images!.length,
                        (index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.BORDER_RADIUS_2X,
                              ),
                              child: SizedBox(
                                height: IZIDimensions.ONE_UNIT_SIZE * 120,
                                width: IZIDimensions.ONE_UNIT_SIZE * 120,
                                child: IZIImage(images![index]),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                //
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    date,
                    style: textStyleH6.copyWith(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String reactionTitle({required ShopReactions reactions, required int index}) {
    if (!IZIValidate.nullOrEmpty(reactions.delicious) && reactions.delicious == 1 && index == 0) {
      return 'Ngon tuyệt';
    }
    if (!IZIValidate.nullOrEmpty(reactions.satisfied) && reactions.satisfied == 1 && index == 1) {
      return 'Hài lòng';
    }
    if (!IZIValidate.nullOrEmpty(reactions.veryWorthTheMoney) && reactions.veryWorthTheMoney == 1 && index == 2) {
      return 'Rất đáng đồng tiền';
    }
    if (!IZIValidate.nullOrEmpty(reactions.wellPacked) && reactions.wellPacked == 1 && index == 3) {
      return 'Đóng gói kỹ';
    }
    if (!IZIValidate.nullOrEmpty(reactions.quickService) && reactions.quickService == 1 && index == 4) {
      return 'Phục vụ nhanh';
    }
    if (!IZIValidate.nullOrEmpty(reactions.sad) && reactions.sad == 1 && index == 5) {
      return 'Buồn';
    }
    return '';
  }

  IconData getReactionIcon({required ShopReactions reactions, required int index}) {
    if (!IZIValidate.nullOrEmpty(reactions.delicious) && reactions.delicious == 1 && index == 0) {
      return DELICIOUS;
    }
    if (!IZIValidate.nullOrEmpty(reactions.satisfied) && reactions.satisfied == 1 && index == 1) {
      return SATISFIED;
    }
    if (!IZIValidate.nullOrEmpty(reactions.veryWorthTheMoney) && reactions.veryWorthTheMoney == 1 && index == 2) {
      return VERY_WORTH_THE_MONEY;
    }
    if (!IZIValidate.nullOrEmpty(reactions.wellPacked) && reactions.wellPacked == 1 && index == 3) {
      return WELLPACKED;
    }
    if (!IZIValidate.nullOrEmpty(reactions.quickService) && reactions.quickService == 1 && index == 4) {
      return QUICKSERVICE;
    }
    if (!IZIValidate.nullOrEmpty(reactions.sad) && reactions.sad == 1 && index == 5) {
      return SAD;
    }
    return Icons.kitchen_outlined;
  }
}
