import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/address/address_request.dart';
import 'package:template/data/model/address/address_response.dart';
import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/village/vilage_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/address_provider.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/village_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/cart/address_delivery/address_delivery_controller.dart';
import 'package:tiengviet/tiengviet.dart';

class EditAddressController extends GetxController {
  final ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  final DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  final VillageProvider villageProvider = GetIt.I.get<VillageProvider>();
  final AddressProvider addressProvider = GetIt.I.get<AddressProvider>();
  final sharedPreferences = sl<SharedPreferenceHelper>();

  final ValueNotifier<AddressResponse> address = ValueNotifier(AddressResponse());
  final ValueNotifier<bool> isDefaultAddress = ValueNotifier(false);
  final ValueNotifier<List<ProvinceResponse>> provincesList = ValueNotifier([]);
  final ValueNotifier<List<DistrictResponse>> districtList = ValueNotifier([]);
  final ValueNotifier<List<VillageResponse>> villageList = ValueNotifier([]);

  final Rx<ProvinceResponse> province = ProvinceResponse().obs;
  final Rx<DistrictResponse> district = DistrictResponse().obs;
  final Rx<VillageResponse> village = VillageResponse().obs;
  final Rx<bool> isShowError = false.obs;
  final ValueNotifier<bool> isShowErrorNotifi = ValueNotifier(false);

  String name = '';
  String phone = '';
  String addressDetail = '';
  PopupMenuItemAddress popupMenuItemAddress = PopupMenuItemAddress.create;

