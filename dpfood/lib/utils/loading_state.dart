// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../base_widget/izi_loading_list.dart';
import '../helper/izi_dimensions.dart';
import 'color_resources.dart';
import 'internet_connection.dart';

mixin LoadingState<T> on StateMixin<T> {
  Widget buildObx(
    NotifierBuilder<T?> widget, {
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
    Widget? onNotInternet,
    CONNECTION_STATUS connectionStatus = CONNECTION_STATUS.CONNECTED,
  }) {
    return  connectionStatus == CONNECTION_STATUS.DISCONNECTED ? onNotInternet ?? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CupertinoActivityIndicator(
                      radius: 30,
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    Text(
                      "Không có kết nối internet.\nVui lòng kiểm tra lại",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 1.2,
                        color: ColorResources.BLACK,
                      ),
                    ),
                  ],
                ),
              ): SimpleBuilder(
      builder: (_) {
        if (status.isLoading) {
          return onLoading ?? IZILoadingList();
        } else if (status.isError) {
          return onError != null ? onError(status.errorMessage) : Center(child: Text('A error occurred: ${status.errorMessage}'));
        } else if (status.isEmpty) {
          return onEmpty ??
              const Center(
                child: Text("Không có dữ liệu"),
              );
        } else if(status.isLoadingMore){
          return const SizedBox();
        }
        return widget(value);
      },
    );
  }
}
