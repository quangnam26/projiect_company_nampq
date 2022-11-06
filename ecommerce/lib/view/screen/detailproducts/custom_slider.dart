import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class CustomIZISlider extends StatefulWidget {
  const CustomIZISlider({
    Key? key,
    this.axis = Axis.horizontal,
    required this.data,
    this.margin,
  }) : super(key: key);
  final Axis? axis;
  final List<String> data;
  final EdgeInsetsGeometry? margin;

  @override
  _CustomIZISliderState createState() => _CustomIZISliderState();
}

class _CustomIZISliderState extends State<CustomIZISlider> {
  int currentIndex = 0;
  final CarouselController controller = CarouselController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.NEUTRALS_11,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            carouselController: controller,
            itemCount: widget.data.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  imageSlider(
                    widget.data[index].toString(),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              height: 300,
              scrollDirection: widget.axis!,
              onPageChanged: (index, value) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
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
          showBanner(),
        ],
      ),
    );
  }

  ///
  /// Position.
  ///
  Widget showBanner() {
    return Positioned(
      right: IZIDimensions.ONE_UNIT_SIZE * 10,
      child: Container(
        margin: EdgeInsets.only(
          bottom: IZIDimensions.SPACE_SIZE_2X,
        ),
        child: Column(
          children: [
            ..._buildBanner(
              length: widget.data.length,
              currentIndex: currentIndex,
              onChange: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// image slider
  ///
  Widget imageSlider(String urlImage) {
    return IZIImage(
      urlImage,
    );
  }

  ///
  /// build list indicator
  ///
  List<Widget> _buildIndicator({required int length, required int currentIndex}) {
    final List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  ///
  /// build list banner
  ///
  List<Widget> _buildBanner({required int length, required int currentIndex, required Function onChange}) {
    final List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            onChange(i);
            controller.animateToPage(i);
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: IZIDimensions.ONE_UNIT_SIZE * 10,
            ),
            child: Container(
              padding: EdgeInsets.all(
                i == currentIndex ? IZIDimensions.ONE_UNIT_SIZE * 1 : 0,
              ),
              height: IZIDimensions.ONE_UNIT_SIZE * 90,
              width: IZIDimensions.ONE_UNIT_SIZE * 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorResources.WHITE,
                border: Border.all(color: i == currentIndex ? ColorResources.RED : ColorResources.WHITE),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  500,
                ),
                child: IZIImage(
                  widget.data[currentIndex].toString(),
                ),
              ),
            ),
          ),
        ),
      );
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
        horizontal: IZIDimensions.SPACE_SIZE_1X,
      ),
      height: isActive ? IZIDimensions.ONE_UNIT_SIZE * 20 : IZIDimensions.ONE_UNIT_SIZE * 18,
      width: isActive ? IZIDimensions.ONE_UNIT_SIZE * 20 : IZIDimensions.ONE_UNIT_SIZE * 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X),
        color: isActive ? ColorResources.YELLOW : const Color.fromARGB(255, 239, 214, 182),
      ),
    );
  }
}
