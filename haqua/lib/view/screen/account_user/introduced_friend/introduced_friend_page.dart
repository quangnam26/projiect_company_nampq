import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account_user/introduced_friend/introduced_friend_controller.dart';

class IntroducedFriendPage extends GetView<IntroducedFriendController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
        appBar: const IZIAppBar(title: "Giới thiệu bạn"),
        body: GetBuilder(
            builder: (controller) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // hidden keyboard if click outside text field
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(children: [
                  IZIImage("assets/images/bg_img_introduced_friend_page.png"),
                  Container(
                    width: IZISize.size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                        vertical: IZIDimensions.SPACE_SIZE_5X),
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_7X)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X),
                          child: Text(
                              "Chia sẻ bạn bè \nTăng cơ hội kiếm tiền rủng rỉnh ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w700,
                                  color: ColorResources.SMALL_TITLE)),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X),
                          child: Text(
                              "Chúng tôi là HaQua! Luôn đồng hành và phát triển cùng bạn trong siêng suốt thời gian. Hãy cùng chúng tôi phát triển để đem lại nhiều lợi ích cho cộng đồng và chính bản thân mình. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w400,
                                  color: ColorResources.SUBTITLE)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Link chia sẻ"),
                            Row(
                              children: [
                                Flexible(
                                    child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    top: BorderSide(),
                                    left: BorderSide(),
                                    bottom: BorderSide(),
                                  )),
                                  child: IZIInput(
                                    // label: "Link chia sẻ",
                                    placeHolder: "link",
                                    borderSide: BorderSide.none,
                                    disbleError: true,
                                    isBorder: true,
                                    type: IZIInputType.TEXT,
                                    suffixIcon: const Icon(Icons.copy),
                                  ),
                                )),
                                Flexible(
                                    child: IZIButton(
                                  onTap: () {},
                                  label: "Chia sẻ ngay",
                                ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
