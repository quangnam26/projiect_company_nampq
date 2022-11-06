import 'package:flutter/material.dart';
import 'package:template/base_widget/background/background_splash.dart';
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
  }) : super(key: key);
  final Widget body;
  final Widget? background;
  final Widget? appBar;
  final Widget? tabBar;
  final Widget? widgetBottomSheet;
  final bool? isSingleChildScrollView;
  final Widget? drawer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background ?? const BackgroundSplash(),
        SafeArea(
          child: LayoutBuilder(builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            IZISize.update(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  appBar ?? const SizedBox(),
                  if (isSingleChildScrollView!)
                    Expanded(

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
    );
  }
}
