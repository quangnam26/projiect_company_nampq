import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/Loading_state.dart';
import '../../../data/model/provider/provider.dart';
import '../../../data/model/transport/transport_response.dart';
import '../../../di_container.dart';
import '../../../helper/izi_validate.dart';
import '../../../routes/route_path/splash_routes.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../home/components/superTransportCard.dart';

class TrainController extends GetxController with StateMixin<List<TransportResponse>>, LoadingState {
  final Provider provider = Provider();
  // final connection = GetIt.I<InternetConnection>();
  final RefreshController refreshController = RefreshController();

  //List
  List<TransportResponse> transports = [];

  //variable
  int limit = 7;
  int page = 1;
  String idUser = '';

  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getTransport(isRefresh: true);
  }

  ///
  /// Get transport
  ///
  void getTransport({required bool isRefresh}) {
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
      filter: '&populate=${TransportResponse.toPopulate()}&idUser=$idUser&isActive=true&sort=-createdAt',
      onSuccess: (data) {
        change(null, status: RxStatus.loading());
        transports.addAll(data.cast<TransportResponse>());
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        change(transports, status: RxStatus.success());
      },
      onError: (onError) {
        print("An error occurred while getting transports $onError");
        change(null, status: RxStatus.error("Lỗi nè"));
      },
    );
  }

  void onLoading() {
    getTransport(isRefresh: false);
  }

  void onRefresh() {
    change(null, status: RxStatus.loading());
    getTransport(isRefresh: true);
  }

  ///
  /// Địa điểm băt đầu
  ///
  String startAddress(TransportResponse transport) {
    String address = '';
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

  void onTapTransport({required TransportResponse transport}) {
    Get.toNamed(
      SplashRoutes.DETAIL,
      arguments: {
        "transport": transport,
        "isFromHomePage": false,
      },
    )?.then((value) {
      onRefresh();
    });
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

}
