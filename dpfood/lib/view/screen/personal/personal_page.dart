import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/personal/personal_controller.dart';

class PersonalPage extends GetView<PersonalController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalController>(
      builder: (personalCtrl) {
        return IZIScreen(
          appBar: const IZIAppBar(
            title: 'Tài khoản',
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_4X * 2,
                      ),
                      child: SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 300,
                        width: IZIDimensions.iziSize.width,
                        child: IZIImage(
                          ImagesPath.bg_account,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_1X,
                        bottom: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                        vertical: IZIDimensions.BORDER_RADIUS_5X * 1.5,
                      ),
                      decoration: BoxDecoration(
                        // color: ColorResources.PRIMARY_1,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BORDER_RADIUS_4X * 2,
                        ),
                      ),
                      height: IZIDimensions.ONE_UNIT_SIZE * 300,
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: IZIDimensions.BORDER_RADIUS_7X * 1.5,
                              child: !IZIValidate.nullOrEmpty(
                                      personalCtrl.userResponse.value.avatar)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          IZIDimensions.BORDER_RADIUS_7X * 1.5),
                                      child: IZIImage(personalCtrl
                                          .userResponse.value.avatar!),
                                    )
                                  : null),
                          Container(
                            margin: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_5X,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: IZIDimensions.SPACE_SIZE_2X),
                                  child: IZIText(
                                    text: !IZIValidate.nullOrEmpty(personalCtrl
                                            .userResponse.value.fullName)
                                        ? personalCtrl
                                            .userResponse.value.fullName
                                            .toString()
                                        : 'NoName',
                                    style: TextStyle(
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_H6 * 1.2,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.WHITE,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: IZIDimensions.SPACE_SIZE_2X,
                                      ),
                                      child: IZIImage(
                                        ImagesPath.image_call_personal,
                                      ),
                                    ),
                                    IZIText(
                                      text: IZIValidate.getRoleString(
                                          personalCtrl
                                              .userResponse.value.typeUser),
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_H6 * 0.9,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResources.WHITE,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: IZIDimensions.SPACE_SIZE_5X,
                  ),
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_7X,
                    ),
                  ),
                  child: IZIListView(
                    itemCount: personalCtrl.listMapAccount.length,
                    builder: (id) => ListTile(
                      onTap: () {
                        if (!IZIValidate.nullOrEmpty(
                            personalCtrl.listMapAccount[id]['page'])) {
                          personalCtrl.navigatorPage(
                              personalCtrl.listMapAccount[id]['page']
                                  .toString(),
                              personalCtrl.listMapAccount[id]['agrument']);
                        }
                      },
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.BORDER_RADIUS_3X),
                          color: ColorResources.ICON_RIGHT_ITEM_ACCOUNT,
                        ),
                        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                        child: Icon(
                          personalCtrl.listMapAccount[id]["icon_left"]
                              as IconData,
                        ),
                      ),
                      title: IZIText(
                        text:
                            personalCtrl.listMapAccount[id]["name"].toString(),
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.PRIMARY_2,
                        ),
                      ),
                      trailing: Icon(
                        personalCtrl.listMapAccount[id]["icon_right"] == null
                            ? null
                            : personalCtrl.listMapAccount[id]["icon_right"]
                                as IconData,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
