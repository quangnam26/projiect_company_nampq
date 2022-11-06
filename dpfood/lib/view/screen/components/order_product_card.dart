import 'package:flutter/material.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/images_path.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_text_style.dart';
import '../../../utils/color_resources.dart';

class ProductOrderCard extends StatelessWidget {
  ProductOrderCard({
    Key? key,
    required this.amount,
    required this.name,
    required this.toppings,
    required this.note,
    required this.price,
    this.onChanged,
    this.isShowCart = true,
    this.isShowDivider = false,
  }) : super(key: key);
  final int amount;
  final String name;
  final String toppings;
  final String note;
  final String price;
  final bool isShowCart;
  final bool isShowDivider;
  final Function(String val)? onChanged;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: amount.toString());
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_1X,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "x${amount}",
                style: textStyleH6.copyWith(
                  color: ColorResources.NEUTRALS_4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textStyleH6.copyWith(
                        color: ColorResources.NEUTRALS_4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X * 0.4,
                    ),
                    if (!IZIValidate.nullOrEmpty(toppings))
                      Text(
                        toppings,
                        style: textStyleSpan.copyWith(
                          color: ColorResources.NEUTRALS_4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X * 0.4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!IZIValidate.nullOrEmpty(note))
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 17,
                                      width: 17,
                                      child: IZIImage(
                                        ImagesPath.description,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    Expanded(
                                      child: Text(
                                        note,
                                        maxLines: 2,
                                        style: textStyleSpan.copyWith(
                                          color: ColorResources.NEUTRALS_4,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X * 0.4,
                              ),
                              Row(
                                mainAxisAlignment: isShowCart ? MainAxisAlignment.start : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "$priceđ",
                                      textAlign: TextAlign.left,
                                      style: textStyleSpan.copyWith(
                                        color: ColorResources.PRIMARY_4,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // if (isShowCart) const Spacer(),
                        if (isShowCart)
                          Container(
                            constraints: BoxConstraints(
                              minWidth: IZIDimensions.ONE_UNIT_SIZE * 150,
                            ),
                            child: IZIInput(
                              controller: controller,
                              type: IZIInputType.INCREMENT,
                              width: IZIDimensions.ONE_UNIT_SIZE * 70,
                              // miniSize: true,
                              initValue: amount.toString(),
                              onChanged: (val) {
                                if (!IZIValidate.nullOrEmpty(onChanged)) {
                                  onChanged!(val);
                                }
                              },
                              max: 100,
                              min: 0,
                              widthIncrement: IZIDimensions.ONE_UNIT_SIZE * 40,
                              height: IZIDimensions.ONE_UNIT_SIZE * 40,
                              fillColor: ColorResources.NEUTRALS_7,
                              colorBorder: ColorResources.NEUTRALS_2,
                              style: textStyleH6.copyWith(
                                color: ColorResources.NEUTRALS_1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isShowDivider) const Divider(),
        ],
      ),
    );
  }
}
