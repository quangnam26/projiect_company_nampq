import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';

import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/color_resources.dart';

class IZISlider extends StatefulWidget {
  const IZISlider(
      {Key? key,
      this.axis = Axis.horizontal,
      required this.data,
      this.margin,
      this.secondaryChildStackSlider,
      this.onTap})
      : super(key: key);
  final Axis? axis;
  final List<String> data;
  final EdgeInsetsGeometry? margin;
  final Widget? Function(int id)? secondaryChildStackSlider;
  final Function(int id)? onTap;

  @override
  _IZISliderState createState() => _IZISliderState();
}

class _IZISliderState extends State<IZISlider> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: ColorResources.RED,
      margin: widget.margin ??
          EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_2X,
          ),
      child:
          // Stack(
          Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CarouselSlider.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () => widget.onTap!(index),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    imageSlider(
                      widget.data[index].toString(),
                    ),
                    widget.secondaryChildStackSlider!(index) ?? const SizedBox()
                  ],
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              height: IZIDimensions.ONE_UNIT_SIZE * 250,
              // autoPlay: false,
              // enlargeCenterPage: true,
              scrollDirection: widget.axis!,
              onPageChanged: (index, value) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Container(
            // height: IZIDimensions.ONE_UNIT_SIZE * 240,
            margin: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ..._buildIndicator(
                  length: widget.data.length,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// image slider
  ///
  Widget imageSlider(String urlImage) {
    return Container(
      width: IZISize.size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_5X,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_5X,
        ),
        child: IZIImage(
          urlImage,
        ),
      ),
    );
  }

  ///
  /// build list indicator
  ///
  List<Widget> _buildIndicator(
      {required int length, required int currentIndex}) {
    final List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  ///
  /// indicator
  ///
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      height: isActive
          ? IZIDimensions.ONE_UNIT_SIZE * 18
          : IZIDimensions.ONE_UNIT_SIZE * 16,
      width: isActive
          ? IZIDimensions.ONE_UNIT_SIZE * 18
          : IZIDimensions.ONE_UNIT_SIZE * 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X),
          color: isActive ? ColorResources.ORANGE : const Color(0xffFDE3D8)
          ),
    );
  }
}
