import 'package:flutter/material.dart';
import '../../utils/images_path.dart';
import '../izi_image.dart';

class BackgroundAuth extends StatelessWidget {
  const BackgroundAuth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IZIImage(
              ImagesPath.top,
              fit: BoxFit.contain,
            ),
            if(MediaQuery.of(context).viewInsets.bottom < 150)
            IZIImage(
              ImagesPath.bottom,
              fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }
}
