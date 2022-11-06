import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import '../../../base_widget/izi_image.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: const IZIAppBar(
        title: "Tài khoản",
        iconBack: SizedBox(),
      ),
      background: Container(
        color: ColorResources.NEUTRALS_7,
      ),
      body: GetBuilder(
        builder: (AccountController controller) {
          if (controller.isLoadingUser) {
            return const SizedBox();
          }
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 180,
                          width: IZIDimensions.ONE_UNIT_SIZE * 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: IZIImage(
                                IZIValidate.nullOrEmpty(controller.userRequest)
                                    ? ''
                                    : controller.userRequest!.avatar ?? ''),
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Text(
                          IZIValidate.nullOrEmpty(controller.userRequest)
                              ? ''
                              : controller.userRequest!.fullName ?? '',
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      width: IZIDimensions.iziSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(IZIDimensions.ONE_UNIT_SIZE * 80),
                          topRight:
                              Radius.circular(IZIDimensions.ONE_UNIT_SIZE * 80),
                        ),
                        color: ColorResources.WHITE,
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          child: ListView.builder(
                            itemCount: controller.menus.length,
                            itemBuilder: (context, index) {
                              return itemCard(
                                icon:
                                    controller.menus[index]["icon"] as IconData,
                                title:
                                    controller.menus[index]["title"].toString(),
                                onTap: () {
                                  final onTap = controller.menus[index]["onTap"]
                                      as Function;
                                  onTap();

                                },
                                iconColor: controller.menus[index]["color"] as Color,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget itemCard({
    required String title,
    required IconData icon,
    required Function onTap,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_5X,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_3X,
                ),
                color:iconColor.withOpacity(0.3),// ?? ColorResources.NEUTRALS_6,
              ),
              child: Icon(
                icon,
                color: iconColor, //?? ColorResources.NEUTRALS_3,
              ),
            ),
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
                  fontWeight: FontWeight.w500,
                  color: ColorResources.NEUTRALS_3,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorResources.NEUTRALS_4,
            ),
          ],
        ),
      ),
    );
  }
}
