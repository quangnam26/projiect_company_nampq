import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundAppBar extends StatelessWidget {
  const BackgroundAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top + kToolbarHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorResources.YELLOW_PRIMARY3,
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     ColorResources.CIRCLE_COLOR_BG3,
                //     ColorResources.CIRCLE_COLOR_BG2,
                //   ],
                //   stops: [0.7, 1],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
