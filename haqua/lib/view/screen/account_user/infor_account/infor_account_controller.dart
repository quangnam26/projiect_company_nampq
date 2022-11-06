// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/experience/experience_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/upload_files/upload_files_request.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/upload_files_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

import '../../../../data/model/history_quiz/history_quiz_response.dart';
import '../../../../provider/history_quiz_provider.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../routes/route_path/izi_preview_image_routers.dart';

class InforAccountController extends GetxController {
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  final UploadFilesProvider uploadFilesProvider = GetIt.I.get<UploadFilesProvider>();
  final SettingsProvider settingProvider = GetIt.I.get<SettingsProvider>();
  final HistoryQuizProvider historyQuizProvider = GetIt.I.get<HistoryQuizProvider>();
  Rx<UserResponse> userResponse = UserResponse().obs;
  RxList<ProvinceResponse> provinceResponseList = <ProvinceResponse>[].obs;
  Rx<ProvinceResponse> provinceResponse = ProvinceResponse().obs;
  RxList<ExperienceResponse> experienceRequestList = <ExperienceResponse>[].obs;
  RxList<HistoryQuizResponse> historyQuizResponseList = <HistoryQuizResponse>[].obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isJustOneClick = false.obs;
  RxBool isEditedAvatar = false.obs;
  RxBool isEditedAlbum = false.obs;
  RxString phoneNumberController = ''.obs;
  RxString fullNameController = ''.obs;
  RxString bornController = ''.obs;
  RxString sexController = ''.obs;
  RxString countryController = ''.obs;
  RxString jobController = ''.obs;
  RxString expertiseController = ''.obs;
  RxString yearController = ''.obs;
  RxString errorTextName = ''.obs;
  RxString errorTextExperience = ''.obs;
  RxString errorTextYear = ''.obs;
  RxList<String> capacityList = <String>[].obs;
  RxList<String> newCapacityList = <String>[].obs;
  RxList<String> albumsList = <String>[].obs;
  RxList<String> newAlbumsList = <String>[].obs;
  double quizPercent = 0;

  @override
  void onInit() {
    /// Call API get quiz percent .
    getQuizPercent();
    super.onInit();
  }

  @override
  void dispose() {
    userResponse.close();
    provinceResponseList.close();
    provinceResponse.close();
    experienceRequestList.close();
    isJustOneClick.close();
    isEditedAvatar.close();
    isEditedAlbum.close();
    phoneNumberController.close();
    fullNameController.close();
    bornController.close();
    sexController.close();
    countryController.close();
    jobController.close();
    expertiseController.close();
    yearController.close();
    errorTextName.close();
    errorTextExperience.close();
    errorTextYear.close();
    capacityList.close();
    newCapacityList.close();
    albumsList.close();
    newAlbumsList.close();
    historyQuizResponseList.close();
    super.dispose();
  }

