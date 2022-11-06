
import 'package:get/get.dart';
import 'package:template/view/screen/%20my_wallet/%20transactiondetails/%20transaction_details_controller.dart';

class TransactionDetailsBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailsController>(() => TransactionDetailsController());
  }
}
