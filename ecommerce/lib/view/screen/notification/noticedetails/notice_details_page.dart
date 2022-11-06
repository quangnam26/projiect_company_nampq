import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/view/screen/notification/noticedetails/notice_details_controller.dart';
import '../../../../../helper/izi_dimensions.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../base_widget/izi_appbar.dart';

class NoticeDetailsPage extends GetView<NoticeDetailsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      safeAreaBottom: false,
      appBar: IZIAppBarP24(
        title: "Thông Báo ",
        iconsLeft: const Icon(
          Icons.arrow_back_ios,
          color: ColorResources.BLACK,
        ),
        onTapIconLeft: () {
          Get.back();
        },
      ),
      body: GetBuilder(
        init: NoticeDetailsController(),
        builder: (NoticeDetailsController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 2,
                color: ColorResources.ORDER_DANG_GIAO,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IZIImage(
                        "assets/images/store 1.png",
                        height: IZIDimensions.ONE_UNIT_SIZE * 250,
                        width: IZIDimensions.iziSize.width,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_4X * 1.3,
                            bottom: IZIDimensions.SPACE_SIZE_4X * 1.2),
                        child: Center(
                          child: Text(
                            "Cập nhập từ vận chuyển",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          IZIImage(
                            'assets/icons/ic_calendar.png',
                            height: IZIDimensions.ONE_UNIT_SIZE * 35,
                            width: IZIDimensions.ONE_UNIT_SIZE * 35,
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: IZIDimensions.SPACE_SIZE_2X),
                            child: Text(
                              "20:05:30 20/03/2022",
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                                  fontWeight: FontWeight.w300,
                                  color: ColorResources.NEUTRALS_4),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_2X,
                            left: IZIDimensions.SPACE_SIZE_3X,
                            right: IZIDimensions.SPACE_SIZE_3X),
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                              height: 1.2),
                        ),
                      )
                    ],
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
