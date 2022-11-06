import 'package:get/get.dart';
import 'package:template/view/screen/review_and_payment/complaint_successful/complaint_successful_controller.dart';

class ComplaintSuccessfulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintSuccessfulController>(() => ComplaintSuccessfulController());
  }
}
