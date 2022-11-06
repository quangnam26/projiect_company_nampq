import 'package:get/get.dart';
import 'package:template/view/screen/news/detailednews/detailed_news_controller.dart';

class DetailedNewsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailedNewController>(()=> DetailedNewController());
  }
}