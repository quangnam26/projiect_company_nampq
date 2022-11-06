import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/images/image_response.dart';
import 'package:template/data/repositories/image_reponsitory.dart';

class ImageUploadProvider {
  ImageUploadRepository? regionRepo = ImageUploadRepository(); //GetIt.I.get<ImageUploadRepository>();

  ImageUploadProvider();

  ///
  /// Insert uploadImage to database
  ///
  Future<void> addImages({
    required List<File> files,
    required Function(List<String> uploadImage) onSuccess,
    required Function(dynamic error) onError,
    String type="image"
  }) async {
    int countSize = 0;
    const int maxMBFilesSize = 20;

    for (var i = 0; i < files.length; i++) {
      // files[i] = await _resizeImage(files[i].path, width: 500, height: 500);
      countSize += await files[i].length();
    }
    if (countSize > maxMBFilesSize * 1024 * 1024) {
      return onError(Exception('Dung lượng ảnh không quá $maxMBFilesSize MB, vui lòng chọn file khác'));
    }

    final ApiResponse apiResponse = await regionRepo!.addImages(files);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]' ? apiResponse.response.data['files'] as List<dynamic> : [];

      final ImageResponse value = ImageResponse(files: []);
      if (results.isNotEmpty) {
        value.files!.addAll(results.map((e) => e.toString()).toList());
      }

      //Confirm image
      final ApiResponse apiResponseComfirm = await regionRepo!.confirmFilesOrImages(value);

      if (apiResponseComfirm.response.statusCode! >= 200 && apiResponseComfirm.response.statusCode! <= 300) {
        final List<String> resultsConfirm = [];

        for (final item in results) {
          if (item.toString().contains('/tmp')) {
            resultsConfirm.add(item.toString().replaceAll('/tmp', '/$type'));
          }
        }
        onSuccess(resultsConfirm);
      } else {
        onError(apiResponse.error);
      }
    } else {
      onError(apiResponse.error);
    }
  }

  // ignore: unused_element
  static Future<File> _resizeImage(String filePath, {int? height = 1024, int? width = 1024, int? quality = 100}) async {
    final file = File(filePath);

    final bytes = await file.readAsBytes();
    print("Picture original size: ${bytes.length}");
    final image = decodeImage(bytes);
    final resized = copyResize(image!, width: width, height: height);
    final resizedBytes = encodeJpg(resized, quality: quality!);
    print("Picture resized size: ${resizedBytes.length}");

    return file.writeAsBytes(resizedBytes);
  }

  ///
  /// Insert uploadImage to database
  ///
  Future<void> addFiles({
    required List<PlatformFile> files,
    required Function(List<dynamic> uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    int countSize = 0;
    const int maxMBFilesSize = 50;

    for (var i = 0; i < files.length; i++) {
      countSize += files[i].size;
    }
    if (countSize > maxMBFilesSize * 1024 * 1024) {
      return onError(Exception('Dung lượng file không quá $maxMBFilesSize MB, vui lòng chọn file khác'));
    }

    final ApiResponse apiResponse = await regionRepo!.addFiles(files);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]' ? apiResponse.response.data['files'] as List<dynamic> : [];

      onSuccess(results.map((e) => e).toList());
    } else {
      onError(apiResponse.error);
    }
  }


  

  ///
  /// find
  ///
  Future<void> find({
    required String id,
    required Function(List<dynamic> uploadImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]' ? apiResponse.response.data['files'] as List<dynamic> : [];

      onSuccess(results.map((e) => e).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// find
  ///
  // Future<void> confirmFilesOrImages({
  //   required List<String> files,
  //   required Function(List<dynamic> uploadImage) onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //   final ApiResponse apiResponse =
  //       await regionRepo!.confirmFilesOrImages(files);
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     final results = apiResponse.response.data.toString() != '[]'
  //         ? apiResponse.response.data['files'] as List<dynamic>
  //         : [];

  //     onSuccess(results.map((e) => e).toList());
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }
}
