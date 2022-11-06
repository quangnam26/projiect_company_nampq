import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/message/message_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/chat/animations/jump_dot.dart';
import 'package:template/view/screen/chat/chat_controller.dart';

class ChatPage extends GetView<ChatController> {
  ///
  /// App bar widget.
  ///
  Widget appbarWidget() {
    return Container(
      alignment: Alignment.center,
      height: IZIDimensions.ONE_UNIT_SIZE * 150,
      color: ColorResources.WHITE,
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 70,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.BLACK,
                    size: 25,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: IZIImage(
                  "assets/images/image Product (1).png",
                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                  width: IZIDimensions.ONE_UNIT_SIZE * 60,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Admin",
                    style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6, color: ColorResources.BLACK, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        "online",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                        ),
                      ),
                      SizedBox(width: IZIDimensions.SPACE_SIZE_1X),
                      Container(
                        height: IZIDimensions.ONE_UNIT_SIZE * 15,
                        width: IZIDimensions.ONE_UNIT_SIZE * 15,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorResources.GREEN),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// List view Builder.
  ///
  ValueListenableBuilder messages() {
    return ValueListenableBuilder<List<MessageResponse>>(
      valueListenable: controller.messages,
      builder: (context, List<MessageResponse> values, child) {
        return ListView.builder(
          padding: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_3X * 5,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: values.length,
          reverse: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Obx(() {
                return controller.isEnteringMessage.isTrue
                    ? Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            width: 15 * 5,
                            margin: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_2X,
                              right: IZIDimensions.SPACE_SIZE_2X,
                              bottom: IZIDimensions.SPACE_SIZE_4X,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  bottomRight: Radius.circular(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  topLeft: Radius.circular(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                ),
                                color: ColorResources.NEUTRALS_5.withOpacity(0.5)),
                            child: Padding(
                              padding: EdgeInsets.all(
                                IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: const JumpingDotsProgressIndicator(
                                numberOfDots: 3,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox();
              });
            }
            return Column(
              crossAxisAlignment:
                  controller.isOwner(message: values[index]) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: controller.isOwner(message: values[index]) ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: Container(
                    width: IZIDimensions.iziSize.width / 2.3,
                    margin: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_2X,
                    ),
                    decoration: !IZIValidate.nullOrEmpty(values[index].images)
                        ? null
                        : controller.isOwner(message: values[index])
                            ? BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  topLeft: Radius.circular(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  bottomLeft: Radius.circular(
                                    IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                ),
                                color: ColorResources.ORANGE2)
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  IZIDimensions.BLUR_RADIUS_2X,
                                ),
                                color: ColorResources.NEUTRALS_17,
                              ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_3X,
                      ),
                      child: !IZIValidate.nullOrEmpty(values[index].images)
                          ? SizedBox(
                              child: Column(
                                children: [
                                  ...values[index].images!.map(
                                    (e) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                          bottom: values[index].images?.indexOf(e) == (values[index].images!.length - 1)
                                              ? 0
                                              : IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        height: IZIDimensions.iziSize.width / 2.3,
                                        width: IZIDimensions.iziSize.width / 2.3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          child: IZIImage(
                                            e,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          : Text(
                              values[index].content.toString(),
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                fontWeight: FontWeight.w300,
                                color: controller.isOwner(message: values[index])
                                    ? ColorResources.WHITE
                                    : ColorResources.BLACK,
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: controller.isOwner(message: values[index])
                      ? EdgeInsets.only(
                          right: IZIDimensions.SPACE_SIZE_2X,
                        )
                      : EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_2X,
                        ),
                  child: Text(
                    controller.messageHour(context: context, message: values[index]),
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 0.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                )
              ],
            );
          },
        );
      },
    );
  }

  ///
  /// Form enter a message.
  ///
  Container messageForm() {
    return Container(
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
      ),
      height: IZIDimensions.ONE_UNIT_SIZE * 120,
      child: Padding(
        padding: EdgeInsets.only(
          top: IZIDimensions.SPACE_SIZE_1X,
          bottom: IZIDimensions.SPACE_SIZE_1X,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Obx(() {
            //   return controller.isEnteringMessage.isTrue ? const JumpingDotsProgressIndicator(numberOfDots: 3) : const SizedBox();
            // }),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: const Icon(
                      Icons.add,
                      size: 32,
                      color: ColorResources.NEUTRALS_4,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: IZIInput(
                    controller: controller.messageController,
                    type: IZIInputType.TEXT,
                    placeHolder: '',
                    borderRadius: 50,
                    fillColor: ColorResources.NEUTRALS_6,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w100,
                      color: ColorResources.BLACK,
                    ),
                    onChanged: (String message) {
                      controller.message = message;
                      controller.onChangeSend(message: message);
                      controller.onChangeIndicator(message: message);
                    },
                    onSubmitted: <String>(String? message) {
                      controller.createMessageForConversation();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.createMessageForConversation();
                    },
                    child: Obx(() {
                      return Icon(
                        Icons.send_rounded,
                        size: 32,
                        color: controller.isSend.isTrue ? Colors.blue : ColorResources.NEUTRALS_4,
                      );
                    }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      safeAreaTop: false,
      background: Container(
        color: ColorResources.WHITE,
      ),
      appBar: appbarWidget(), // App bar
      body: GetBuilder(
        init: ChatController(),
        builder: (ChatController controller) {
          return GestureDetector(
            onTap: () {
              IZIOther.primaryFocus();
            },
            child: Container(
              color: ColorResources.WHITE,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    height: 3,
                    color: ColorResources.ORDER_DANG_GIAO,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SmartRefresher(
                      primary: true,
                      onRefresh: () {
                        controller.onLoading();
                      },
                      onLoading: () {
                        controller.onLoading();
                      },
                      controller: controller.refreshController,
                      enablePullUp: true,
                      enablePullDown: false,
                      reverse: true,
                      header: const ClassicHeader(
                        idleText: "Kéo xuống để làm mới",
                        releaseText: "Thả ra để làm mới dữ liệu",
                        completeText: "Làm mới dữ liệu thành công",
                        refreshingText: "Đang làm mới dữ liệu",
                        failedText: "Làm mới dữ liệu bị lỗi",
                        canTwoLevelText: "Thả ra để làm mới",
                      ),
                      footer: const ClassicFooter(
                        loadingText: "Đang tải...",
                        noDataText: "Không có dữ liệu",
                        canLoadingText: "Kéo lên để tải thêm dữ liệu",
                        failedText: "Tải thêm dữ liệu bị lỗi",
                        idleText: "Kéo lên để tải thêm dữ liệu",
                      ),
                      physics: const ClampingScrollPhysics(),
                      child: SingleChildScrollView(
                        child: messages(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      widgetBottomSheet: messageForm(), // Enter message the form.
    );
  }
}
