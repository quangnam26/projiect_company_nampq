import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/view/screen/notification/notification_controller.dart';
import '../../../../../helper/izi_dimensions.dart';
import '../../../../../utils/color_resources.dart';
import '../../../base_widget/background/backround_appbar.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../base_widget/izi_text.dart';
import '../../../helper/izi_date.dart';
import '../../../helper/izi_validate.dart';
import 'package:html/parser.dart' show parse;

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      safeAreaBottom: false,
      appBar: IZIAppBar(
        title: 'Thông báo',
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
        init: NotificationController(),
        builder: (NotificationController controller) {
          return Column(
            children: [
              const Divider(height: 5, color: ColorResources.ORDER_DANG_GIAO),
              Expanded(
                child: Container(
                  color: ColorResources.NEUTRALS_11,
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
                        canTwoLevelText: "thả ra để làm mới dữ liệu"),
                    footer: const ClassicFooter(
                        loadingText: "đang tải",
                        noDataText: "không có thêm dữ liệu",
                        canLoadingText: "kéo lên để tải thêm dữ liệu",
                        failedText: "tải thêm dữ liệu bị lỗi",
                        idleText: "kéo lên để tải thêm dữ liệu"),
                    child: controller.listNotification.isEmpty
                        ? SizedBox(
                            height: IZIDimensions.iziSize.height * 0.7,
                            child: Center(
                              child: Text(
                                'Không có dữ liệu',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: ColorResources.NEUTRALS_5,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.listNotification.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.onClickNotification(
                                      controller.listNotification[index]);
                                  // print("object$ ")
                                },
                                child: Container(
                                  // ignore: unrelated_type_equality_checks
                                  color: controller.onCheckIsRead(
                                    IZIValidate.nullOrEmpty(controller
                                            .listNotification[index].reads)
                                        ? []
                                        : controller
                                            .listNotification[index].reads!,
                                  )
                                      ? ColorResources.WHITE
                                      : ColorResources.RED.withOpacity(
                                          0.05,
                                        ),
                                  margin: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: IZIDimensions.SPACE_SIZE_4X *
                                                2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.orange)),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    10),
                                            child: IZIImage(
                                              // '',
                                              controller.genAvatarNotice(
                                                  typeNotification: controller
                                                      .listNotification[index]
                                                      .typeNotification!),
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      30,
                                              width:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: IZIDimensions.SPACE_SIZE_4X,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: IZIDimensions
                                                      .SPACE_SIZE_4X),
                                              child: IZIText(
                                                text: parse(controller
                                                        .listNotification[index]
                                                        .title)
                                                    .documentElement!
                                                    .text,
                                                style: TextStyle(
                                                    fontSize: IZIDimensions
                                                            .FONT_SIZE_H6 *
                                                        0.9,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorResources
                                                        .COLOR_BLACK_TEXT),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  IZIDimensions.SPACE_SIZE_2X *
                                                      2,
                                            ),
                                            IZIText(
                                              text: parse(controller
                                                          .listNotification[
                                                              index]
                                                          .content ??
                                                      "không có dữ liệu")
                                                  .documentElement!
                                                  .text,
                                              style: TextStyle(
                                                  fontFamily: 'roboto',
                                                  fontSize: IZIDimensions
                                                          .FONT_SIZE_H6 *
                                                      0.9,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorResources.PRIMARY_8),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: IZIDimensions
                                                      .SPACE_SIZE_2X,
                                                  bottom: IZIDimensions
                                                      .SPACE_SIZE_2X),
                                              child: Row(
                                                children: [
                                                  const Spacer(),
                                                  const Icon(
                                                    CupertinoIcons.calendar,
                                                    color: ColorResources.GREY,
                                                    size: 25,
                                                  ),
                                                  SizedBox(
                                                    width: IZIDimensions
                                                        .SPACE_SIZE_1X,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: IZIDimensions
                                                            .SPACE_SIZE_3X),
                                                    child: Text(
                                                      IZIDate.dateFormatUtc(
                                                          controller
                                                              .listNotification[
                                                                  index]
                                                              .createdAt!),
                                                      style: TextStyle(
                                                          fontFamily: 'roboto',
                                                          fontSize: IZIDimensions
                                                                  .FONT_SIZE_H6 *
                                                              0.9,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorResources
                                                              .NEUTRALS_17),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
