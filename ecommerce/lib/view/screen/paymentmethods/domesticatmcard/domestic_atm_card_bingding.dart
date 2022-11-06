import 'package:get/get.dart';
import 'package:template/view/screen/paymentmethods/domesticatmcard/domestic_atm_card_controller.dart';

class DomestiAtmCardBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DomestiAtmCardController>(()=> DomestiAtmCardController());
  }
}