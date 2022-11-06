import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/policyandterm/policy_and_term_response.dart';
import 'package:template/provider/policy_and_term_provider.dart';

class ExchangePolicyController extends GetxController {
//khai bao API
  final PolicyAndTermProvider policyAndTermProvider =
      GetIt.I.get<PolicyAndTermProvider>();

//List
  List<PolicyAndTermResponse> listSettingResponse = [];
  PolicyAndTermResponse? policyAndTermResponse;

  // khai báo biến
  bool isloading = false;

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    getDataPolicy();
  }

  ///
  ///GetDataPolicy
  ///
  void getDataPolicy() {
    isloading = true;
    policyAndTermProvider.all(
      onSuccess: (onSuccess) {
        listSettingResponse = onSuccess;
        policyAndTermResponse = listSettingResponse.first;
        isloading = false;
        update();
        print("object$policyAndTermResponse");
      },
      onError: (onError) {},
    );
  }
}
