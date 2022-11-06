import 'package:flutter/material.dart';
import 'package:template/helper/izi_size.dart';

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
      child: Stack(
        children: [
          background ??
              Container(
                color: Colors.white,
              ),
          SafeArea(
            top: safeAreaTop!,
            bottom: safeAreaBottom!,
            child: LayoutBuilder(builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              IZISize.update(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              );
              return Scaffold(
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
                bottomSheet: widgetBottomSheet ?? const SizedBox(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
