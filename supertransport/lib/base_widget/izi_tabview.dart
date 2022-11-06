import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZITabView extends StatelessWidget {
  const IZITabView({
    Key? key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.enablePullDown,
    required this.itemCount,
    required this.builder,
    required this.isLoading,
    this.primary,
    this.paddingTabView,
    this.enablePullUp,
  }) : super(key: key);

  final Function() onRefresh;
  final Function() onLoading;
  final bool isLoading;
  final bool enablePullDown;
  final int itemCount;
  final Widget Function(int index) builder;
  final EdgeInsets? paddingTabView;
  final bool? primary;
  final RefreshController? refreshController;
  final bool? enablePullUp;

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Expanded(
        child: Container(
          color: ColorResources.NEUTRALS_7,
          width: double.infinity,
          padding: paddingTabView ??
              EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_2X,
              ),
          child: SmartRefresher(
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Container(
                  child: builder(index),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
