import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/tranferinformation/transfer_information_controller.dart';

class TransferInformationBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TransferInformationController>(()=> TransferInformationController());
  }
}