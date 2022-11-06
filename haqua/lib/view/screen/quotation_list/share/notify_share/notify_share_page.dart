import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_successful_screen.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/view/screen/quotation_list/share/notify_share/notify_share_controller.dart';

class NotifySharePage extends GetView<NotifyShareController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: NotifyShareController(),
        builder: (NotifyShareController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return IZISuccessfulScreen(
            labelAppBar: "Thông báo",
            title: "Chia sẻ video thành công",
            labelButton: "Hoàn Thành ",
            onTap: () {
              controller.doneAndGoToDashboard();
            },
            description: "Video này được chia sẻ thành công lên hệ thống với giá ${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.moneyShare))}VNĐ",
            typeButton: IZIButtonType.DEFAULT,
          );
        },
      ),
    );
  }
}