  List<bool> isValidate = [false, false, false, false, false, false];

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      if (arg['address'] != null) {
        address.value = arg['address'] as AddressResponse;
        isDefaultAddress.value = address.value.isDefault == true;
        name = address.value.fullName ?? '';
        phone = address.value.phone ?? '';
        addressDetail = address.value.addressDetail ?? '';
      }
      if (arg['value'] != null) {
        popupMenuItemAddress = arg['value'] as PopupMenuItemAddress;
        if (PopupMenuItemAddress.update == popupMenuItemAddress) {
          isValidate = [true, true, true, true, true, true];
        }
      }
    }
    _getProvinces();
  }

  @override
  void onClose() {
    super.onClose();
    address.dispose();
    isDefaultAddress.dispose();
    provincesList.dispose();
    districtList.dispose();
    villageList.dispose();
    province.close();
    district.close();
    village.close();
    isShowError.close();
    isShowErrorNotifi.dispose();
  }

  ///
  /// Get all the provinces.
  ///
  void _getProvinces() {
    provinceProvider.all(
      onSuccess: (provinces) {
        provincesList.value = provinces;
        // maping province when update the address.
        if (address.value.province?.id != null) {
          final val = provincesList.value
              .firstWhere((e) => e.id.toString() == address.value.province?.id, orElse: () => ProvinceResponse());
          if (val.id != null) {
            province.value = val;
            _getDistricts(idProvince: province.value.id.toString());
          }
        }
      },
      onError: (onError) {
        debugPrint("An error occurred while getting the province $onError");
      },
    );
  }

  ///
  /// Get all the districts.
  ///
  void _getDistricts({required String idProvince}) {
    districtProvider.paginate(
      limit: 50,
      page: 1,
      filter: '&idProvince=$idProvince&populate=idProvince',
      onSuccess: (districts) {
        districtList.value = districts;

        // maping district when update the address.
        if (address.value.district?.id != null) {
          final val = districtList.value.firstWhereOrNull((e) => e.id.toString() == address.value.district?.id);
          if (val != null) {
            district.value = val;
            _getVillages(idDistrict: district.value.id.toString());
          }
        } else {
          villageList.value = [];
          district.value = DistrictResponse();
          village.value = VillageResponse();
        }
      },
      onError: (onError) {
        debugPrint("An error occurred while getting the districts $onError");
      },
    );
  }

  ///
  /// Get all the villages.
  ///
  void _getVillages({required String idDistrict}) {
    villageProvider.paginate(
      limit: 50,
      page: 1,
      filter: '&idDistrict=$idDistrict&populate=idProvince,idDistrict.idProvince',
      onSuccess: (villages) {
        villageList.value = villages;
        // maping village when update the address.
        if (address.value.village?.id != null) {
          final val = villageList.value
              .firstWhere((e) => e.id.toString() == address.value.village?.id, orElse: () => VillageResponse());
          if (val.id != null) {
            village.value = val;
          }
        }
      },
      onError: (onError) {
        debugPrint("An error occurred while getting the villages $onError");
      },
    );
  }

  ///
  /// Change province.
  ///
  void setProvince(ProvinceResponse province) {
    this.province.value = province;
    _getDistricts(idProvince: province.id.toString());
    isValidate[0] = true;
  }

  ///
  /// Change district.
  ///
  // ignore: avoid_setters_without_getters
  void setDistrict(DistrictResponse district) {
    this.district.value = district;
    _getVillages(idDistrict: district.id.toString());
    isValidate[1] = true;
    if (checkAddress()) {
      isValidate[2] = true;
    } else {
      isValidate[2] = false;
    }
  }

  ///
  /// Change village.
  ///
  // ignore: avoid_setters_without_getters
  set setVillage(VillageResponse village) {
    this.village.value = village;
    isValidate[2] = true;
  }

  ///
  /// Change village.
  ///
  // ignore: avoid_setters_without_getters
  set setName(String name) {
    this.name = name;
  }

  ///
  /// Change village.
  ///
  // ignore: avoid_setters_without_getters
  set setPhone(String phone) {
    this.phone = phone;
  }

  ///
  /// Change village.
  ///
  // ignore: avoid_setters_without_getters
  set setAddressDetail(String addressDetail) {
    this.addressDetail = addressDetail;
  }

  ///
  /// On set the address is default address.
  ///
  void onChangedSwitch() {
    isDefaultAddress.value = !isDefaultAddress.value;
  }

  ///
  /// Check Hoàng sa and Côn Đảo haven't village.
  ///
  /// @return [true] if district is Côn Đảo or Hoàng Sa.
  ///
  bool checkAddress() {
    return TiengViet.parse(district.value.name.toString().toLowerCase())
            .contains(TiengViet.parse('Côn đảo'.toLowerCase())) ||
        TiengViet.parse(district.value.name.toString().toLowerCase())
            .contains(TiengViet.parse('Hoàng Sa'.toLowerCase()));
  }

  ///
  /// Handle create address and update the address.
  ///
  void handleCompleteAddress() {
    if (isValidate.contains(false)) {
      onShow();
      return;
    }
    if (popupMenuItemAddress == PopupMenuItemAddress.create) {
      EasyLoading.show(status: "Thêm địa chỉ ...");
      _createAddress();
    }
    if (popupMenuItemAddress == PopupMenuItemAddress.update) {
      EasyLoading.show(status: "Update địa chỉ ...");
      // _updateAddress();
      _getDefaultAddress();
    }
  }

  ///
  /// Create a new address.
  ///
  void _createAddress() {
    addressProvider.add(
      data: _createRequest(),
      onSuccess: (address) {
        // Create the address successfully.
        EasyLoading.dismiss();
        Get.back(result: isDefaultAddress.value);
      },
      onError: (error) {
        EasyLoading.dismiss();
        debugPrint("An error occurred while creating address: $error");
      },
    );
  }

  ///
  /// Update a new address.
  ///
  void _updateAddress() {
    addressProvider.update(
      id: address.value.id.toString(),
      data: _createRequest(),
      onSuccess: (AddressRequest address) {
        // If set address update is default address then address before is not default.
        // if (this.address.value.isDefault == true && isDefaultAddress.value == true) {
        //   _updateDefaultAddress();
        // }
        // Update the address successfully.
        _done();
      },
      onError: (error) {
        EasyLoading.dismiss();
        debugPrint("An error occurred while updating address: $error");
      },
    );
  }

  ///
  /// Get default address.
  ///
  ///
  /// Get address.
  ///
  void _getDefaultAddress() {
    addressProvider.paginate(
      page: 1,
      limit: 1,
      filter:
          '&user=${sl<SharedPreferenceHelper>().getProfile}&populate=village,district,province&isDefault=true&sort=-isDefault',
      onSuccess: (List<AddressResponse> addresses) {
        if (addresses.isNotEmpty) {
          if (addresses.first.id != address.value.id && isDefaultAddress.value == true) {
            _updateDefaultAddress(id: addresses.first.id);
          } else {
            _updateAddress();
          }
        } else {
          _updateAddress();
        }
      },
      onError: (onError) {
        debugPrint("An error occurred while paginating the address $onError");
      },
    );
  }

  ///
  /// Update default address.
  ///
  void _updateDefaultAddress({String? id}) {
    addressProvider.update(
      id: id ?? address.value.id.toString(),
      data: AddressRequest(isDefault: false),
      onSuccess: (address) {
        // Update the address successfully.
        _updateAddress();
      },
      onError: (error) {
        EasyLoading.dismiss();
        debugPrint("An error occurred while updating address: $error");
      },
    );
  }

  ///
  /// Create a request.
  ///
  AddressRequest _createRequest() {
    final AddressRequest addressRequest = AddressRequest();
    addressRequest.addressDetail = addressDetail;
    addressRequest.fullName = name;
    addressRequest.phone = phone;
    addressRequest.isDefault = isDefaultAddress.value;
    addressRequest.province = province.value;
    addressRequest.district = district.value;
    addressRequest.village = village.value;
    addressRequest.user = UserResponse(id: sharedPreferences.getProfile);
    return addressRequest;
  }

  ///
  /// on show error.
  ///
  void onShow() {
    isShowError.value = true;
    isShowErrorNotifi.value = true;
  }

  ///
  /// on hide error.
  ///
  void onHide() {
    isShowError.value = false;
    isShowErrorNotifi.value = false;
  }

  ///
  /// On done.
  ///
  void _done() {
    EasyLoading.dismiss();
    Get.back();
  }
}
