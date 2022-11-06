import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/huntingvouchers/hunting_vouchers_controller.dart';
import '../../../base_widget/background/backround_appbar.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_text.dart';

class HuntingVoucherPage extends GetView<HuntingVouchersController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: 'Săn Voucher',
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: IZIValidate.nullOrEmpty(Get.arguments)
              ? const SizedBox()
              : const Icon(
                  Icons.arrow_back_ios,
                  color: ColorResources.NEUTRALS_3,
                  size: 25,
                ),
        ),
      ),
      body: GetBuilder(
        init: HuntingVouchersController(),
        builder: (HuntingVouchersController controller) {
          if (controller.isloading) {
            return SizedBox(
              height: IZIDimensions.iziSize.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.ORANGE,
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  // enablePullDown: true,
                  header: const ClassicHeader(
                    idleText: "Kéo xuống để làm mới dữ liệu",
                    releaseText: "Thả ra để làm mới dữ liệu",
                    completeText: "Làm mới dữ liệu thành công",
                    refreshingText: "Đang làm mới dữ liệu",
                    failedText: "Làm mới dữ liệu bị lỗi",
                    canTwoLevelText: "Thả ra để làm mới dữ liệu",
                  ),
                  footer: const ClassicFooter(
                    loadingText: "Đang tải...",
                    noDataText: "Không có thêm dữ liệu",
                    canLoadingText: "Kéo lên để tải thêm dữ liệu",
                    failedText: "Tải thêm dữ liệu bị lỗi",
                    idleText: "",
                    idleIcon: null,
                  ),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.listVoucherResponse.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X),
                          color: ColorResources.WHITE,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: IZIDimensions.SPACE_SIZE_2X),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: IZIDimensions.SPACE_SIZE_2X,
                                        bottom: IZIDimensions.SPACE_SIZE_2X,
                                        right: IZIDimensions.SPACE_SIZE_4X,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            IZIDimensions.BLUR_RADIUS_2X),
                                        child: IZIImage(
                                          controller.listVoucherResponse[index]
                                                  .image ??
                                              "",
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 120,
                                          width:
                                              IZIDimensions.ONE_UNIT_SIZE * 110,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        // "sdas",
                                        controller.listVoucherResponse[index]
                                                .description ??
                                            "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_H5 *
                                                    0.8,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: IZIDimensions.SPACE_SIZE_2X,
                                            bottom: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                          child: Center(
                                            child: IZIText(
                                              text:
                                                  "Giảm ${controller.listVoucherResponse[index].discountPercent ?? ""}",
                                              style: TextStyle(
                                                  fontSize: IZIDimensions
                                                          .FONT_SIZE_H6 *
                                                      0.7,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        IZIText(
                                          text:
                                              "Đơn trên ${controller.listVoucherResponse[index].maxDiscountAmount ?? ""}",
                                          style: TextStyle(
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_H6 *
                                                    0.7,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.ontapSave(controller
                                                .listVoucherResponse[index]);
                                            print(
                                                "voucher12212 ${controller.listVoucherResponse[index].users!.contains(controller.userId)}");

                                            print(
                                                'ádsadsad ${controller.listVoucherResponse[index].users!.contains(controller.userId)}');
                                          },
                                          child: Container(
                                            color: controller
                                                    .listVoucherResponse[index]
                                                    .users!
                                                    .contains(controller.userId)
                                                ? ColorResources.GREY
                                                : ColorResources.RED,
                                            margin: EdgeInsets.only(
                                                top:
                                                    IZIDimensions.SPACE_SIZE_1X,
                                                bottom: IZIDimensions
                                                    .SPACE_SIZE_3X),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: IZIDimensions
                                                      .SPACE_SIZE_5X,
                                                  vertical: IZIDimensions
                                                      .SPACE_SIZE_3X),
                                              child: IZIText(
                                                text: "Lưu",
                                                style: TextStyle(
                                                  fontSize: IZIDimensions
                                                          .FONT_SIZE_H6 *
                                                      0.8,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorResources.WHITE,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
