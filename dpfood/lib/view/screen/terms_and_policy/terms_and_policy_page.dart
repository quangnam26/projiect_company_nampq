import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/terms_and_policy/terms_and_policy_controller.dart';
import '../../../utils/color_resources.dart';

class TermsAndPolicyPage extends GetView<TermsAndPolicyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: "Điều khoản và chính sách",
        colorTitle: ColorResources.WHITE,
        iconBack: GestureDetector(
          onTap:(){
            controller.onBack();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
      background: const BackgroundAppBar(),
      body: GetBuilder(
        builder: (TermsAndPolicyController controller) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_2X,
            ),
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    Text(
                      'Điều khoản và chính sách',
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H5,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.NEUTRALS_3,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Text(
                      'Các Điều khoản dịch vụ này phản ánh cách thức kinh doanh của Google, những điều luật mà công ty chúng tôi phải tuân theo và một số điều mà chúng tôi vẫn luôn tin là đúng. Do đó, các Điều khoản dịch vụ này giúp xác định mối quan hệ giữa Google với bạn khi bạn tương tác với các dịch vụ của chúng tôi. Ví dụ: Các điều khoản này trình bày các chủ đề sau:',
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.NEUTRALS_4,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
