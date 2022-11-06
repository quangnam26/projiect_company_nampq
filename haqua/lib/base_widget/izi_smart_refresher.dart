import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IZISmartRefresher extends StatelessWidget {
  const IZISmartRefresher({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.enablePullDown,
    this.primary,
    this.enablePullUp,
  }) : super(key: key);

  final Function() onRefresh;
  final Function() onLoading;
  final bool enablePullDown;
  final Widget child;
  final bool? primary;
  final RefreshController? refreshController;
  final bool? enablePullUp;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      primary: primary ?? false,
      onRefresh: onRefresh,
      onLoading: onLoading,
      controller: refreshController!,
      enablePullUp: enablePullUp ?? false,
      enablePullDown: enablePullDown,
      header: ClassicHeader(
        idleText: "Scroll_down".tr,
        releaseText: "Release_refresh".tr,
        completeText: "refresh_successful".tr,
        refreshingText: "Refreshing_data".tr,
        failedText: "Refresh_faulty".tr,
        canTwoLevelText: "Release_refresh".tr,
      ),
      footer: ClassicFooter(
        loadingText: "Loading".tr,
        noDataText: "No_data".tr,
        canLoadingText: "Scroll_up_data".tr,
        failedText: "Loading_more_data_error".tr,
        idleText: "Scroll_up_data".tr,
      ),
      child: child,
    );
  }
}