  ///
  /// Call API get quiz percent .
  ///
  void getQuizPercent() {
    settingProvider.findSetting(
      onSuccess: (model) {
        if (!IZIValidate.nullOrEmpty(model)) {
          quizPercent = IZINumber.parseDouble(model!.quizPassPercent.toString());
        }

        /// Call API get data user.
        getUserById();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data user.
  ///
  void getUserById() {
    userProvider.find(
      id: "${sl<SharedPreferenceHelper>().getIdUser}?populate=idProvince",
      onSuccess: (model) {
        userResponse.value = model;

        /// Call API get data province.
        getAllProvinces();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data province.
  ///
  void getAllProvinces() {
    provinceProvider.all(
      onSuccess: (models) {
        provinceResponseList.value = models;

        /// Mapping data.
        mappingData();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Mapping data.
  ///
  void mappingData() {
    if (!IZIValidate.nullOrEmpty(userResponse.value.phone)) {
      phoneNumberController.value = userResponse.value.phone.toString();
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.fullName)) {
      fullNameController.value = userResponse.value.fullName.toString();
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.born)) {
      bornController.value = IZIDate.formatDate(userResponse.value.born!);
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.idProvince)) {
      provinceResponse.value = provinceResponseList[provinceResponseList.indexWhere((e) => e.id.toString() == userResponse.value.idProvince!.id.toString())];
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.gender)) {
      sexController.value = IZIValidate.getGenderString(userResponse.value.gender);
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.nation)) {
      countryController.value = IZIValidate.genValueStringNation(userResponse.value.nation!);
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.job)) {
      jobController.value = userResponse.value.job.toString();
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.experiences)) {
      experienceRequestList.value = userResponse.value.experiences!;
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.capacity)) {
      capacityList.value = userResponse.value.capacity!.map<String>((e) => e.toString()).toList();
    }

    if (!IZIValidate.nullOrEmpty(userResponse.value.myAlbum)) {
      albumsList.value = userResponse.value.myAlbum!.map<String>((e) => e.toString()).toList();
    }

    /// Call API get certificates.
    getCertificates();
  }

  ///
  /// Call API get certificates.
  ///
  void getCertificates() {
    historyQuizProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idUser=${sl<SharedPreferenceHelper>().getIdUser}&percent>=$quizPercent&populate=idCertificate',
      onSuccess: (models) {
        if (models.isNotEmpty) {
          historyQuizResponseList.value = models;
        }

        /// Just [update] first load [Info user page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// On validate name.
  ///
  String? onValidateName(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorTextName.value = "validate_name_1".tr;
    }
    if (val.length < 3) {
      return errorTextName.value = "validate_name_2".tr;
    }
    if (val.length > 27) {
      return errorTextName.value = "validate_name_3".tr;
    }

    return errorTextName.value = "";
  }

  ///
  /// On change value name.
  ///
  void onChangedValueName(String val) {
    fullNameController.value = val;
  }

  ///
  /// On change value born.
  ///
  void onChangedBorn(String val) {
    bornController.value = val;
  }

  ///
  /// On change value gender.
  ///
  void onChangedGender(String val) {
    sexController.value = val;
  }

  ///
  /// On change value province.
  ///
  void onChangedProvince(ProvinceResponse val) {
    provinceResponse.value = val;
  }

  ///
  /// On change value province.
  ///
  void onChangedCountry(String val) {
    countryController.value = val;
  }

  ///
  /// On change value job.
  ///
  void onChangedJob(String val) {
    jobController.value = val;
  }

  ///
  /// On validate experience.
  ///
  String? onValidateExperience(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorTextExperience.value = "validate_experience".tr;
    }

    return errorTextExperience.value = "";
  }

  ///
  /// On change value experience.
  ///
  void onChangedExperience(String val) {
    expertiseController.value = val;
  }

  ///
  /// On validate year.
  ///
  String? onValidateYear(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorTextYear.value = "validate_year".tr;
    }

    return errorTextYear.value = "";
  }

  ///
  /// On change value year.
  ///
  void onChangedYear(String val) {
    yearController.value = val;
  }

  ///
  /// Generate experience button.
  ///
  bool genBollButtonExperience() {
    if (!IZIValidate.nullOrEmpty(expertiseController) && !IZIValidate.nullOrEmpty(yearController)) {
      return true;
    }
    return false;
  }

  ///
  /// add experience.
  ///
  void addExperience() {
    final ExperienceResponse experienceResponse = ExperienceResponse();
    experienceResponse.fieldName = expertiseController.value;
    experienceResponse.year = IZINumber.parseInt(yearController);
    experienceRequestList.add(experienceResponse);
  }

  ///
  /// Generate update button.
  ///
  bool genBollButtonUpdate() {
    if (!IZIValidate.nullOrEmpty(fullNameController.value)) {
      return true;
    }
    return false;
  }

  ///
  /// Pick avatar.
  ///
  Future<void> pickAvatar() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (images == null) return;
      EasyLoading.show(status: 'please_waiting'.tr);

      final List<File> files = [File(images.path)];

