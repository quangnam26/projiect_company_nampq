import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/cart/choosevoucher/choose_voucher_controller.dart';
import '../../../../../utils/color_resources.dart';

class ChooseVoucherPage extends GetView<ChooseVoucherController> {
  // final price = Get.arguments as int;

  @override
  Widget build(BuildContext context) {
    // print("abc1 $price");
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Voucher',
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_3,
          ),
        ),
      ),
      body: GetBuilder(
        init: ChooseVoucherController(),
        builder: (ChooseVoucherController controller) {
          return Container(
            color: ColorResources.NEUTRALS_6,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
                        child: IZIInput(
                          borderRadius: 5,
                          hintStyle: const TextStyle(
                              color: ColorResources.NEUTRALS_5,
                              fontWeight: FontWeight.w400),
                          type: IZIInputType.TEXT,
                          placeHolder: 'Nhập mã voucher tại đây',
                          fillColor: ColorResources.WHITE,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              controller.code = int.parse(val);
                            } else {
                              controller.code = null;
                              controller.searchVoucherByCode();
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_3X,
                          right: IZIDimensions.SPACE_SIZE_3X,
                          top: IZIDimensions.SPACE_SIZE_2X,
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: IZIButton(
                          borderRadius: 0,
                          onTap: () {
                            controller.searchVoucherByCode();
                          },
                          label: 'Tìm kiếm',
                          colorBG: ColorResources.ORANGE,
                          fontSizedLabel: IZIDimensions.FONT_SIZE_H6 * 0.8,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () {
                      controller.onRefreshData();
                    },
                    onLoading: () {
                      controller.onLoadingData();
                    },
                    enablePullUp: true,
                    header: const ClassicHeader(
                      idleText: "kéo xuống để làm mới dữ liệu",
                      releaseText: "thả ra để làm mới dữ liệu",
                      completeText: "làm mới dữ liệu thành công",
                      refreshingText: "đang làm mới dữ liệu",
                      failedText: "làm mới dữ liệu bị lỗi",
                      canTwoLevelText: "thả ra để làm mới dữ liệu",
                    ),
                    footer: const ClassicFooter(
                      loadingText: "đang tải",
                      noDataText: "không có thêm dữ liệu",
                      canLoadingText: "kéo lên để tải thêm dữ liệu",
                      failedText: "tải thêm dữ liệu bị lỗi",
                      idleText: "kéo lên để tải thêm dữ liệu",
                    ),
                    child: controller.listVoucher.isEmpty
                        ? SizedBox(
                            height: IZIDimensions.iziSize.height * 0.65,
                            child: Center(
                              child: Text(
                                "Không có dữ liệu",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H5,
                                  color: ColorResources.NEUTRALS_5,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X * 5,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.listVoucher.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_3X),
                                color: ColorResources.WHITE,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: IZIDimensions.SPACE_SIZE_2X,
                                            bottom: IZIDimensions.SPACE_SIZE_2X,
                                            left: IZIDimensions.SPACE_SIZE_4X,
                                            right: IZIDimensions.SPACE_SIZE_4X,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                IZIDimensions.BLUR_RADIUS_2X),
                                            child: IZIImage(
                                              controller
                                                  .listVoucher[index].image
                                                  .toString(),
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      100,
                                              width:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      100,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            controller.listVoucher[index].name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6 *
                                                        0.9,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: IZIDimensions
                                                      .SPACE_SIZE_2X,
                                                  // bottom: IZIDimensions.SPACE_SIZE_2X,
                                                  right: IZIDimensions
                                                      .SPACE_SIZE_2X),
                                              child: Text(
                                                '${controller.listVoucher[index].discountPercent.toString()}%',
                                                style: TextStyle(
                                                    fontSize: IZIDimensions
                                                            .FONT_SIZE_H6 *
                                                        0.8,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            ValueListenableBuilder<
                                                VoucherResponse>(
                                              valueListenable:
                                                  controller.voucher,
                                              builder: (context, value, child) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: controller
                                                              .conditionApplyVoucher(
                                                                  voucher: controller
                                                                          .listVoucher[
                                                                      index])
                                                          ? ColorResources
                                                              .NEUTRALS_4
                                                          : ColorResources.RED,
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    top: IZIDimensions
                                                        .SPACE_SIZE_1X,
                                                    bottom: IZIDimensions
                                                        .SPACE_SIZE_3X,
                                                    right: IZIDimensions
                                                        .SPACE_SIZE_2X,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: IZIDimensions
                                                          .SPACE_SIZE_2X,
                                                      vertical: IZIDimensions
                                                          .SPACE_SIZE_2X,
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller.selectVoucher(
                                                            voucher: controller
                                                                    .listVoucher[
                                                                index]);
                                                      },
                                                      child: Text(
                                                        value.id !=
                                                                controller
                                                                    .listVoucher[
                                                                        index]
                                                                    .id
                                                            ? "Dùng ngay"
                                                            : "Huỷ",
                                                        style: TextStyle(
                                                          fontSize: IZIDimensions
                                                                  .FONT_SIZE_H6 *
                                                              0.8,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: controller.conditionApplyVoucher(
                                                                  voucher: controller
                                                                          .listVoucher[
                                                                      index])
                                                              ? ColorResources
                                                                  .NEUTRALS_4
                                                              : ColorResources
                                                                  .RED,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      widgetBottomSheet: IZIButton(
        margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
            vertical: IZIDimensions.SPACE_SIZE_3X),
        borderRadius: 10,
        onTap: () {
          controller.onApplyVoucher();
        },
        label: 'Hoàn Thành',
        colorBG: ColorResources.ORANGE,
      ),
    );
  }
}
