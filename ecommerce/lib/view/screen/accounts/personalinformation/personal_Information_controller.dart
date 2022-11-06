import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/account_routes.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_date.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class PersonalInformationController extends GetxController {
//khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserResponse? userResponse;
  UserRequest userRequest = UserRequest();

  List<UserResponse> listUserResponse = [];
  List<Map<String, dynamic>> listPerson = [];
  String? idUser;
  //  valiable
  bool isloading = false;

  // khai bao

  @override
  void onInit() {
    idUser = sl<SharedPreferenceHelper>().getProfile;
    _getDataUser();

    // TODO: implement onInit
    super.onInit();
  }

  ///
  ///getDataUser
  ///

  void _getDataUser() {
    isloading = true;
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getProfile,
      onSuccess: (UserResponse user) {
        userResponse = user;
        print("hello ${userResponse!.born}");
        print(
            "date ngay ${IZIDate.formatDate2(DateTime.fromMillisecondsSinceEpoch(userResponse!.born!))}");

        listPerson = [
          {
            'name': 'Tên đăng nhập',
            'title': userResponse!.username ?? 'chưa có'
          },
          {
            'name': 'Giới tính',
            'title': getGender(userResponse!.gender ?? "Chưa có ")
          },
          {
            'name': 'Ngày sinh',
            'title': IZIDate.formatDate(
                DateTime.fromMicrosecondsSinceEpoch(userResponse!.born!))
          },
          {'name': 'Email', 'title': userResponse!.email ?? "Chưa có "},
          {
            'name': 'Số điện thoại',
            'title': '0${userResponse!.phone ?? "Chưa có "}'
          },
        ];
        print("id user = ${userResponse!.id}");
        isloading = false;
        update();
      },
      onError: (onError) {
        print("in find id $onError");
        // Get.find<DashBoardController>().checkLogin();
      },
    );
  }

  ///
  /// Get gender.
  ///
  String getGender(String gender) {
    if (gender.toString() == "FEMALE") {
      userResponse!.gender = "Nữ";
    } else if (gender.toString() == "MALE") {
      userResponse!.gender = "Nam";
    } else {
      userResponse!.gender = "Khác";
    }
    return userResponse!.gender!;
  }

  ///
  ///GotoUpdate
  ///
  void gotoUpdate() {
    Get.toNamed(AccountRoutes.INPUT_PERSONAL_INFORMATION,
            arguments: userResponse)
        ?.then((value) {
      print(value);
      _getDataUser();
    });
  }
}
