import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/accounts/otherpolicies/other_policies_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../base_widget/izi_input.dart';
import '../../../../utils/color_resources.dart';

class OtherPoliciesPage extends GetView<OtherPoliciesController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Các chính sách khác',
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_3,
          ),
        ),
      ),
      safeAreaBottom: false,
      body: GetBuilder(
        init: OtherPoliciesController(),
        builder: (OtherPoliciesController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_4X,
                  right: IZIDimensions.SPACE_SIZE_4X,
                  left: IZIDimensions.SPACE_SIZE_4X,
                ),
                color: ColorResources.WHITE,
                // height: IZIDimensions.iziSize.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.menusList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: controller.menusList[index]['onTap'] as Function(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: IZIDimensions.SPACE_SIZE_3X,
                                vertical: IZIDimensions.SPACE_SIZE_3X),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.menusList[index]['title']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_H6 * 0.9,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: IZIDimensions.FONT_SIZE_H5,
                                )
                              ],
                            ),
                          ),
                          if (index == 5)
                            const SizedBox()
                          else
                            const Divider(
                              height: 5,
                              color: ColorResources.GREY,
                            )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

///
/// Fumction Box IZI Input
///
Container iziInputWidget(
    String? label, String placeHolder, Function(String) onChanged,
    {bool isDatePicker = false}) {
  return Container(
    margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X),
    child: IZIInput(
      onChanged: onChanged,
      isDatePicker: isDatePicker,
      // isBorder: true,
      // colorBorder: const Color.fromRGBO(196, 196, 196, 0.8),
      borderRadius: IZIDimensions.BORDER_RADIUS_6X,
      disbleError: true,
      label: label,
      type: IZIInputType.PASSWORD,
      placeHolder: placeHolder,
      // suffixIcon: suffixIcon,
      // onTap:ontap ,
    ),
  );
}
