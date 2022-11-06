import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account/update_account/update_account_controller.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../base_widget/izi_input.dart';
import '../../../../helper/izi_validate.dart';

class UpdateAccountPage extends GetView<UpdateAccountController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: const IZIAppBar(
        title: "",
      ),
      background: Container(
        color: ColorResources.NEUTRALS_7,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          builder: (UpdateAccountController controller) {
            if (controller.isLoadingUser) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return Container(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              margin: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_4X,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Obx(() {
                              return CircleAvatar(
                                radius: IZIDimensions.ONE_UNIT_SIZE * 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    IZIDimensions.ONE_UNIT_SIZE * 100,
                                  ),
                                  child: IZIImage(
                                    IZIValidate.nullOrEmpty(controller.avatar)
                                        ? IZIValidate.nullOrEmpty(controller.userRequest)
                                            ? ''
                                            : controller.userRequest.avatar ?? ''
                                        : "$BASE_URL_IMAGE/static/${controller.avatar}",
                                  ),
                                ),
                              );
                            }),
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: () {
                                  controller.pickImage();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                    IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.NEUTRALS_7,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: ColorResources.PRIMARY_2,
                                    size: IZIDimensions.ONE_UNIT_SIZE * 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Text(
                          IZIValidate.nullOrEmpty(controller.userRequest) ? '' : controller.userRequest.fullName ?? '',
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.ONE_UNIT_SIZE * 50,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          nameInput(),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          birthDay(),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          phonInput(),
                        ],
                      ),
                    ),
                    // Button
                    if(MediaQuery.of(context).viewInsets.bottom < 150)
                    onUpdateAccountButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget nameInput() {
    return IZIInput(
      type: IZIInputType.TEXT,
      label: 'Họ và tên',
      placeHolder: 'Nhập họ và tên',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isNotShadown: false,
      labelStyle: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        fontWeight: FontWeight.w400,
        color: ColorResources.NEUTRALS_3,
      ),
      onChanged: (val) {
        controller.userRequest.fullName = val;
      },
      initValue: IZIValidate.nullOrEmpty(controller.userRequest) ? '' : controller.userRequest.fullName ?? '',
    );
  }

  Widget birthDay() {
    return IZIInput(
      type: IZIInputType.TEXT,
      label: 'Ngày Sinh',
      placeHolder: '12-12-2001',
      isDatePicker: true,
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isNotShadown: false,
      labelStyle: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        fontWeight: FontWeight.w400,
        color: ColorResources.NEUTRALS_3,
      ),
      onChanged: (val) {
        controller.userRequest.dateOfBirth = IZIDate.parse(val).millisecondsSinceEpoch;
      },
      initValue: IZIValidate.nullOrEmpty(controller.userRequest)
          ? ''
          : IZIValidate.nullOrEmpty(controller.userRequest.dateOfBirth)
              ? ''
              : IZIDate.formatDate(DateTime.fromMillisecondsSinceEpoch(controller.userRequest.dateOfBirth!)),
    );
  }

  Widget phonInput() {
    return IZIInput(
      type: IZIInputType.PHONE,
      label: 'Số điện thoại',
      placeHolder: '0352972442',
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      disbleError: true,
      isNotShadown: false,
      labelStyle: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        fontWeight: FontWeight.w400,
        color: ColorResources.NEUTRALS_3,
      ),
      allowEdit: false,
      fillColor: ColorResources.NEUTRALS_7,
      initValue: IZIValidate.nullOrEmpty(controller.userRequest) ? '' : controller.userRequest.phone ?? '',
    );
  }

  Widget onUpdateAccountButton() {
    return IZIButton(
      onTap: () {
        controller.onUpdateUser();
      },
      label: "Cập nhật",
      borderRadius: 10,
    );
  }
}
