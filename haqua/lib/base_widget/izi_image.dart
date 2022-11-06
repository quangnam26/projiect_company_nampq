import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/images_path.dart';

import '../data/datasource/remote/dio/dio_client.dart';

enum IZIImageType {
  SVG,
  IMAGE,
  NOTIMAGE,
}

enum IZIImageUrlType {
  NETWORK,
  ASSET,
  FILE,
  ICON,
  IMAGE_CIRCLE,
}

class IZIImage extends StatefulWidget {
  IZIImage(
    String this.urlImage, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = ColorResources.BLACK,
  }) : super(key: key);
  IZIImage.file(
    this.file, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  IZIImage.icon(
    IconData this.icon, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = ColorResources.BLACK,
    this.size,
  }) : super(key: key);
  String? urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  File? file;
  IconData? icon;
  Color? color;
  double? size;

  @override
  State<IZIImage> createState() => _IZIImageState();
}

class _IZIImageState extends State<IZIImage> {
  ///
  /// Declare Dio.
  DioClient? dioClient = GetIt.I.get<DioClient>();

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     checkUrlExists();
  //   });
  //   super.initState();
  // }

  // ///
  // /// Check url exist.
  // ///
  // Future<void> checkUrlExists() async {
  //   if (!IZIValidate.nullOrEmpty(widget.urlImage)) {
  //     if (widget.urlImage!.startsWith('http') || widget.urlImage!.startsWith('https')) {
  //       final response = await dioClient!.checkUrlExists(widget.urlImage.toString());
  //       if (response.statusCode != 200) {
  //         setState(() {
  //           widget.urlImage = ImagesPath.logo_haqua;
  //         });
  //       }
  //     }
  //   }
  // }

  ///
  /// Check image type.
  ///
  IZIImageType checkImageType(String url) {
    if (IZIValidate.nullOrEmpty(url) && IZIValidate.nullOrEmpty(widget.file) && IZIValidate.nullOrEmpty(widget.icon)) {
      return IZIImageType.NOTIMAGE;
    }
    if (url.endsWith(".svg")) {
      return IZIImageType.SVG;
    }
    return IZIImageType.IMAGE;
  }

  ///
  /// Check image url type.
  ///
  IZIImageUrlType checkImageUrlType(String url) {
    if (IZIValidate.nullOrEmpty(url)) {
      if (widget.icon != null) {
        return IZIImageUrlType.ICON;
      }
      return IZIImageUrlType.FILE;
    }
    if (url.startsWith('http') || url.startsWith('https')) {
      return IZIImageUrlType.NETWORK;
    } else if (url.startsWith('assets/')) {
      return IZIImageUrlType.ASSET;
    } else if (widget.icon != null) {
      if (widget.icon!.fontFamily.toString().toLowerCase().contains('CupertinoIcons'.toLowerCase()) || widget.icon!.fontFamily.toString().toLowerCase().contains('MaterialIcons'.toLowerCase())) {
        return IZIImageUrlType.ICON;
      }
      return IZIImageUrlType.FILE;
    }
    return IZIImageUrlType.FILE;
  }

  ///
  /// Image type widget.
  ///
  Widget imageTypeWidget(String urlImage, IZIImageType imageType, IZIImageUrlType imageUrlType) {
    if (imageType == IZIImageType.IMAGE) {
      if (imageUrlType == IZIImageUrlType.NETWORK) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: CachedNetworkImage(
            fadeOutDuration: Duration.zero,
            fadeInDuration: Duration.zero,
            imageUrl: urlImage,
            width: widget.width,
            height: widget.height,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: widget.fit,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: IZILoading().spinKitLoadImage,
            ),
            errorWidget: (context, url, error) => Image.asset(
              ImagesPath.placeholder,
              fit: widget.fit,
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ASSET) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Image.asset(
            urlImage,
            fit: widget.fit,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                ImagesPath.placeholder,
                fit: widget.fit,
              );
            },
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.FILE) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Image.file(
            widget.file!,
            fit: widget.fit,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                ImagesPath.placeholder,
                fit: widget.fit,
              );
            },
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ICON) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Icon(
            widget.icon,
            color: widget.color,
            size: widget.size ?? IZIDimensions.ONE_UNIT_SIZE * 45,
          ),
        );
      }
    }

    if (imageType == IZIImageType.SVG) {
      if (imageUrlType == IZIImageUrlType.NETWORK) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: SvgPicture.network(
            urlImage,
            fit: widget.fit!,
            placeholderBuilder: (BuildContext context) => SizedBox(
              child: Center(
                child: IZILoading().spinKitLoadImage,
              ),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ASSET) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: SvgPicture.asset(
            urlImage,
            fit: widget.fit!,
            color: widget.color,
            placeholderBuilder: (BuildContext context) => SizedBox(
              child: Center(
                child: IZILoading().spinKitLoadImage,
              ),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.FILE) {
        return Expanded(
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: SvgPicture.file(
              widget.file!,
              fit: widget.fit!,
              placeholderBuilder: (BuildContext context) => SizedBox(
                child: Center(
                  child: IZILoading().spinKitLoadImage,
                ),
              ),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ICON) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Icon(
            widget.icon,
            color: widget.color,
          ),
        );
      }
    }

    if (imageType == IZIImageType.NOTIMAGE) {
      return SizedBox(
        height: widget.height ?? IZIDimensions.ONE_UNIT_SIZE * 50,
        width: widget.width ?? IZIDimensions.ONE_UNIT_SIZE * 50,
        child: Image.asset(
          ImagesPath.placeholder,
          fit: widget.fit,
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final imageType = checkImageType(widget.urlImage.toString());
    final imageUrlType = checkImageUrlType(widget.urlImage.toString());
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: imageTypeWidget(
        widget.urlImage.toString(),
        imageType,
        imageUrlType,
      ),
    );
  }
}
