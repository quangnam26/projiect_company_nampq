import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/main.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/internet_connection.dart';

class IZIScreen extends StatelessWidget {
  const IZIScreen({
    Key? key,
    required this.body,
    this.background,
    this.appBar,
    this.isSingleChildScrollView = true,
    this.tabBar,
    this.widgetBottomSheet,
    this.drawer,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  }) : super(key: key);
  final Widget body;
  final Widget? background;
  final Widget? appBar;
  final Widget? tabBar;
  final Widget? widgetBottomSheet;
  final bool? isSingleChildScrollView;
  final Widget? drawer;
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Obx(() {
        if (connectionStatus.value == CONNECTION_STATUS.DISCONNECTED) {
          return IZILoaderOverLay(
            loadingWidget: spinKitWanderingCubes,
            body: Builder(builder: (context) {
              onShowLoaderOverlay();
              return SizedBox(
                child: Center(
                  child: Gif(
                    height: IZIDimensions.iziSize.height,
                    autostart: Autostart.loop,
                    image: const AssetImage("assets/images/error_internet.gif"),
                  ),
                ),
              );
            }),
          );
        }
        return Stack(
          children: [
            background ??
                // Container(
                //   // color: Colors.white,
                // ),
                // BackgroundWhite(),
                Container(
                  color: ColorResources.NEUTRALS_7,
                ),
            SafeArea(
              top: safeAreaTop!,
              bottom: safeAreaBottom!,
              child: LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) {
                  IZISize.update(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  );
                  return Scaffold(
                    key: key,
                    // drawer: drawer,
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.transparent,
                    body: Column(
                      children: [
                        appBar ?? const SizedBox(),
                        if (isSingleChildScrollView!)
                          Expanded(
                            //TODO: Thêm optional cho SingleScrollView
                            child: SingleChildScrollView(
                              child: body,
                            ),
                          )
                        else
                          Expanded(
                            child: body,
                          ),
                      ],
                    ),
                    endDrawer: drawer,
                    onEndDrawerChanged: (val) {
                      print("ABC");
                    },

                    bottomSheet: widgetBottomSheet ?? const SizedBox(),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
