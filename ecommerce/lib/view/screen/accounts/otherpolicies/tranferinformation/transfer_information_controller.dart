import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../data/model/policyandterm/policy_and_term_response.dart';
import '../../../../../provider/policy_and_term_provider.dart';

class TransferInformationController extends GetxController {
  //khai bao API
  final PolicyAndTermProvider policyAndTermProvider =
      GetIt.I.get<PolicyAndTermProvider>();
  PolicyAndTermResponse? policyAndTermResponse;

  //List
  List<PolicyAndTermResponse> listSettingResponse = [];

  // valiable
  bool isloading = false;

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    _getDataPolicy();
  }

  ///
  ///GetDataPolicy
  ///
  void _getDataPolicy() {
    isloading = true;
    policyAndTermProvider.all(
      onSuccess: (onSuccess) {
        listSettingResponse = onSuccess;
        policyAndTermResponse = listSettingResponse.first;
        isloading = false;
        update();
      },
      onError: (onError) {},
    );
  }
}
