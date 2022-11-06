
import 'package:get/get.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_controller.dart';

class PaymentmethodsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodsController>(()=> PaymentMethodsController());
  }
}