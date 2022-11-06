// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/transport/transport_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/home/components/superTransportCard.dart';
import '../../../base_widget/animated_custom_dialog.dart';
import '../../../data/model/provider/provider.dart';
import '../../../data/model/province/province_response.dart';
import '../../../data/model/user/user_request.dart';
import '../../../di_container.dart';
import '../../../routes/route_path/splash_routes.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/Loading_state.dart';
import 'components/filter_dialog.dart';

class HomeController extends GetxController with StateMixin<List<TransportResponse>>, LoadingState {
  final Provider provider = Provider();

  final RefreshController refreshController = RefreshController();

  //List
  RxList<TransportResponse> transports = <TransportResponse>[].obs;

  //variable
  int limit = 7;
  int page = 1;
  String idUser = '';
  Rx<UserRequest> userRequest = UserRequest().obs;
  RxString? transportType = ''.obs;
  Rx<ProvinceResponse>? provinceTo = ProvinceResponse().obs;
  Rx<ProvinceResponse>? provinceFrom = ProvinceResponse().obs;
  RxInt? startDate = 0.obs;
  int type = 0;
  Timer? _debounce;
  String searchTerm = '';

  //List
  //0: Cần xe,  1: Đi chung, 2: Gửi đồ, 3: Cho gửi đồ
  RxMap<String, int> transportsType = {
    "Cần xe": 0,
    "Gửi đồ": 2,
    "Đi chung": 1,
    "Cho gửi đồ": 3,
  }.obs;
  RxList<ProvinceResponse> provinces = <ProvinceResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getAccount();
    getTransport(isRefresh: true);
    getProvinces();
  }

  ///
  /// Get transport
  ///
  void getTransport({required bool isRefresh}) {
    // change(transports, status: RxStatus.loading());
    if (isRefresh) {
      transports.clear();
      page = 1;
    } else {
      page++;
    }
    provider.paginate(
      TransportResponse(),
      page: page,
      limit: limit,
      filter: '&populate=${TransportResponse.toPopulate()}&isActive=true${getFilters()}',
      onSuccess: (data) {
        transports.addAll(data.cast<TransportResponse>());
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        if (transports.isEmpty) {
          change(transports, status: RxStatus.empty());
        } else {
          change(transports, status: RxStatus.success());
        }
        update();
      },
      onError: (onError) {
        print("An error occurred while getting transports $onError");
      },
    );
  }

  ///
  /// Get all province
  ///
  void getProvinces() {
    provider.all(
      ProvinceResponse(),
      onSuccess: (data) {
        provinces.addAll(data.cast<ProvinceResponse>());
        print(provinces);
      },
      onError: (onError) {
        print("An error occurred while getting province $onError");
      },
    );
  }

  void onSearch() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      getTransport(isRefresh: true);
    });
  }

  ///
  /// onchanged transport
  ///
  void onChangedLoaiHinh({required String transport}) {
    transportType!.value = transport;
    if (transportsType.containsKey(transportType!.value)) {
      // ignore: cast_nullable_to_non_nullable
      type = transportsType[transportType!.value] as int;
    }
  }

  ///
  ///get user
  ///
  void getAccount() {
    provider.findOne(
      UserRequest(),
      id: idUser,
      onSuccess: (data) {
        if (!IZIValidate.nullOrEmpty(data)) {
          userRequest.value = data as UserRequest;
        }
        update();
      },
      onError: (onError) {
        print("An error occurred while getting the user $onError");
      },
    );
  }

  ///
  /// onchanged transport
  ///
  void onChangedProvinceTo({required ProvinceResponse provinceTo}) {
    this.provinceTo!.value = provinceTo;
  }

  ///
  /// onchanged transport
  ///
  void onChangedProvinceFrom({required ProvinceResponse provinceFrom}) {
    this.provinceFrom!.value = provinceFrom;
  }

  ///
  /// Get filter transports
  ///
  String getFilters() {
    String filter = "";
    if (!IZIValidate.nullOrEmpty(transportType) && !IZIValidate.nullOrEmpty(transportType!.value)) {
      filter += '&transportType=$type';
    }
    if (!IZIValidate.nullOrEmpty(provinceFrom) && !IZIValidate.nullOrEmpty(provinceFrom!.value.id)) {
      filter += '&idProvinceFrom=${provinceFrom!.value.id}';
    }
    if (!IZIValidate.nullOrEmpty(provinceTo) && !IZIValidate.nullOrEmpty(provinceTo!.value.id)) {
      filter += '&idProvinceTo=${provinceTo!.value.id}';
    }
    if (!IZIValidate.nullOrEmpty(startDate) && startDate!.value != 0) {
      filter += "&timeStart>=${startDate!.value}";
    }
    if (!IZIValidate.nullOrEmpty(searchTerm)) {
      filter += '&fullName=$searchTerm';
    }
    return filter;
  }

  void onLoading() {
    change(null, status: RxStatus.loadingMore());
    getTransport(isRefresh: false);
  }

  void onRefresh() {
    searchTerm = '';
    change(null, status: RxStatus.loading());
    getTransport(isRefresh: true);
  }

  ///
  /// Địa điểm băt đầu
  ///
  String startAddress(TransportResponse transport) {
    String address = '';
    // if (!IZIValidate.nullOrEmpty(transport.addressFrom)) {
    //   address += '${transport.addressFrom} ';
    // }
    // if (!IZIValidate.nullOrEmpty(transport.idVillageFrom)) {
    //   if (!IZIValidate.nullOrEmpty(transport.idVillageFrom)) {
    //     address += '${transport.idVillageFrom!.name} ';
    //   }
    // }
    if (!IZIValidate.nullOrEmpty(transport.idDistrictFrom)) {
      if (!IZIValidate.nullOrEmpty(transport.idDistrictFrom)) {
        address += '${transport.idDistrictFrom!.name} ';
      }
    }
    if (!IZIValidate.nullOrEmpty(transport.idProvinceFrom)) {
      if (!IZIValidate.nullOrEmpty(transport.idProvinceFrom)) {
        address += '- ${transport.idProvinceFrom!.name}';
      }
    }
    return address;
  }

  ///
  /// Get transports type
  /// 0: Cần xe,  1: Đi chung, 2: Gửi đồ, 3: Cho gửi đồ
  TRANSPORTTYPE getTransportType(int type) {
    if (type == 0) {
      return TRANSPORTTYPE.CAN_XE;
    }
    if (type == 1) {
      return TRANSPORTTYPE.DI_CHUNG;
    }
    if (type == 2) {
      return TRANSPORTTYPE.GUI_DO;
    }
    return TRANSPORTTYPE.CHO_GUI_DO;
  }

  ///
  /// Get transports value
  /// 0: Cần xe,  1: Đi chung, 2: Gửi đồ, 3: Cho gửi đồ
  String getTransportValue({required TransportResponse transport}) {
    if (IZIValidate.nullOrEmpty(transport.transportType)) {
      return 'Không rõ';
    }
    if (transport.transportType == 0) {
      return '${transport.numberPeople} người';
    }
    if (transport.transportType == 1) {
      return '${transport.numberEmptySeats} còn trống';
    }
    if (transport.transportType == 2) {
      return '${transport.netWeight} ký';
    }
    return '${transport.maxNetWeight} ký';
  }

  ///
  /// On tap transport
  ///
  void onTapTransport({required TransportResponse transport}) {
    Get.toNamed(
      SplashRoutes.DETAIL,
      arguments: {
        "transport": transport,
        "isFromHomePage": true,
      },
    )?.then((value) {
      onRefresh();
    });
  }

  void onShowFilter(BuildContext context) {
    showAnimatedDialog(
      context,
      FilterDialog(
        onSetNgayDi: (val) {
          startDate!.value = IZIDate.parse(val).millisecondsSinceEpoch;
        },
        onChangedLoaiHinh: (val) {
          onChangedLoaiHinh(transport: val);
        },
        onChangedNoiDen: (val) {
          onChangedProvinceTo(provinceTo: val);
        },
        onChangedNoiDi: (val) {
          onChangedProvinceFrom(provinceFrom: val);
        },
        onTapConfirm: () {
          getTransport(isRefresh: true);
          Get.back();
        },
        onTapRefresh: () {
          transportType = ''.obs;
          transportType!.value = '';
          provinceTo = ProvinceResponse().obs;
          provinceFrom = ProvinceResponse().obs;
          startDate!.value = 0;
          getTransport(isRefresh: true);
          Get.back();
        },
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

}
