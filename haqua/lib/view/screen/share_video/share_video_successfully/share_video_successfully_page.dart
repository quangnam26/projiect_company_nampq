import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_successful_screen.dart';
import 'package:template/view/screen/share_video/share_video_successfully/share_video_successfully_controller.dart';

class ShareVideoSuccessfulyyPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: ShareVideoSuccessfullyController(),
        builder: (ShareVideoSuccessfullyController controller) {
          return IZISuccessfulScreen(
            labelAppBar: "Thông báo",
            title: "Yêu cầu chia sẻ thành công",
            description: "Bạn đã yêu cầu chia sẻ video thành công,\nĐợi tài khoản khách hàng  xác nhận và chốt lại giá chia sẻ",
            labelButton: "Hoàn thành",
            onTap: () {
              controller.goToDashBoard();
            },
            typeButton: IZIButtonType.DEFAULT,
          );
        },
      ),
    );
  }
}
