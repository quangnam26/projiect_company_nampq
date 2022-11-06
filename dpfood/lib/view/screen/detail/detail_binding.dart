import 'package:get/get.dart';
import 'package:template/view/screen/detail/detail_controller.dart';
class DetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  
    
  }
}