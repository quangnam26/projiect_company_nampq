import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import '../../../base_widget/background/backround_appbar.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../helper/izi_validate.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      // isSingleChildScrollView: tr,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Tài khoản',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: IZIValidate.nullOrEmpty(Get.arguments)
                ? const SizedBox()
                : const Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.NEUTRALS_3,
                  ),
          )),

      body: GetBuilder(
        init: AccountController(),
        builder: (AccountController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_3X * 2,
                      top: IZIDimensions.SPACE_SIZE_3X * 2,
                      right: IZIDimensions.SPACE_SIZE_3X * 2,
                      bottom: IZIDimensions.SPACE_SIZE_5X),
                  // color: Colors.red,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.menusAccount.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: ColorResources.WHITE,
                        margin: EdgeInsets.only(
                          bottom: index == 5
                              ? IZIDimensions.SPACE_SIZE_4X * 1.2
                              : index == 9
                                  ? IZIDimensions.SPACE_SIZE_4X * 1.5
                                  : 0,
                        ),
                        child: itemCard(
                          title: controller.menusAccount[index]['title']
                              .toString(),
                          image: controller.menusAccount[index]['image']
                              .toString(),
                          onTap: controller.menusAccount[index]["onTap"]
                              as Function,
                          index: index,
                        ),
                      );
                    },
                  ))
            ],
          );
        },
      ),
    );
  }

  Widget itemCard(
      {required String title,
      required String image,
      required Function onTap,
      // required Color iconColor,

      required int index}) {
    return GestureDetector(
      onTap: () {
        // ignore: unnecessary_statements
        onTap();
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_2X,
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                IZIImage(image),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_4X,
                ),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                if (index == 10)
                  const SizedBox.shrink()
                else
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ColorResources.NEUTRALS_4,
                    size: IZIDimensions.SPACE_SIZE_4X,
                  )
              ],
            ),
          ),
          if (index == 5 || index == 9 || index == 10)
            const SizedBox()
          else
            const Divider(
              height: 5,
              color: ColorResources.NEUTRALS_9,
            )
        ],
      ),
    );
  }
}
