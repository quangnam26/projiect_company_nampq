import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import '../../utils/color_resources.dart';

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
        body: Container(
          height: kToolbarHeight + MediaQuery.of(context).viewPadding.top,
          width: IZIDimensions.iziSize.width,
          decoration: const BoxDecoration(color: ColorResources.PRIMARY_1),

        
        ),
      ),
    );
  }
}
