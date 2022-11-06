import 'package:flutter/material.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../utils/color_resources.dart';

class GridViewFilter<T> extends StatefulWidget {
  const GridViewFilter({
    Key? key,
    required this.data,
    required this.value,
    this.onTap,
    this.icon,
    this.label,
  }) : super(key: key);
  final List<T> data;
  final T value;
  final Function? onTap;
  final String? icon;
  final String? label;

  @override
  State<GridViewFilter<T>> createState() => _GridViewFilterState<T>();
}

class _GridViewFilterState<T> extends State<GridViewFilter<T>> {
  bool isExpaned = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
        top: IZIDimensions.SPACE_SIZE_1X,
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          TitleTile(
            icon: widget.icon ?? '',
            label: widget.label ?? 'Khu Vực',
          ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 20,
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 65,
              mainAxisSpacing: 1,
              crossAxisCount: 2,
              crossAxisSpacing: 1,
            ),
            shrinkWrap: true,
            itemCount: isExpaned
                ? widget.data.length
                : widget.data.length > 9
                    ? 9
                    : widget.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (!IZIValidate.nullOrEmpty(widget.onTap)) {
                    widget.onTap!(widget.data[index]);
                    setState(() {});
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_1X,
                  ),
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_1X,
                  ),
                  decoration: BoxDecoration(
                    color: widget.data[index] == widget.value ? ColorResources.PRIMARY_1 : ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.ONE_UNIT_SIZE * 10,
                    ),
                  ),
                  child: Text(
                    widget.data[index].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      color: widget.data[index] == widget.value ? ColorResources.WHITE : ColorResources.BLACK,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          // if (widget.data.length < 9)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpaned = !isExpaned;
              });
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                isExpaned ? 'Thu lại' : "Xem thêm",
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  color: ColorResources.PRIMARY_1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleTile extends StatelessWidget {
  const TitleTile({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);
  final String icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_1X,
      ),
      width: IZIDimensions.ONE_UNIT_SIZE * 170,
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 10,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(
          //   widget.icon ?? Icons.map,
          //   color: ColorResources.PRIMARY_1,
          // ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 25,
            width: IZIDimensions.ONE_UNIT_SIZE * 25,
            child: IZIImage(icon),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          Text(
            label,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              color: ColorResources.NEUTRALS_1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
