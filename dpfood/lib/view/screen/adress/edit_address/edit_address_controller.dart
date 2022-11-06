import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/address/address_reponse.dart';
import 'package:template/data/model/address/address_request.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/provider/address_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

import '../../../../helper/izi_validate.dart';

class EditAddressController extends GetxController {
  final AddressProvider addressProvinder = GetIt.I.get<AddressProvider>();
  String title = '';
  AddressResponse? address;
  int type = 0;
  bool isUpdate = true;
  AddressRequest addressRequest = AddressRequest();
  List<bool> validates = [false, false];
  RxBool isShowError = false.obs;
  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      title = arg['title'].toString();
      final val = arg['address'];
      final tp = arg['type'];
      final update = arg['update'];
      if (val != null) {
        address = arg['address'] as AddressResponse;
      }
      if (tp != null) {
        type = arg['type'] as int;
        validates[1] = type != 2;
      }
      if (update != null) {
        isUpdate = update as bool;
        if (isUpdate == true) {
          validates = [true, true];
        }
      }
    }
  }

  ///
  /// update address
  ///
  void onUpdateAddress() {
    isShowError.value = validates.contains(false);
    if (!validates.contains(false)) {
      if (IZIValidate.nullOrEmpty(address!.id)) {
        // add mới
        addAddress(isAdd: false);
      } else {
        addressProvinder.update(
          data: addressRequest,
          id: address!.id.toString(),
          onSuccess: (data) {
            IZIAlert.success(message: "Cập nhật địa chỉ thành công");
            Get.back();
          },
          onError: (onError) {
            print("An error occurred while is updating the address $onError");
          },
        );
      }
    }
  }

  ///
  /// add address
  ///
  void addAddress({bool? isAdd = true}) {
    isShowError.value = validates.contains(false);
    if (!validates.contains(false)) {
      addressRequest.idUser = sl<SharedPreferenceHelper>().getProfile;
      addressRequest.type = type;
      addressProvinder.add(
        data: addressRequest,
        onSuccess: (data) {
          IZIAlert.success(message: isAdd == true ? 'Thêm địa chỉ mới thành công' : "Cập nhật địa chỉ thành công");
          Get.back();
        },
        onError: (onError) {
          print("An error occurred while is updating the address $onError");
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    isShowError.close();
  }
}
