import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/notification/notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: const IZIAppBar(
        title: "Thông báo",
        colorTitle: ColorResources.WHITE,
      ),
      background: const BackgroundAppBar(),
      isSingleChildScrollView: false,
      body: GetBuilder<NotificationController>(builder: (notifiCtrl) {
        return SizedBox(
          height: IZIDimensions.iziSize.height,
          width: IZIDimensions.iziSize.width,
          child: Obx(() {
            if (notifiCtrl.notificationResponse.isEmpty) {
              return spinKitWave;
            }
            return SizedBox(
              child: SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.onRefresh(),
                onLoading: () => controller.onLoading(),
                enablePullUp: true,
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
                  idleText: "Kéo lên để tải thêm dữ liệu",
                ),
                child: SingleChildScrollView(
                    child: IZIListView(
                  itemCount: notifiCtrl.notificationResponse.length,
                  builder: (index) {
                    return GestureDetector(
                      onTap: () => notifiCtrl.onClickNotification(
                          notifiCtrl.notificationResponse[index]),
                      child: Padding(
                          padding: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.ONE_UNIT_SIZE * 10),
                                color: notifiCtrl.onCheckIsRead(
                                        IZIValidate.nullOrEmpty(notifiCtrl
                                                .notificationResponse[index]
                                                .reads)
                                            ? []
                                            : notifiCtrl
                                                .notificationResponse[index]
                                                .reads!)
                                    ? ColorResources.WHITE
                                    : ColorResources.RED.withOpacity(0.05)),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: IZIDimensions.SPACE_SIZE_1X,
                                        left: IZIDimensions.SPACE_SIZE_1X),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        IZIDimensions.ONE_UNIT_SIZE * 10,
                                      ),
                                      child: SizedBox(
                                        width:
                                            IZIDimensions.ONE_UNIT_SIZE * 140,
                                        height:
                                            IZIDimensions.ONE_UNIT_SIZE * 140,
                                        child: IZIValidate.nullOrEmpty(
                                                controller
                                                    .notificationResponse[index]
                                                    .thumbnail)
                                            ? Image.asset(
                                                ImagesPath.logo_app,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                controller
                                                    .notificationResponse[index]
                                                    .thumbnail
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: IZIDimensions
                                                    .SPACE_SIZE_1X),
                                            child: IZIText(
                                              text: IZIValidate.nullOrEmpty(
                                                      controller
                                                          .notificationResponse[
                                                              index]
                                                          .title)
                                                  ? ''
                                                  : controller
                                                      .notificationResponse[
                                                          index]
                                                      .title
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_SPAN,
                                                  color:
                                                      ColorResources.PRIMARY_2),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  IZIDimensions.SPACE_SIZE_2X),
                                          child: IZIText(
                                            maxLine: 3,
                                            text: IZIValidate.nullOrEmpty(
                                                    controller
                                                        .notificationResponse[
                                                            index]
                                                        .content)
                                                ? ''
                                                : controller
                                                    .notificationResponse[index]
                                                    .content
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: IZIDimensions
                                                    .FONT_SIZE_SPAN),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: IZIDimensions
                                                      .SPACE_SIZE_2X),
                                              child: IZIText(
                                                text: !IZIValidate.nullOrEmpty(
                                                        notifiCtrl
                                                            .notificationResponse[
                                                                index]
                                                            .createdAt)
                                                    ? IZIDate.formatDate(
                                                        IZIDate.parse(notifiCtrl
                                                            .notificationResponse[
                                                                index]
                                                            .createdAt!),
                                                      )
                                                    : "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: IZIDimensions
                                                        .FONT_SIZE_SPAN,
                                                    color: ColorResources
                                                        .ADDRESS_ORDER),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          // Material(
                          //   child: ListTile(
                          //     contentPadding: EdgeInsets.all(
                          //       IZIDimensions.SPACE_SIZE_4X,
                          //     ),
                          //     tileColor: controller.onCheckIsRead(
                          //             IZIValidate.nullOrEmpty(notifiCtrl
                          //                     .notificationResponse[index].reads)
                          //                 ? []
                          //                 : notifiCtrl
                          //                     .notificationResponse[index].reads!)
                          //         ? ColorResources.WHITE
                          //         : ColorResources.RED.withOpacity(0.05),
                          //     leading: Container(
                          //       margin: EdgeInsets.only(
                          //           right: IZIDimensions.SPACE_SIZE_2X),
                          //       child: !IZIValidate.nullOrEmpty(notifiCtrl
                          //               .notificationResponse[index].thumbnail)
                          //           ? IZIImage(notifiCtrl
                          //               .notificationResponse[index].thumbnail!)
                          //           : const SizedBox(),
                          //     ),
                          //     title: Container(
                          //       margin: EdgeInsets.only(
                          //           bottom: IZIDimensions.SPACE_SIZE_1X),
                          //       child: IZIText(
                          //         text: !IZIValidate.nullOrEmpty(notifiCtrl
                          //                 .notificationResponse[index].title)
                          //             ? notifiCtrl
                          //                 .notificationResponse[index].title!
                          //             : "",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w700,
                          //             fontSize: IZIDimensions.FONT_SIZE_H6),
                          //       ),
                          //     ),
                          //     subtitle: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Container(
                          //           margin: EdgeInsets.only(
                          //               bottom: IZIDimensions.SPACE_SIZE_1X),
                          //           child: IZIText(
                          //             maxLine: 3,
                          //             text: !IZIValidate.nullOrEmpty(notifiCtrl
                          //                     .notificationResponse[index]
                          //                     .summary)
                          //                 ? notifiCtrl.notificationResponse[index]
                          //                     .summary!
                          //                 : "",
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.w400,
                          //                 fontSize: IZIDimensions.FONT_SIZE_SPAN),
                          //           ),
                          //         ),
                          //         IZIText(
                          //           text: !IZIValidate.nullOrEmpty(notifiCtrl
                          //                   .notificationResponse[index]
                          //                   .createdAt)
                          //               ? IZIDate.formatDate(IZIDate.parse(
                          //                   notifiCtrl.notificationResponse[index]
                          //                       .createdAt!))
                          //               : "",
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: IZIDimensions.FONT_SIZE_SPAN),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          ),
                    );
                  },
                )),
              ),
            );
          }),
        );
      }),
    );
  }
}
