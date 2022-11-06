import 'package:get/get.dart';
import 'package:template/view/screen/%20my_wallet/%20transactiondetails/%20transaction_details_bingding.dart';
import 'package:template/view/screen/%20my_wallet/%20transactiondetails/%20transactiondetails_page.dart';

class TransactionDetailsRouters {
  static const String TRANSACTIONDETAILS = '/transactiondetails';
 

  static List<GetPage> list = [
    GetPage(
        name: TRANSACTIONDETAILS,
        page: () => const TransactionDetailsPage(),
        binding: TransactionDetailsBingding()),
  ];
}
