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
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/utils/thousands_separator_input_formatter_currency.dart';
import 'package:template/view/screen/quotation_list/share/request_share/request_share_controller.dart';

import '../../../../../base_widget/izi_image.dart';

class RequestSharePage extends GetView<RequestShareController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: IZIScreen(
        background: const BackgroundApp(),
        isSingleChildScrollView: false,
        appBar: const IZIAppBar(
          title: 'Yêu cầu chia sẻ ',
        ),
        body: SizedBox(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: GetBuilder<RequestShareController>(
            init: RequestShareController(),
            builder: (RequestShareController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              return Padding(
                padding: EdgeInsets.only(
                  left: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  right: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  top: IZIDimensions.SPACE_SIZE_1X,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //_priceGuestShare
                      if (controller.questionResponse!.mySharePrice != -1) _priceGuestShare(),

                      //_priceUserRequest
                      Column(
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

                      Container(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.ONE_UNIT_SIZE * 20,
                          0,
                          IZIDimensions.ONE_UNIT_SIZE * 20,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Text(
                          "Lưu ý: Bạn có thể chia sẻ  cuộc nói chuyện này cho mọi người cùng xem để có cơ hội kiếm thêm thu nhập không",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            color: ColorResources.BLACK,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (controller.isMore == false)
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.onChangeIsMore();
                                },
                                child: Text(
                                  "Xem hướng dẫn chi tiết",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.CALL_VIDEO,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (controller.isMore == true)
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            IZIDimensions.ONE_UNIT_SIZE * 20,
                            0,
                            IZIDimensions.ONE_UNIT_SIZE * 20,
                            IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Text(
                            "Với điều kiện video của bạn đảm bảo các quy định hiện hành của pháp luật, nội quy của app, không truyền tải các thông điệp mang tính bạo động, Bạn có thể chia sẻ video lên hệ thống, Người dùng khác có thể trả phí để được xem video này, Phí người dùng trả hệ thống sẽ giữ 20% Duy trì lưu trữ, 80% còn lại sẽ chia đều cho 2 bạn.\n\nGiá cho mỗi lượt xem video sẽ bằng mức giá trung bình của 2 người sở hữu video đó.",
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              color: ColorResources.BLACK,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (controller.isMore == true)
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            IZIDimensions.ONE_UNIT_SIZE * 20,
                            0,
                            IZIDimensions.ONE_UNIT_SIZE * 20,
                            IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  "Các bước share video",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  "Bước 1:  Vào video đã thực hiện cuộc gọi  Ấn vào nút chia sẻ video ở cuối màn hình",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IZIImage(
                                      ImagesPath.image_share_video,
                                      width: IZIDimensions.iziSize.width * .6,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_5X,
                                ),
                                child: Text(
                                  "Bước 2: Thực hiện báo giá share và đợi tài khoản bên kia xác nhận. Giá video sẽ bằng giá trung bình giữa 2 tài khoản",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.onChangeIsMore();
                                      },
                                      child: Text(
                                        "Thu gọn",
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          color: ColorResources.CALL_VIDEO,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(
                        width: IZIDimensions.iziSize.width,
                        height: SPACE_BOTTOM_SHEET,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        widgetBottomSheet: GetBuilder(
          init: RequestShareController(),
          builder: (RequestShareController controller) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IZIButton(
                        margin: EdgeInsets.zero,
                        width: IZIDimensions.iziSize.width * .45,
                        type: IZIButtonType.OUTLINE,
                        onTap: () {
                          Get.back();
                        },
                        label: "Từ chối",
                      ),
                      IZIButton(
                        margin: EdgeInsets.zero,
                        isEnabled: controller.genBoolButton(),
                        width: IZIDimensions.iziSize.width * .45,
                        onTap: () {
                          controller.confirmShareVideo();
                        },
                        label: "Đồng ý",
                      ),
                    ],
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
  Container _priceGuestShare() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_1X,
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Text(
        'Mức giá khách hàng chia sẻ: ${controller.questionResponse!.mySharePrice! >= 0 ? IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponse!.mySharePrice.toString())) : 0} VNĐ',
        style: TextStyle(
          color: ColorResources.BLACK,
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
