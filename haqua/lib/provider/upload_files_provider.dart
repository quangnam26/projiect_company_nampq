import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:image/image.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/upload_files/upload_files_request.dart';
import 'package:template/data/model/upload_files/upload_files_response.dart';
import 'package:template/data/repository/upload_files_repository.dart';

class UploadFilesProvider {
  UploadFilesRepository? regionRepo = GetIt.I.get<UploadFilesRepository>();

  UploadFilesProvider();

  ///
  /// uploadFilesTemp
  ///
  Future<void> uploadFilesTemp({
    required List<File> files,
    required Function(UploadFilesResponse files) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.createUploadFilesTemp(files);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UploadFilesResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Confirm Upload Files
  ///
  Future<void> confirmUploadFiles({
    required UploadFilesRequest data,
    required Function(List<UploadFilesResponse> files) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.confirmUploadFiles(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => UploadFilesResponse.fromJsonConfirmFiles(e as dynamic)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// ResizeImage
  ///
  static Future<File> resizeImage(String filePath, {int? height = 1024, int? width = 1024, int? quality = 100}) async {
    final file = File(filePath);

    final bytes = await file.readAsBytes();
    print("Picture original size: ${bytes.length}");
    final image = decodeImage(bytes);
    final resized = copyResize(image!, width: width, height: height);
    final resizedBytes = encodeJpg(resized, quality: quality!);
    print("Picture resized size: ${resizedBytes.length}");

    return file.writeAsBytes(resizedBytes);
  }
}
