import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/address/address_reponse.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/address_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/order_routes.dart';
import 'package:template/utils/Loading_state.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../../data/model/transport/transport_response.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class AddressController extends GetxController with StateMixin<List<TransportResponse>>, LoadingState {
  final AddressProvider addressProvinder = GetIt.I.get<AddressProvider>();
  final UserProvider userProvinder = GetIt.I.get<UserProvider>();

  final RefreshController refreshController = RefreshController();

  String idUser = '';
  RxList<AddressResponse> address = <AddressResponse>[].obs;
  Rx<AddressResponse> home = AddressResponse().obs;
  Rx<AddressResponse> company = AddressResponse().obs;
  RxString groupValue = 'a'.obs;
  int limit = 10;
  int page = 1;
  String name = '';

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      name = arg['name'].toString();
    }
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getHomeAddress();
    getWorkAddress();
    getAddress(isRefresh: true);
  }

  ///
  /// Get home address
  ///
  void getHomeAddress() {
    addressProvinder.paginate(
      page: 1,
      limit: 2,
      filter: '&type=0&idUser=$idUser',
      onSuccess: (data) {
        if (data.isNotEmpty) {
          home.value = data[0];
          if (name == home.value.name) {
            groupValue.value = home.value.id.toString();
          }
        }
      },
      onError: (onError) {
        print("An error has occurred while getting the address $onError");
      },
    );
  }

  ///
  /// Get work address
  ///
  void getWorkAddress() {
    addressProvinder.paginate(
      page: 1,
      limit: 1,
      filter: '&type=1&idUser=$idUser',
      onSuccess: (data) {
        if (data.isNotEmpty) {
          company.value = data[0];
          if (name == company.value.name) {
            groupValue.value = company.value.id.toString();
          }
        }
      },
      onError: (onError) {
        print("An error has occurred while getting the address $onError");
      },
    );
  }

  ///
  /// Get addreses
  ///
  void getAddress({required bool isRefresh}) {
    if (isRefresh) {
      address.clear();
      page = 1;
    } else {
      page++;
    }
    addressProvinder.paginate(
      page: page,
      limit: limit,
      filter: '&type=2&idUser=$idUser',
      onSuccess: (data) {
        address.addAll(data);
        currentAddress();
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        isLoading.value = false;
      },
      onError: (onError) {
        print("An error occurred while getting address $onError");
      },
    );
  }

  void currentAddress() {
    if (!IZIValidate.nullOrEmpty(name)) {
      final val = address.firstWhereOrNull((e) => TiengViet.parse(e.name.toString().toLowerCase()).contains(TiengViet.parse(name.toLowerCase())));
      if (val != null) {
        groupValue.value = val.id.toString();
      }
    }
  }

  void onLoading() {
    getAddress(isRefresh: false);
  }

  void onRefresh() {
    getAddress(isRefresh: true);
  }

  ///
  /// on change address
  ///
  void onChangeAddress({required String val, required AddressResponse address}) {
    groupValue.value = val;
    onUpdateAddressForUser(address);
  }

  ///
  /// update address for user
  ///
  void onUpdateAddressForUser(AddressResponse address) {
    userProvinder.update(
      data: UserRequest(
        address: address.name.toString(),
        note: address.note.toString(),
      ),
      id: idUser,
      onSuccess: (data) {
        Get.back();
      },
      onError: (onError) {
        print("An error occurred while update address for uesr $onError");
      },
    );
  }

  ///
  /// on go to update address
  ///
  void onUpdateAddress(String title, {AddressResponse? address, int? type = 2, required bool isUpdate}) {
    Get.toNamed(
      OrderRoutes.EDIT_ADDRESS_ORDER,
      arguments: {
        'title': title,
        'address': address,
        'type': type,
        'update': isUpdate,
      },
    )?.then((value) {
      onRefresh();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    address.close();
    refreshController.dispose();
    home.close();
    company.close();
    groupValue.close();
    super.onClose();
  }
}
