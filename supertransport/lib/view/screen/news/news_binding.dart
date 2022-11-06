

import 'package:get/get.dart';
import 'package:template/view/screen/news/news_controller.dart';

class NewsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<NewsController>(NewsController());
  }
}