import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image_card.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZIBoxImage extends StatelessWidget {
  const IZIBoxImage({
    Key? key,
    this.isAddImage = false,
    this.onPress,
    this.images,
    this.imagesUrl,
    this.onDelete,
    this.onPreviewImages,
    this.margin,
  }) : super(key: key);
  final bool? isAddImage;
  final Function()? onPress;
  final List<String>? images;
  final List<String>? imagesUrl;
  final Function(String file, List<String> files)? onDelete;
  final Function(String file, List<String> files)? onPreviewImages;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin ??
              EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_1X,
              ),
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.ONE_UNIT_SIZE * 160,
          decoration: BoxDecoration(
            color: ColorResources.GREY.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              IZIDimensions.BORDER_RADIUS_3X,
            ),
            border: Border.all(
              color: ColorResources.PRIMARY_APP,
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagesUrl != null
                ? imagesUrl!.length
                : isAddImage!
                    ? images!.length + 1
                    : images!.length,
            itemBuilder: (context, index) {
              if (isAddImage!) {
                if (index == images!.length) {
                  // == images.length
                  return GestureDetector(
                    onTap: onPress,
                    child: Padding(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorResources.PRIMARY_APP.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_3X,
                          ),
                        ),
                        height: IZIDimensions.ONE_UNIT_SIZE * 150,
                        width: IZIDimensions.ONE_UNIT_SIZE * 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_3X,
                          ),
                          child: IconButton(
                            onPressed: onPress,
                            icon: Icon(
                              Icons.add,
                              size: IZIDimensions.ONE_UNIT_SIZE * 40,
                              color: ColorResources.BLACK,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    onPreviewImages!(images![index], images!);
                  },
                  child: IZIImageCard(
                    image: images![index],
                    isAddImage: isAddImage!,
                    onDelete: () => onDelete!(images![index], images!),
                  ),
                );
              } else {
                return imagesUrl != null
                    ? imagesUrl![index].isNotEmpty && !imagesUrl![index].contains('null')
                        ? GestureDetector(
                            onTap: () {
                              onPreviewImages!(images![index], images!);
                            },
                            child: IZIImageCard(
                              image: imagesUrl![index],
                              isAddImage: isAddImage!,
                            ),
                          )
                        : const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          onPreviewImages!(images![index], images!);
                        },
                        child: IZIImageCard(
                          image: images![index],
                          isAddImage: isAddImage!,
                          onDelete: () {
                            print("delete");
                            onDelete!(images![index], images!);
                          },
                        ),
                      );
              }
            },
          ),
        ),
      ],
    );
  }
}
