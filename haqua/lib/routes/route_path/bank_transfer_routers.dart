
import 'package:get/get.dart';
import 'package:template/view/screen/recharge/bank_transfer/bank_transfer_bingding.dart';
import 'package:template/view/screen/recharge/bank_transfer/bank_transfer_page.dart';

class BankTranferRouters {
  static const String BANKTRANFER = '/banktranfer';

  static List<GetPage> list = [
    GetPage(
      name: BANKTRANFER,
      page: () => BankTransferPage(),
      binding: BankTransferBingding(),
    ),
  ];
}
