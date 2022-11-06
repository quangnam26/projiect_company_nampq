import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/review/review_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/provider/review_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/utils/Loading_state.dart';
import 'package:template/utils/app_constants.dart';
import '../../../data/model/transport/transport_response.dart';
import '../../../di_container.dart';
import '../../../helper/izi_validate.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/color_resources.dart';
import '../store/components/scroll_controller_for_animation.dart';

class RatingStoreController extends GetxController with StateMixin<List<ReviewResponse>>, LoadingState, SingleGetTickerProviderMixin {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ReviewProvider reviewProvider = GetIt.I.get<ReviewProvider>();
  final RefreshController refreshController = RefreshController();
  ScrollController? scrollController;
  AnimationController? hideFabAnimController;

  UserResponse? store;

  //List
  List<ReviewResponse> reviews = [];

  //variable
  int limit = 7;
  int page = 1;
  String idUser = '';
  String idUserShop = '';
  RxBool isExpan = false.obs;
  List<Map<String, dynamic>> ratings = [];

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      store = arg['store'] as UserResponse;
      idUserShop = store!.id.toString();
      initValue();
    }
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getReviews(isRefresh: true);
    _initScroll();
  }

  ///
  /// init value
  ///
  void initValue() {
    ratings = [
      {
        "icon": DELICIOUS,
        "value": IZIValidate.nullOrEmpty(store!.statitisReviews)
            ? 0
            : IZIValidate.nullOrEmpty(store!.statitisReviews!.shopReactions)
                ? 0
                : store!.statitisReviews!.shopReactions!.delicious,
        "title": 'Ngon xỉu',
        "iconColor": ColorResources.RED,
      },
      {
        "icon": WELLPACKED,
        "value": IZIValidate.nullOrEmpty(store!.statitisReviews)
            ? 0
            : IZIValidate.nullOrEmpty(store!.statitisReviews!.shopReactions)
                ? 0
                : store!.statitisReviews!.shopReactions!.wellPacked,
        "title": 'Đóng gói kỹ',
        "iconColor": ColorResources.RED.withOpacity(0.7),
      },
      {
        "icon": VERY_WORTH_THE_MONEY,
        "value": IZIValidate.nullOrEmpty(store!.statitisReviews)
            ? 0
            : IZIValidate.nullOrEmpty(store!.statitisReviews!.shopReactions)
                ? 0
                : store!.statitisReviews!.shopReactions!.veryWorthTheMoney,
        "title": 'Rất đáng đồng tiền',
        "iconColor": ColorResources.RED.withOpacity(0.6),
      },
      {
        "icon": SATISFIED,
        "value": IZIValidate.nullOrEmpty(store!.statitisReviews)
            ? 0
            : IZIValidate.nullOrEmpty(store!.statitisReviews!.shopReactions)
                ? 0
                : store!.statitisReviews!.shopReactions!.satisfied,
        "title": 'Hài lòng',
        "iconColor": ColorResources.RED.withOpacity(0.6),
      },
      {
        "icon": QUICKSERVICE,
        "value": IZIValidate.nullOrEmpty(store!.statitisReviews)
            ? 0
            : IZIValidate.nullOrEmpty(store!.statitisReviews!.shopReactions)
                ? 0
                : store!.statitisReviews!.shopReactions!.quickService,
        "title": 'Phục vụ nhanh',
        "iconColor": ColorResources.RED,
      },
      {
        "icon": SAD,
        "value": IZIValidate.nullOrEmpty(store!.statitisReviews)
            ? 0
            : IZIValidate.nullOrEmpty(store!.statitisReviews!.shopReactions)
                ? 0
                : store!.statitisReviews!.shopReactions!.sad,
        "title": 'Buồn',
        "iconColor": ColorResources.RED,
      },
    ];
  }

  void _initScroll() {
    hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );

    scrollController = useScrollControllerForAnimation(hideFabAnimController!);
  }

  ///
  /// Mở rộng
  ///
  void onExpaned() {
    isExpan.value = !isExpan.value;
  }

  ///
  /// get current account
  ///
  void getCurrentAccount() {
    userProvider.find(
      id: idUser,
      onSuccess: (data) {

      },
      onError: (onError) {
        print("An error occurred while getting current account");
      },
    );
  }

  ///
  /// Get transport
  ///
  void getReviews({required bool isRefresh}) {
    if (isRefresh) {
      reviews.clear();
      page = 1;
    } else {
      page++;
    }
    reviewProvider.paginate(
      page: page,
      limit: limit,
      filter: '&populate=idUser,idUserShipper,idUserShop&idUserShop=$idUserShop&sort=-createdAt',
      onSuccess: (data) {
        change(null, status: RxStatus.loading());
        reviews.addAll(data);
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        if (reviews.isEmpty) {
          change(reviews, status: RxStatus.empty());
        } else {
          change(reviews, status: RxStatus.success());
        }
      },
      onError: (onError) {
        print("An error occurred while getting rating $onError");
        change(null, status: RxStatus.error("Lỗi nè"));
      },
    );
  }

  ///
  /// loadmore
  ///
  void onLoading() {
    getReviews(isRefresh: false);
  }

  ///
  /// refresh
  ///
  void onRefresh() {
    change(null, status: RxStatus.loading());
    getReviews(isRefresh: true);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    scrollController?.dispose();
    hideFabAnimController?.dispose();
  }
}
