import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IZISmartRefresher extends StatelessWidget {
  const IZISmartRefresher({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.enablePullDown,
    required this.isLoading,
    this.primary,
    this.enablePullUp,
  }) : super(key: key);

  final Function() onRefresh;
  final Function() onLoading;
  final bool isLoading;
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
      header: const ClassicHeader(
        idleText: "Kéo xuống để làm mới",
        releaseText: "Thả ra để làm mới dữ liệu",
        completeText: "Làm mới dữ liệu thành công",
        refreshingText: "Đang làm mới dữ liệu",
        failedText: "Làm mới dữ liệu bị lỗi",
        canTwoLevelText: "Thả ra để làm mới",
      ),
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: "Kéo lên để tải thêm dữ liệu",
        failedText: "Tải thêm dữ liệu bị lỗi",
        idleText: "Kéo lên để tải thêm dữ liệu",
      ),
      child: child,
    );
  }
}
