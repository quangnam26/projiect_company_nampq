import 'package:get/get.dart';
import 'package:template/view/screen/paymentmethods/addcreditcard/add_credit_card_controller.dart';

class AddCreditCardBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddCreditCardController>(()=> AddCreditCardController());
  }
}