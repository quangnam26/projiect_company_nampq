import 'package:get/get.dart';
import 'package:template/view/screen/detail_profile_people/detail_profile_people_controller.dart';

class DetailProfilePeopleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProfilePeopleController>(() => DetailProfilePeopleController());
  }
}
