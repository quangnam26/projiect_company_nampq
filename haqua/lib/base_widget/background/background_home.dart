

import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: ColorResources.NEUTRALS_7,
            ),
          ],
        ),
      ),
    );
  }
}