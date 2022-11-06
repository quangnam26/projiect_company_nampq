import 'package:get/get.dart';
import 'package:template/view/screen/%20my_wallet/my_wallet_binding.dart';
import 'package:template/view/screen/%20my_wallet/my_wallet_page.dart';

class MyWalletRouters {
  static const String MYWALLET = '/mywallet';

  static List<GetPage> list = [
    GetPage(name: MYWALLET, page: () => const MyWalletPage(), binding: MyWalletBinding()),
  ];
}
