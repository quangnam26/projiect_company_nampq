import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/accounts/personalInformation/personal_Information_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../utils/color_resources.dart';

class PersonalInformationPage extends GetView<PersonalInformationController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Thông tin cá nhân',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),
      safeAreaBottom: false,
      body: GetBuilder(
        init: PersonalInformationController(),
        builder: (PersonalInformationController controller) {
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
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_3X,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_3X,
                    right: IZIDimensions.SPACE_SIZE_3X,
                    bottom: IZIDimensions.SPACE_SIZE_3X),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: IZIImage(
                          IZIValidate.nullOrEmpty(controller.userResponse)
                              ? ''
                              : controller.userResponse!.avatar ?? '',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IZIText(
                          text: IZIValidate.nullOrEmpty(controller.userResponse)
                              ? ''
                              : controller.userResponse!.role.toString(),
                          style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto'),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        IZIText(
                            text:
                                IZIValidate.nullOrEmpty(controller.userResponse)
                                    ? ''
                                    : controller.userResponse!.phone.toString(),
                            style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                fontWeight: FontWeight.w400)),
                      ],
                    )
                  ],
                ),
              ),
              Builder(builder: (context) {
                print("Length: ${controller.listUserResponse.length}");
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    itemCount: controller.listPerson.length,
                    itemBuilder: (context, index) {
                      print("INdex: $index");
                      return Padding(
                        padding: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_3X * 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: IZIText(
                                text: controller.listPerson[index]['name']
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w400,
                                    color: ColorResources.COLOR_BLACK_TEXT2),
                              ),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            IZIText(
                                text: controller.listPerson[index]['title']
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.PRIMARY_9))
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              IZIButton(
                margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                    vertical: IZIDimensions.SPACE_SIZE_4X * 4),
                onTap: () {
                  controller.gotoUpdate();
                },
                label: 'Cập nhập',
                colorBG: ColorResources.ORANGE,
              )
            ],
          );
        },
      ),
    );
  }
}
