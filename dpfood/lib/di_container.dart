import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/socket_service/socket_service.dart';
import 'package:template/data/repositories/address_reponsitory.dart';
import 'package:template/data/repositories/auth_repository_impl.dart';
import 'package:template/data/repositories/banner_reponsitory.dart';
import 'package:template/data/repositories/category_reponsitory.dart';
import 'package:template/data/repositories/geo_reponsitory.dart';
import 'package:template/data/repositories/group_product_reponsitory.dart';

import 'package:template/data/repositories/image_upload_reponsitore.dart';
import 'package:template/data/repositories/notification_reponsitory.dart';
import 'package:template/data/repositories/product_reponsitory.dart';
import 'package:template/data/repositories/province_reponsitory.dart';
import 'package:template/data/repositories/transaction_reponsitory.dart';

import 'package:template/data/repositories/order_reponsitory.dart';
import 'package:template/data/repositories/review_reponsitory.dart';
import 'package:template/data/repositories/setting_reponsitory.dart';

import 'package:template/data/repositories/user_reponsitory.dart';
import 'package:template/data/repositories/voucher_reponsitory.dart';
import 'package:template/helper/izi_network.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/provider/address_provider.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/banner_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/geo_provider.dart';
import 'package:template/provider/group_product_provider.dart';

import 'package:template/provider/image_upload_provider.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/transaction_provider.dart';

import 'package:template/provider/order_provider.dart';
import 'package:template/provider/review_provider.dart';
import 'package:template/provider/setting_provider.dart';

import 'package:template/provider/user_provider.dart';
import 'package:template/provider/voucher_provider.dart';
import 'package:template/utils/geocoding.dart';
import 'package:template/utils/internet_connection.dart';
import 'package:template/utils/socket_service.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<IZISize>(IZISize());
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  // sl.registerSingleton<SocketService>(SocketService());
  sl.registerSingleton<IZISocket>(IZISocket());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => Geocoding());

  // Core
  sl.registerLazySingleton(() => IZINetwork(sl()));
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => UserRepository());
  sl.registerLazySingleton(() => CategoryRepository());
  sl.registerLazySingleton(() => GroupProductRepository());
  sl.registerLazySingleton(() => ProductRepository());
  sl.registerLazySingleton(() => BannerRepository());
  sl.registerLazySingleton(() => ProvinceRepository());

  sl.registerLazySingleton(() => ImageUploadRepository());
  sl.registerLazySingleton(() => TransactionRepository());

  sl.registerLazySingleton(() => GeoRepository());
  sl.registerLazySingleton(() => OrderRepository());
  sl.registerLazySingleton(() => ReviewRepository());
  sl.registerLazySingleton(() => SettingRepository());
  sl.registerLazySingleton(() => VoucherRepository());
  sl.registerLazySingleton(() => AddressRepository());

  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton(() => UserProvider());
  sl.registerLazySingleton(() => CategoryProvider());
  sl.registerLazySingleton(() => GroupProductProvider());
  sl.registerLazySingleton(() => ProductProvider());
  sl.registerLazySingleton(() => BannerProvider());
  sl.registerLazySingleton(() => ProvinceProvider());

  sl.registerLazySingleton(() => ImageUploadProvider());
  sl.registerLazySingleton(() => TransactionProvider());

  sl.registerLazySingleton(() => GeoProvider());
  sl.registerLazySingleton(() => OrderProvider());
  sl.registerLazySingleton(() => ReviewProvider());
  sl.registerLazySingleton(() => SettingProvider());
  sl.registerLazySingleton(() => VoucherProvider());
  sl.registerLazySingleton(() => AddressProvider());

  sl.registerLazySingleton(() => NotificationProvider());
  sl.registerLazySingleton(() => NotificationRepository());
}