      // load files
      uploadFilesProvider.uploadFilesTemp(
        files: files,
        onSuccess: (value) {
          userResponse.value.avatar = value.files!.map<String>((e) => e.toString()).toList().first;
          update();
          isEditedAvatar.value = true;
          EasyLoading.dismiss();
        },
        onError: (e) {
          EasyLoading.dismiss();
          IZIToast().error(message: e.toString());
        },
      );
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIToast().error(message: 'allow_system'.tr);
      AppSettings.openAppSettings();
    }
  }

  ///
  /// Pick albums.
  ///
  Future<void> pickAlbums() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'please_waiting'.tr);

      final List<File> files = images.map((e) => File(e.path)).toList();

      if (files.length > 5) {
        EasyLoading.dismiss();
        IZIToast().error(message: "validate_images".tr);
      } else {
        // load files
        uploadFilesProvider.uploadFilesTemp(
          files: files,
          onSuccess: (value) {
            albumsList.addAll(value.files!.map<String>((e) => e.toString()).toList());
            isEditedAlbum.value = true;
            EasyLoading.dismiss();
          },
          onError: (e) {
            EasyLoading.dismiss();
            IZIToast().error(message: e.toString());
          },
        );
      }
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIToast().error(message: 'allow_system'.tr);
      AppSettings.openAppSettings();
    }
  }

  ///
  /// On delete files.
  ///
  void onDeleteFiles({required String file, required List<String> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
  }

  ///
  /// On delete experience.
  ///
  void onDeleteExperience({required int index}) {
    experienceRequestList.removeAt(index);
  }

  ///
  /// Go to [Preview image page].
  ///
  void goToPreviewImage({required String imageUrl}) {
    Get.toNamed(IZIPreviewImageRoutes.IZI_PREVIEW_IMAGE, arguments: imageUrl);
  }

  ///
  /// On push data update profile user.
  ///
  void onPushDataUpdateProfileUser() {
    EasyLoading.show(status: "please_waiting".tr);
    if (isJustOneClick.value == false) {
      isJustOneClick.value = true;

      if (isEditedAvatar.value == false && isEditedAlbum.value == false) {
        ///
        /// Update profile user.
        updateProfileUser();
      } else if (isEditedAvatar.value == true && isEditedAlbum.value == false) {
        ///
        /// Validate confirm files.
        validateConfirmFiles();
      } else if (isEditedAvatar.value == false && isEditedAlbum.value == true) {
        if (!IZIValidate.nullOrEmpty(albumsList)) {
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = albumsList;
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              albumsList.value = models.map((e) => e.files!.first.toString()).toList();

              ///
              /// Update profile user.
              updateProfileUser();
            },
            onError: (error) {
              print(error);
            },
          );
        } else {
          ///
          /// Update profile user.
          updateProfileUser();
        }
      } else if (isEditedAvatar.value == true && isEditedAlbum.value == true) {
        if (!IZIValidate.nullOrEmpty(albumsList)) {
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = [userResponse.value.avatar];
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              userResponse.value.avatar = models.first.files!.first.toString();
              final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
              uploadFilesRequest.files = albumsList;
              uploadFilesProvider.confirmUploadFiles(
                data: uploadFilesRequest,
                onSuccess: (models) {
                  albumsList.value = models.map((e) => e.files!.first.toString()).toList();

                  ///
                  /// Update profile user.
                  updateProfileUser();
                },
                onError: (error) {
                  print(error);
                },
              );
            },
            onError: (error) {
              print(error);
            },
          );
        } else {
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = [userResponse.value.avatar];
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              userResponse.value.avatar = models.first.files!.first.toString();

              ///
              /// Update profile user.
              updateProfileUser();
            },
            onError: (error) {
              print(error);
            },
          );
        }
      } else {
        ///
        /// Validate confirm files.
        validateConfirmFiles();
      }
    }
  }

  ///
  ///  Validate confirm files.
  ///
  void validateConfirmFiles() {
    if (!IZIValidate.nullOrEmpty(userResponse.value.avatar) && !IZIValidate.nullOrEmpty(capacityList) && !IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = [userResponse.value.avatar];
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          userResponse.value.avatar = models.first.files!.first.toString();
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = capacityList;
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              capacityList.value = models.map((e) => e.files!.first.toString()).toList();
              final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
              uploadFilesRequest.files = albumsList;
              uploadFilesProvider.confirmUploadFiles(
                data: uploadFilesRequest,
                onSuccess: (models) {
                  albumsList.value = models.map((e) => e.files!.first.toString()).toList();

                  ///
                  /// Update profile user.
                  updateProfileUser();
                },
                onError: (error) {
                  print(error);
                },
              );
            },
            onError: (error) {
              print(error);
            },
          );
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (IZIValidate.nullOrEmpty(userResponse.value.avatar) && !IZIValidate.nullOrEmpty(capacityList) && !IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = capacityList;
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          capacityList.value = models.map((e) => e.files!.first.toString()).toList();
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = albumsList;
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              albumsList.value = models.map((e) => e.files!.first.toString()).toList();

              ///
              /// Update profile user.
              updateProfileUser();
            },
            onError: (error) {
              print(error);
            },
          );
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (!IZIValidate.nullOrEmpty(userResponse.value.avatar) && IZIValidate.nullOrEmpty(capacityList) && !IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = [userResponse.value.avatar];
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          userResponse.value.avatar = models.first.files!.first.toString();
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = albumsList;
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              albumsList.value = models.map((e) => e.files!.first.toString()).toList();

              ///
              /// Update profile user.
              updateProfileUser();
            },
            onError: (error) {
              print(error);
            },
          );
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (!IZIValidate.nullOrEmpty(userResponse.value.avatar) && !IZIValidate.nullOrEmpty(capacityList) && IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = [userResponse.value.avatar];
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          userResponse.value.avatar = models.first.files!.first.toString();
          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = capacityList;
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (models) {
              capacityList.value = models.map((e) => e.files!.first.toString()).toList();

              ///
              /// Update profile user.
              updateProfileUser();
            },
            onError: (error) {
              print(error);
            },
          );
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (IZIValidate.nullOrEmpty(userResponse.value.avatar) && IZIValidate.nullOrEmpty(capacityList) && !IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = albumsList;
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          albumsList.value = models.map((e) => e.files!.first.toString()).toList();

          ///
          /// Update profile user.
          updateProfileUser();
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (!IZIValidate.nullOrEmpty(userResponse.value.avatar) && IZIValidate.nullOrEmpty(capacityList) && IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = [userResponse.value.avatar];
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          userResponse.value.avatar = models.first.files!.first.toString();

          ///
          /// Update profile user.
          updateProfileUser();
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (IZIValidate.nullOrEmpty(userResponse.value.avatar) && !IZIValidate.nullOrEmpty(capacityList) && IZIValidate.nullOrEmpty(albumsList)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = capacityList;
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (models) {
          capacityList.value = models.map((e) => e.files!.first.toString()).toList();

          ///
          /// Update profile user.
          updateProfileUser();
        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      updateProfileUser();
    }
  }

  ///
  /// updateProfileUser
  ///
  void updateProfileUser() {
    final UserRequest userRequest = UserRequest();
    if (!IZIValidate.nullOrEmpty(userResponse.value.avatar)) {
      userRequest.avatar = userResponse.value.avatar;
    }
    userRequest.fullName = fullNameController.value;
    if (bornController.value != '01-01-1970') {
      userRequest.bornRequest = IZIDate.formatDateTime(bornController.value.toString()).microsecondsSinceEpoch;
    }
    userRequest.gender = IZIValidate.getGenderValueCreateQuestion(sexController.value);
    if (!IZIValidate.nullOrEmpty(provinceResponse.value)) {
      userRequest.idProvinceRequest = provinceResponse.value.id.toString();
    }
    if (!IZIValidate.nullOrEmpty(countryController.value)) {
      userRequest.nation = countryController.value;
    }
    if (!IZIValidate.nullOrEmpty(jobController.value)) {
      userRequest.job = jobController.value;
    }
    if (!IZIValidate.nullOrEmpty(experienceRequestList)) {
      userRequest.experiences = experienceRequestList;
    }
    if (!IZIValidate.nullOrEmpty(capacityList)) {
      userRequest.capacity = capacityList;
    }
    if (!IZIValidate.nullOrEmpty(albumsList)) {
      userRequest.myAlbum = albumsList;
    }
    print('userRequest $userRequest');
    userProvider.update(
      data: userRequest,
      onSuccess: (model) {
        EasyLoading.dismiss();
        Get.back(result: model);
      },
      onError: (error) {
        EasyLoading.dismiss();
        print(error);
      },
    );
  }
}
