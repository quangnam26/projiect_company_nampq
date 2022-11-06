import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:exif/exif.dart';

class IZIOther {
  ///
  /// downloadFiles
  ///
  static Future<void> downloadFiles({required String url}) async {
    final fileName = url.split('/').last;
    final appStorage = Platform.isIOS ? await getApplicationDocumentsDirectory() : await getExternalStorageDirectory();
    final file = File('${appStorage!.path}/$fileName');
    // final file = File('${Platform.isIOS ? appStorage!.path : '${appStorage!.path.split('Android').first}Download'}/$fileName');
    print("filePath $file");

    try {
      final Response response = await Dio().get(url, onReceiveProgress: (count, total) {
        print('$count/$total');
      },
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data as List<int>);
      await raf.close();

      OpenFile.open(file.path);
    } catch (e) {
      print(e);
    }
  }

  ///
  /// open link url
  ///
  static Future openLink({required String url}) async {
    if (!IZIValidate.nullOrEmpty(url)) {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }

  static String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }

  static Future<String> getIdentifierDevice() async {
    String identifier = '';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return identifier;
  }

  static Future<Uint8List> resizeImage(String imageUrl) async {
    Uint8List targetlUinit8List;
    Uint8List originalUnit8List;
    final http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;

    // final ui.Image originalUiImage = await decodeImageFromList(originalUnit8List);
    // final ByteData? originalByteData = await originalUiImage.toByteData();
    // print('original image ByteData size is ${originalByteData!.lengthInBytes}');

    final codec = await ui.instantiateImageCodec(originalUnit8List, targetHeight: 1280, targetWidth: 1280);
    final frameInfo = await codec.getNextFrame();
    final ui.Image targetUiImage = frameInfo.image;

    final ByteData? targetByteData = await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    print('target image ByteData size is ${targetByteData!.lengthInBytes}');
    return targetlUinit8List = targetByteData.buffer.asUint8List();
  }

  List<BoxShadow> boxShadow = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(0, -2),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(2, 0),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(-2, 0),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
  ];

  ///
  ///formatPhoneNumber
  ///
  String formatPhoneNumber(String val) {
    final String phoneNumber = '0$val';
    final List<String> oldValueList = phoneNumber.split('');
    String newValue = '';
    if (!IZIValidate.nullOrEmpty(oldValueList)) {
      for (int i = 0; i < oldValueList.length; i++) {
        if (i == 4) {
          newValue += '-${oldValueList[i]}';
        } else if (i == 7) {
          newValue += '-${oldValueList[i]}';
        } else {
          newValue += oldValueList[i];
        }
      }
    }
    return newValue;
  }

  ///
  ///fixExifRotation
  ///
  Future<File> fixExifRotation(String imagePath) async {
    final originalFile = File(imagePath);
    final List<int> imageBytes = await originalFile.readAsBytes();

    final originalImage = img.decodeImage(imageBytes);

    final height = originalImage!.height;
    final width = originalImage.width;

    // Let's check for the image size
    // This will be true also for upside-down photos but it's ok for me
    if (height >= width) {
      print('originalFile');
      // I'm interested in portrait photos so
      // I'll just return here
      return originalFile;
    }

    // We'll use the exif package to read exif data
    // This is map of several exif properties
    // Let's check 'Image Orientation'
    final exifData = await readExifFromBytes(imageBytes);

    late img.Image fixedImage;

    if (height < width == true) {
      print('Rotating image necessary');
      // rotate
      if (exifData['Image Orientation']!.printable.contains('Horizontal')) {
        fixedImage = img.copyRotate(originalImage, 90);
      } else if (exifData['Image Orientation']!.printable.contains('180')) {
        fixedImage = img.copyRotate(originalImage, -90);
      } else if (exifData['Image Orientation']!.printable.contains('CCW')) {
        fixedImage = img.copyRotate(originalImage, 180);
      } else {
        fixedImage = img.copyRotate(originalImage, 0);
      }
    }

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    final fixedFile = await originalFile.writeAsBytes(img.encodeJpg(fixedImage));

    return fixedFile;
  }
}
