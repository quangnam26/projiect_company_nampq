import 'package:flutter/material.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/color_resources.dart';

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
    this.physics,
    this.bottomNavigator,
    this.key1,
  }) : super(key: key);
  final Widget body;
  final Widget? background;
  final Widget? appBar;
  final Widget? tabBar;
  final Widget? widgetBottomSheet;
  final Widget? bottomNavigator;
  final bool? isSingleChildScrollView;
  final Widget? drawer;
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final ScrollPhysics? physics;
  final GlobalKey<ScaffoldState>? key1;
  @override
  Widget build(BuildContext context) {
    // var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          background ??
              Container(
                color: ColorResources.NEUTRALS_11,
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
                  // key: scaffoldKey,
                  key: key1,
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      appBar ?? const SizedBox(),
                      if (isSingleChildScrollView!)
                        Expanded(
                          //TODO: Thêm optional cho SingleScrollView
                          child: SingleChildScrollView(
                            physics: physics,
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
                  bottomSheet: widgetBottomSheet ?? const SizedBox(),
                  bottomNavigationBar: bottomNavigator,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
