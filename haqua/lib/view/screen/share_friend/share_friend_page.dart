import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/share_friend/share_friend_controller.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../base_widget/izi_loading.dart';
import '../../../base_widget/izi_screen.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../utils/color_resources.dart';

class ShareFriendPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: "title_share_friend_page_1".tr,
        colorIconBack: ColorResources.BLACK,
        colorTitle: ColorResources.PRIMARY_APP,
        iconBack: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.PRIMARY_APP,
            size: IZIDimensions.ONE_UNIT_SIZE * 45,
          ),
        ),
      ),
      body: GetBuilder(
        init: ShareFriendController(),
        builder: (ShareFriendController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: Stack(
              children: [
                IZIImage(
                  ImagesPath.share_friend_page,
                  width: IZIDimensions.iziSize.width,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          IZIDimensions.ONE_UNIT_SIZE * 70,
                        ),
                        topRight: Radius.circular(
                          IZIDimensions.ONE_UNIT_SIZE * 70,
                        ),
                      ),
                    ),
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.iziSize.height * .52,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                            top: IZIDimensions.iziSize.height * .06,
                          ),
                          child: Text(
                            "title_share_friend_page_2".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.BLACK,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: Text(
                            "title_share_friend_page_3".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: IZIDimensions.iziSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  "title_share_friend_page_4".tr,
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.BLACK,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: IZIDimensions.iziSize.width,
                                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: IZIDimensions.iziSize.width * .7 - IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: ColorResources.GREY.withOpacity(.4),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                              IZIDimensions.BORDER_RADIUS_4X,
                                            ),
                                            bottomLeft: Radius.circular(
                                              IZIDimensions.BORDER_RADIUS_4X,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller.genLinkShare(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.onBtnCopy();
                                              },
                                              child: IZIImage(
                                                ImagesPath.coppy_friend_page,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          controller.shareLinkFriend();
                                        },
                                        child: Container(
                                          width: IZIDimensions.iziSize.width * .3 - IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ColorResources.PRIMARY_APP,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                IZIDimensions.BORDER_RADIUS_4X,
                                              ),
                                              bottomRight: Radius.circular(
                                                IZIDimensions.BORDER_RADIUS_4X,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "title_share_friend_page_5".tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                color: ColorResources.WHITE,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
