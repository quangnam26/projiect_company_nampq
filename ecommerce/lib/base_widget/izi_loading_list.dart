import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../helper/izi_dimensions.dart';

class IZILoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        items: 30,
        builder: Container(
          margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
            vertical: IZIDimensions.SPACE_SIZE_2X,
          ),
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.ONE_UNIT_SIZE * 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              IZIDimensions.ONE_UNIT_SIZE * 10,
            ),
            color: Colors.red,
          ),
            child: const Text("Loading..."),
        ),
      ),
    );
  }
}
