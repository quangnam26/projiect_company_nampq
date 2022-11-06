import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/thousands_separator_input_formatter_currency.dart';
import 'package:template/view/screen/share_video/share_video_controller.dart';

class ShareVideoPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundApp(),
        appBar: const IZIAppBar(
          title: "Share video",
        ),
        body: GetBuilder(
          init: ShareVideoController(),
          builder: (ShareVideoController controller) {
            if (controller.isLoading) {
              return Center(
                child: IZILoading().isLoadingKit,
              );
            }
            return Container(
              color: ColorResources.BACKGROUND,
              width: IZIDimensions.iziSize.width,
              child: Column(
                children: [
                  //_priceGuestShare
                  if (controller.questionResponse!.partnerSharePrice != -1) _priceGuestShare(controller),
                  //_priceUserRequest
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      IZIDimensions.SPACE_SIZE_2X,
                      IZIDimensions.SPACE_SIZE_5X,
                      IZIDimensions.SPACE_SIZE_2X,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Giá video bạn muốn chia sẻ",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.RED,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          width: IZIDimensions.iziSize.width,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            border: Border.all(
                              color: ColorResources.PRIMARY_APP,
                            ),
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BLUR_RADIUS_3X,
                            ),
                          ),
                          child: TextField(
                            controller: controller.moneyRechargeController,
                            onChanged: (val) {
                              controller.onChangedValueAmount(val);
                            },
                            inputFormatters: [
                              ThousandsSeparatorInputFormatterCurrency(),
                            ],
                            focusNode: controller.focusNodeInput,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: '0',
                              contentPadding: EdgeInsets.fromLTRB(
                                IZIDimensions.SPACE_SIZE_3X,
                                IZIDimensions.SPACE_SIZE_3X,
                                IZIDimensions.SPACE_SIZE_3X,
                                0,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'VNĐ',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                      fontWeight: FontWeight.w400,
                                      color: ColorResources.BLACK,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (!IZIValidate.nullOrEmpty(controller.errorTextMoneyShare))
                          Container(
                            margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                            alignment: Alignment.topLeft,
                            child: Text(
                              controller.errorTextMoneyShare!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: ColorResources.RED,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_5X,
                    ),
                    child: Text(
                      "Giá phí cho người xem sẽ bằng trung bình giá của 2 bạn đưa ra",
                      style: TextStyle(
                        color: ColorResources.RED,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        widgetBottomSheet: GetBuilder(
          init: ShareVideoController(),
          builder: (ShareVideoController controller) {
            if (controller.isLoading) {
              return Center(
                child: IZILoading().isLoadingKit,
              );
            }

            return SizedBox(
              width: IZIDimensions.iziSize.width,
              height: controller.isFocus == true ? IZIDimensions.iziSize.height * .13 : IZIDimensions.iziSize.height * .08,
              child: Column(
                children: [
                  IZIButton(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    onTap: () {
                      controller.goToShareVideoSuccessfullyPage();
                    },
                    isEnabled: controller.genBoolButton(),
                    label: "Tiếp tục",
                  ),
                  if (controller.isFocus == true)
                    Container(
                      margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(
                            controller.defaultAmountList.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.setDefaultAmount(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: IZIDimensions.SPACE_SIZE_2X,
                                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorResources.PRIMARY_LIGHT_APP.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X,
                                    ),
                                    border: Border.all(
                                      color: ColorResources.PRIMARY_APP,
                                      width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.defaultAmountList[index].toString())),
                                      style: TextStyle(
                                        color: ColorResources.BLACK,
                                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  else
                    const SizedBox()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// Mức giá khách hàng chia sẻ:
  ///
  Container _priceGuestShare(ShareVideoController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_1X,
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Text(
        'Mức giá khách hàng chia sẻ: ${controller.questionResponse!.partnerSharePrice! >= 0 ? IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponse!.mySharePrice.toString())) : 0} VNĐ',
        style: TextStyle(
          color: ColorResources.BLACK,
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
