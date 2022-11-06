import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/address/address_request.dart';
import 'package:template/di_container.dart';

import 'package:template/routes/route_path/cart_router.dart';

import '../../../../data/model/address/address_response.dart';
import '../../../../provider/address_provider.dart';
import '../../../../sharedpref/shared_preference_helper.dart';
import '../../dash_board/dash_board_controller.dart';

enum PopupMenuItemAddress {
  create,
  update,
  delete,
}

class AddressDeliveryController extends GetxController {
  final AddressProvider addressProvider = GetIt.I.get<AddressProvider>();
  final ValueNotifier<List<AddressResponse>> addresses = ValueNotifier([]);
  final sharedPreferences = sl<SharedPreferenceHelper>();

  final RefreshController refreshController = RefreshController();

  //Variables.
  int page = 1;
  int limit = 10;
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    userId = sharedPreferences.getProfile;
    _getAddress(isRefresh: true);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    addresses.dispose();
  }

  ///
  /// Get address.
  ///
  void _getAddress({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      addresses.value = [];
    } else {
      page++;
    }
    addressProvider.paginate(
      page: page,
      limit: limit,
      filter: '&user=$userId&populate=village,district,province&sort=-isDefault',
      onSuccess: (addresses) {
        final values = [...this.addresses.value, ...addresses];
        this.addresses.value = values;
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
      },
      onError: (onError) {
         Get.find<DashBoardController>().checkLogin();
        debugPrint("An error occurred while paginating the address $onError");
      },
    );
  }

  ///
  /// Refresh the address.
  ///
  void onRefresh() {
    _getAddress(isRefresh: true);
  }

  ///
  /// Load the address.
  ///
  void onLoading() {
    _getAddress(isRefresh: false);
  }

  ///
  /// Selected popup menu.
  ///
  /// @param [value] is [PopupMenuItemAddress]. [value] isn't null.
  /// @param [addressId] is id of the address. [addressId] isn't null.
  ///
  /// The [PopupMenuItemAddress.delete] handle remove function.
  ///
  /// The [PopupMenuItemAddress.update] handle update function.
  ///
  void onHandlePopupMenuSelected({required PopupMenuItemAddress value, required AddressResponse address}) {
    //Remove
    if (value == PopupMenuItemAddress.delete) {
      _removeAddress(addressId: address.id.toString());
      _getAddress(isRefresh: true);
    }
    // Update.
    if (value == PopupMenuItemAddress.update) {
      _onUpdateAddress(address: address, val: value);
    }

    // Create.
    if (value == PopupMenuItemAddress.create) {
      _onUpdateAddress(address: address, val: value);
    }
  }

  ///
  /// remove the address.
  ///
  /// The [addressId] is the id of the address will going to remove.
  ///
  void _removeAddress({required String addressId}) {
    addressProvider.delete(
      id: addressId,
      onSuccess: (address) {
        /// Remove the address sucessfully.
      },
      onError: (onError) {
        debugPrint("An error occurred while removing the address $onError");
      },
    );
  }

  ///
  /// Update default address.
  ///
  void updateDefaultAddress({required AddressResponse address}) {
    // If selected address is default.
    if (address.isDefault == true) {
      return;
    }
    EasyLoading.show(status: "Cập nhật ...");
    addressProvider.update(
      id: address.id.toString(),
      data: AddressRequest(isDefault: true),
      onSuccess: (address) {
        // Update the address successfully.
        final val = addresses.value.firstWhereOrNull((e) => e.isDefault == true);
        if (val != null) {
          addressProvider.update(
            id: val.id.toString(),
            data: AddressRequest(isDefault: false),
            onSuccess: (address) {
              // Update the address successfully.
              EasyLoading.dismiss();
              _getAddress(isRefresh: true);
            },
            onError: (error) {
              EasyLoading.dismiss();
              debugPrint("An error occurred while updating address: $error");
            },
          );
        }
      },
      onError: (error) {
        EasyLoading.dismiss();
        debugPrint("An error occurred while updating address: $error");
      },
    );
  }

  ///
  /// Join address
  ///
  String fullAddress({required AddressResponse address}) {
    print(address.province?.toMap());
    final StringBuffer addressDelivery = StringBuffer();
    if (address.province?.name != null) {
      addressDelivery.write('${address.province?.name} - ');
    }
    if (address.district?.name != null) {
      addressDelivery.write('${address.district?.name} - ');
    }
    if (address.village?.name != null) {
      addressDelivery.write('${address.village?.name}');
    }
    if (address.addressDetail != null) {
      addressDelivery.write(' - ${address.addressDetail}');
    }
    return addressDelivery.toString();
  }

  ///
  /// Update address.
  ///
  void _onUpdateAddress({required AddressResponse address, required PopupMenuItemAddress val}) {
    Get.toNamed(
      CartRoutes.EDIT_ADDRESS,
      arguments: {
        'address': address,
        'value': val,
      },
    )?.then((value) {
      if (value != null) {
        if (value == true) {
          if (addresses.value.isNotEmpty) {
            final addressDefault = addresses.value.firstWhereOrNull((element) => element.isDefault == true);
            if (addressDefault != null) {
              final val = addressDefault.id.toString();
              if (val.isNotEmpty) {
                addressProvider.update(
                  id: val,
                  data: AddressRequest(isDefault: false),
                  onSuccess: (address) {
                    // Update the address successfully.
                  },
                  onError: (error) {
                    debugPrint("An error occurred while updating address: $error");
                    EasyLoading.dismiss();
                  },
                );
              }
            }
          }
        }
      }
      _getAddress(isRefresh: true);
    });
  }
}
