// ignore_for_file: use_setters_to_change_properties

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/rate/rate_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/rate_provider.dart';
import 'package:video_player/video_player.dart';

class ProductsReviewsController extends GetxController {
  // RateResponse rateResponse = RateResponse();
  final RateProvider rateProvider = GetIt.I.get<RateProvider>();

  List<RateResponse> rateOriginResponseList = <RateResponse>[];

  List<RateResponse> rateResponseListNew = <RateResponse>[];
  final RefreshController refreshController = RefreshController();

  List<Map<String, dynamic>> listAll = [
    {'title': 'Tất cả'},
    {'title': 'Có bình luận'},
    {'title': 'Có hình ảnh/video'},
  ];

  //dung paginate
  //
  int page = 1;
  int limit = 5;
  int? ratingNumber;
  int indexTitle = 0;

  // dung paginate
  int sumRate = 0;
// load total Rate
  bool isLoadTotalRate = true;

  VideoPlayerController? videoController;
  Future<void>? initializeControllerFuture;
  List<VideoPlayerController> videoList = [];
  List<Future<void>> futureList = [];
  @override
  void onInit() {
    super.onInit();
    getData(isRefesh: true);
  }

  @override
  void onClose() {
    super.onClose();
    for (final element in videoList) {
      element.dispose();
    }
  }

  void onChangeSelectRate(int index) {
    if (ratingNumber == index + 1) {
      return;
    }
    ratingNumber = index + 1;
    update();
  }

  void onTapTitle(int index) {
    ratingNumber = null;
    indexTitle = index;
    // getData(isRefesh: true);

    update();
  }

  String filter() {
    String filter = '';
    if (!IZIValidate.nullOrEmpty(ratingNumber)) {
      filter += '&point=$ratingNumber';
      print("kkkkk$ratingNumber}");
    } else {
      filter = "";
    }

    return filter;
  }

  // get data
  void getData({required bool isRefesh}) {
    if (isRefesh) {
      page = 1;

      rateResponseListNew.clear();
    } else {
      page++;
    }
    rateProvider.paginate(
        page: page++,
        limit: 50,
        filter: '&product=${Get.arguments as String}&populate=user',
        onSuccess: (rates) {
          if (rateOriginResponseList.isEmpty) {
            rateOriginResponseList = rates;
          }

          // }
          if (isRefesh) {
            refreshController.resetNoData();
            refreshController.refreshCompleted();
            if (isLoadTotalRate) {
              sumRate += rateOriginResponseList.length;
            }
          } else {
            refreshController.loadNoData();
            refreshController.loadComplete();
            for (var i = 0; i < videoList.length; i++) {
              videoList[i].dispose();
            }
          }

          isLoadTotalRate = false;
          initVideos();

          update();
        },
        onError: (onError) {
          print("An error while get rates $onError");
        });
  }

  void initVideos() {
    videoList = List.generate(rateOriginResponseList.length, (index) {
      if (!IZIValidate.nullOrEmpty(rateOriginResponseList[index].video)) {
      return  VideoPlayerController.network(
            rateOriginResponseList[index].video!.first);
      } else {
        return VideoPlayerController.network("");
      }
    });

    futureList = List.generate(
        rateOriginResponseList.length,
        (index) => IZIValidate.nullOrEmpty(videoList[index])
            ? Future<void>(() {})
            : videoList[index].initialize());
    // .then((value) => videoList[index].play()));

    for (var i = 0; i < videoList.length; i++) {
      videoList[i].setPlaybackSpeed(0.25);
      videoList[i].addListener(() {
        // ignore: unnecessary_statements
        update();
      });
    }
  }

  // loadmore
  void loadMore() {
    getData(isRefesh: false);
  }
  //refresh

  void refresh2() {
    getData(isRefesh: true);
  }

  void buttonOnOffVideo(VideoPlayerController videoPlayerController) {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      // If the video is paused, play it.
      videoPlayerController.play();
    }
    update();
  }
}
