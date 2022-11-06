// ignore_for_file: use_setters_to_change_properties

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/certificate/certificate_response.dart';
import 'package:template/data/model/subspecialize/subspecialize_response.dart';
import 'package:template/provider/certificate_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import '../../../di_container.dart';
import '../../../helper/izi_validate.dart';
import '../../../provider/subspecialize_provider.dart';
import '../../../routes/route_path/account_routers.dart';

class YourAbilitiesController extends GetxController {
  ///
  /// Declare API.
  final CertificateProvider certificateProvider = GetIt.I.get<CertificateProvider>();
  final SubSpecializeProvider subSpecializeProvider = GetIt.I.get<SubSpecializeProvider>();
  RxList<CertificateResponse> certificateResponseList = <CertificateResponse>[].obs;
  RxList<SubSpecializeResponse> subSpecializeResponseList = <SubSpecializeResponse>[].obs;
  Rx<SubSpecializeResponse> subSpecializeResponse = SubSpecializeResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isLoadingPaginate = true.obs;
  int pageStart = 1;
  int limitPage = 10;
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    /// Call API get data SubSpecialize.
    getDataSubSpecialize();
    super.onInit();
  }

  @override
  void dispose() {
    isLoadingPaginate.close();
    subSpecializeResponse.close();
    certificateResponseList.close();
    subSpecializeResponseList.close();
    refreshController.dispose();
    super.dispose();
  }

  ///
  /// Call API get data SubSpecialize.
  ///
  void getDataSubSpecialize() {
    subSpecializeProvider.all(
      onSuccess: (models) {
        subSpecializeResponseList.value = models;
        subSpecializeResponseList.insert(subSpecializeResponseList.length, SubSpecializeResponse(name: 'Tất cả'));

        /// Call API get data Certificate.
        getDataCertificate(isRefresh: true);
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data Certificate.
  ///
  void getDataCertificate({required bool isRefresh}) {
    if (isRefresh) {
      pageStart = 1;
      certificateResponseList.clear();
    } else {
      pageStart++;
    }

    certificateProvider.paginate(
      id: sl<SharedPreferenceHelper>().getIdUser,
      page: pageStart,
      limit: limitPage,
      filter: generateFilterData(),
      onSuccess: (models) {
        if (models.isEmpty) {
          refreshController.loadNoData();
          Future.delayed(
            const Duration(milliseconds: 2000),
            () {
              refreshController.refreshCompleted();
            },
          );
        } else {
          if (isRefresh) {
            certificateResponseList.value = models;
            refreshController.refreshCompleted();
          } else {
            certificateResponseList.value = certificateResponseList.toList() + models;
            refreshController.loadComplete();
          }
        }

        /// Just [update] first load [Your Abilities page].
        if (isLoading) {
          isLoading = false;
          update();
        }
        isLoadingPaginate.value = false;
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// On refresh data.
  ///
  Future<void> onRefreshData() async {
    refreshController.resetNoData();

    /// Call API get data Certificate.
    getDataCertificate(isRefresh: true);
  }

  ///
  /// On loading more data.
  ///
  Future<void> onLoadingData() async {
    ///
    /// Call API get data Certificate.
    getDataCertificate(isRefresh: false);
  }

  ///
  /// Generate filter data.
  ///
  String generateFilterData() {
    if (IZIValidate.nullOrEmpty(subSpecializeResponse.value.id)) {
      return '';
    }

    return '&idSubSpecialize=${subSpecializeResponse.value.id}&populate=idSubSpecialize';
  }

  ///
  /// On change SubSpecializeResponse data.
  ///
  void onChangeSubSpecializeResponse(SubSpecializeResponse val) {
    isLoadingPaginate.value = true;
    subSpecializeResponse.value = val;

    /// Call API get data Certificate.
    getDataCertificate(isRefresh: true);
  }

  ///
  /// Go to [Detail abilities page].
  ///
  void goToDetailAbilityPage({required String id}) {
    Get.toNamed(AccountRouter.DETAIL_ABILITIES, arguments: id);
  }
}
