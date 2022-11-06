import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/accounts/contact/contact_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../base_widget/izi_screen.dart';
import '../../../../base_widget/izi_text.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../utils/color_resources.dart';

class ContactPage extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      safeAreaBottom: false,
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Liên hệ',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),
      body: GetBuilder(
        init: ContactController(),
        builder: (ContactController controller) {
          return Container(
            color: ColorResources.NEUTRALS_6,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_2X,
                        left: IZIDimensions.SPACE_SIZE_2X * 2,
                        right: IZIDimensions.SPACE_SIZE_2X * 2),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.listContact.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: IZIDimensions.SPACE_SIZE_3X),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                           IZIText(
                                     text:
                                  controller.listContact[index]['name']
                                      .toString(),
                                  style: TextStyle(
                                      color: ColorResources.PRIMARY_9,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child:  IZIText(
                                     text:
                                    controller.listContact[index]['title']
                                        .toString(),
                                    maxLine: 2,
                                    style: TextStyle(
                                      // color: ColorResources.NEUTRALS_17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_H6 * 0.9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
                //  tỉnh/tp
              ],
            ),
          );
        },
      ),
    );
  }
}
