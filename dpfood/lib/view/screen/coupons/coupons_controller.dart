import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/data/model/voucher/voucher_resquest.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/voucher_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/Loading_state.dart';
import '../../../data/model/transport/transport_response.dart';

class CouponsController extends GetxController with StateMixin<List<TransportResponse>>, LoadingState, SingleGetTickerProviderMixin {
  // final connection = GetIt.I<InternetConnection>();
  final VoucherProvider voucherProvider = GetIt.I.get<VoucherProvider>();
  final RefreshController refreshController = RefreshController();

  //List
  RxList<VoucherResponse> vouchers = <VoucherResponse>[].obs;
  Rx<VoucherResponse> voucher = VoucherResponse().obs;
  String code = '';
  double totalPrice = 0;

  //variable
  int limit = 7;
  int page = 1;
  String idUser = '';

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      totalPrice = IZINumber.parseDouble(arg['totalPrice']);
      if (arg['voucher'] != null) {
        voucher = arg['voucher'] as Rx<VoucherResponse>;
      }
    }
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getVoucher(isRefresh: true);
  }

  ///
  /// Voucher
  ///
  void getVoucher({required bool isRefresh}) {
    onShowLoaderOverlay();
    if (isRefresh) {
      vouchers.clear();
      page = 1;
    } else {
      page++;
    }
    voucherProvider.paginate(
      page: 1,
      limit: 5,
      filter: '&populate=idUser,idCategory,idUserShop&filter={"\$and":[{"\$or":[{"voucherOfUser":"$idUser"},{"voucherType":0}]},{"userUsed":{"\$nin":["$idUser"]}}]}&toDate>=${DateTime.now().millisecondsSinceEpoch}', //&toDate>=${DateTime.now().millisecondsSinceEpoch}
      onSuccess: (data) {
        vouchers.addAll(data);
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        onHideLoaderOverlay();
      },
      onError: (onError) {
        print("An error occurred while get voucher $onError");
      },
    );
  }

  void huntVoucher() {
    if (IZIValidate.nullOrEmpty(code)) {
      IZIAlert.error(message: "Vui lòng nhập mã giảm giá");
      return;
    }
    final VoucherRequest voucherRequeset = VoucherRequest();
    voucherRequeset.code = code;
    voucherRequeset.idUser = idUser;
    voucherProvider.huntVoucher(
      data: voucherRequeset,
      onSuccess: (data) {
        IZIAlert.success(message: "Đã thêm mã voucher thành công");
        getVoucher(isRefresh: true);
      },
      onError: (onError) {
        IZIAlert.info(message: "Không tìm thấy mã giảm giá");
        print("An error occurred while get $onError");
      },
    );
  }

  ///
  /// on select voucher
  ///
  void onSelecteVoucher(VoucherResponse voucher) {
    this.voucher.value = voucher;
    Get.back(result: voucher);
  }

  ///
  /// loadmore
  ///
  void onLoading() {
    getVoucher(isRefresh: false);
  }

  ///
  /// refresh
  ///
  void onRefresh() {
    change(null, status: RxStatus.loading());
    getVoucher(isRefresh: true);
  }

  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
    vouchers.close();
    voucher.close();
    refreshController.dispose();
  }
}
