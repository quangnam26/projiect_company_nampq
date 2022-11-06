import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/personal/detail/detail_personal_controller.dart';

class DetailPersonalPage extends GetView<DetailPersonalController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: const IZIAppBar(
        title: "Thông tin cá nhân",
        colorTitle: ColorResources.WHITE,
      ),
      background: const BackgroundAppBar(),
      body: GetBuilder<DetailPersonalController>(
        builder: (detailPersonalCtrl) => Padding(
          padding:
              EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: IZIDimensions.SPACE_SIZE_5X),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                    radius:
                                        IZIDimensions.BORDER_RADIUS_7X * 1.5,
                                    child: detailPersonalCtrl.isClickAvatar &&
                                            detailPersonalCtrl.fileAvatar !=
                                                null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                IZIDimensions.BORDER_RADIUS_7X *
                                                    1.5),
                                            child: Image.file(
                                              detailPersonalCtrl.fileAvatar!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : !detailPersonalCtrl.isClickAvatar &&
                                                !IZIValidate.nullOrEmpty(
                                                    detailPersonalCtrl
                                                        .userResponse
                                                        .value
                                                        .avatar)
                                            ? ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(IZIDimensions
                                                            .BORDER_RADIUS_7X *
                                                        1.5),
                                                child: IZIImage(
                                                    detailPersonalCtrl
                                                        .userResponse
                                                        .value
                                                        .avatar!),
                                              )
                                            : null),
                                IconButton(
                                  alignment: Alignment.bottomRight,
                                  onPressed: () =>
                                      detailPersonalCtrl.pickImageAvatar(),
                                  icon: const Icon(Icons.camera_alt),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            child: IZIText(
                              text: !IZIValidate.nullOrEmpty(detailPersonalCtrl
                                      .userResponse.value.fullName)
                                  ? detailPersonalCtrl
                                      .userResponse.value.fullName
                                      .toString()
                                  : 'NoName',
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 1.2,
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.PRIMARY_2),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: IZIDimensions.SPACE_SIZE_2X),
                                  child:
                                      IZIImage(ImagesPath.image_call_personal)),
                              IZIText(
                                text: IZIValidate.getRoleString(
                                    detailPersonalCtrl
                                        .userResponse.value.typeUser),
                                style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResources.PRIMARY_2),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_5X,
                            vertical: IZIDimensions.SPACE_SIZE_5X * 1.5),
                        child: IZIInput(
                          isBorder: true,
                          borderRadius: IZIDimensions.BORDER_RADIUS_4X,
                          type: IZIInputType.TEXT,
                          initValue: !IZIValidate.nullOrEmpty(detailPersonalCtrl
                                  .userResponse.value.fullName)
                              ? detailPersonalCtrl.userResponse.value.fullName
                                  .toString()
                              : null,
                          onChanged: (val) {
                            detailPersonalCtrl.fullNameController.text = val;
                          },
                          label: "Họ và tên",
                          placeHolder: !IZIValidate.nullOrEmpty(
                                  detailPersonalCtrl
                                      .userResponse.value.fullName)
                              ? detailPersonalCtrl.userResponse.value.fullName
                                  .toString()
                              : null,
                          prefixIcon: (v) {
                            return IZIImage(
                              ImagesPath.profile,
                              fit: BoxFit.none,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IZIButton(
                onTap: () => detailPersonalCtrl.onSummit(),
                label: "Lưu thay đổi ",
                fontSizedLabel: IZIDimensions.FONT_SIZE_H6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
