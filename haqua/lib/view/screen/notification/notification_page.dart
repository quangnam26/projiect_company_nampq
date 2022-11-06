import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/notification/notification_controller.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundApp(),
        appBar: GetBuilder(
            init: NotificationController(),
            builder: (NotificationController controller) {
              return IZIAppBar(
                title: 'Notify'.tr,
                colorTitle: ColorResources.WHITE,
                widthActions: IZIDimensions.ONE_UNIT_SIZE * 150,
                widthIconBack: IZIDimensions.ONE_UNIT_SIZE * 350,
                iconBack: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.WHITE,
                    size: IZIDimensions.ONE_UNIT_SIZE * 45,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      controller.showReadAllNoticesDialog();
                    },
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                      color: ColorResources.WHITE,
                    ),
                  )
                ],
              );
            }),
        body: Container(
          color: ColorResources.BACKGROUND,
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: GetBuilder(
            init: NotificationController(),
            builder: (NotificationController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              } else {
                return Obx(
                  () => IZISmartRefresher(
                    refreshController: controller.refreshController,
                    onLoading: controller.onLoadingData,
                    onRefresh: controller.onRefreshData,
                    enablePullDown: true,
                    enablePullUp: true,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.notificationResponseList.length,
                      itemBuilder: (context, index) {
                        if (controller.notificationResponseList.isEmpty) {
                          return Text(
                            "No_data".tr,
                          );
                        }
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.goToDetailsNotice(typeQuestion: controller.notificationResponseList[index].typeNotification!, index: index);
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                  IZIDimensions.SPACE_SIZE_1X,
                                ),
                                width: IZIDimensions.iziSize.width,
                                color: controller.notificationResponseList[index].isRead == false ? ColorResources.PRIMARY_LIGHT_APP.withOpacity(.2) : ColorResources.WHITE,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: IZIDimensions.SPACE_SIZE_2X,
                                      ),
                                      width: IZIDimensions.ONE_UNIT_SIZE * 100,
                                      height: IZIDimensions.ONE_UNIT_SIZE * 100,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                IZIDimensions.BLUR_RADIUS_3X,
                                              ),
                                              child: IZIImage(
                                                controller.genAvatarNotice(
                                                  typeNotification: controller.notificationResponseList[index].typeNotification!,
                                                ),
                                                width: IZIDimensions.ONE_UNIT_SIZE * 90,
                                                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                                              ),
                                            ),
                                          ),
                                          if (controller.notificationResponseList[index].isRead == false)
                                            Positioned(
                                              right: 0,
                                              top: -IZIDimensions.ONE_UNIT_SIZE * 5,
                                              child: Icon(
                                                Icons.fiber_manual_record_rounded,
                                                size: IZIDimensions.ONE_UNIT_SIZE * 30,
                                                color: ColorResources.RED,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: IZIDimensions.SPACE_SIZE_1X * .5,
                                              top: IZIDimensions.SPACE_SIZE_1X,
                                            ),
                                            child: Text(
                                              controller.notificationResponseList[index].title.toString(),
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                fontWeight: FontWeight.w600,
                                                color: ColorResources.BLACK,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: IZIDimensions.SPACE_SIZE_1X * .5,
                                            ),
                                            child: Text(
                                              controller.notificationResponseList[index].summary.toString(),
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_SPAN * .9,
                                                color: ColorResources.BLACK,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                timeAgo.format(controller.notificationResponseList[index].createdAt!, locale: controller.genValueLocale()),
                                                style: TextStyle(
                                                  fontSize: IZIDimensions.FONT_SIZE_SPAN * .9,
                                                  color: ColorResources.BLACK,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              width: IZIDimensions.iziSize.width,
                              height: IZIDimensions.ONE_UNIT_SIZE * .5,
                              color: ColorResources.BLACK.withOpacity(.5),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
