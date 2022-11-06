import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repositories/banner_reponsitory.dart';
import 'package:template/data/repositories/conversation_reponsitory.dart';
import 'package:template/data/repositories/district_reponsitory.dart';
import 'package:template/data/repositories/image_upload_reponsitore.dart';
import 'package:template/data/repositories/message_reponsitory.dart';
import 'package:template/data/repositories/order_reponsitory.dart';
import 'package:template/data/repositories/policy_and_term_reponsitory.dart';
import 'package:template/data/repositories/province_reponsitory.dart';
import 'package:template/data/repositories/setting_repository.dart';
import 'package:template/data/repositories/village_reponsitory.dart';
import 'package:template/data/repositories/news_category_reponsitory.dart';
import 'package:template/data/repositories/news_repository.dart';
import 'package:template/data/repositories/notification_reponsitory.dart';
import 'package:template/helper/izi_network.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/helper/socket_service.dart';
import 'package:template/provider/conversation_provider.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/message_provider.dart';
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/data/repositories/brand_reponsitory.dart';
import 'package:template/data/repositories/cart_repository.dart';
import 'package:template/data/repositories/category_reponsitory.dart';
import 'package:template/data/repositories/flash_sale_repository.dart';
import 'package:template/data/repositories/product_reponsitory.dart';
import 'package:template/data/repositories/setting_bank_repository.dart';
import 'package:template/data/repositories/transaction_repository.dart';
import 'package:template/data/repositories/voucher_reponsitory.dart';
import 'package:template/data/repositories/rate_reponsitory.dart';
import 'package:template/data/repositories/setting_payment_gateway_repository.dart';
import 'package:template/provider/address_provider.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/banner_provider.dart';
import 'package:template/provider/brand_provider.dart';
import 'package:template/provider/cart_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/flash_sale_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/rate_provider.dart';
import 'package:template/provider/setting_payment_gateway_provider.dart';
import 'package:template/provider/news_category_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/provider/setting_bank_provider.dart';
import 'package:template/provider/settings_provider.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/provider/village_provider.dart';
import 'package:template/provider/voucher_provider.dart';
import 'package:template/data/repositories/auth_repository_impl.dart';

import 'package:template/utils/internet_connection.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

import 'data/repositories/user_reponsitory.dart';
import 'provider/image_upload_provider.dart';
import 'provider/policy_and_term_provider.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));
  sl.registerLazySingleton(() => SocketService());
  sl.registerSingleton<IZISize>(IZISize());
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnection());

  // !Core
  sl.registerLazySingleton(() => IZINetwork(sl()));
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => UserProvider());
  sl.registerLazySingleton(() => UserRepository());
  sl.registerLazySingleton(() => CategoryReponsitory());
  sl.registerLazySingleton(() => CategoryProvider());
  sl.registerLazySingleton(() => BrandRepository());
  sl.registerLazySingleton(() => BrandProvider());
  // !Repositories
  sl.registerLazySingleton(() => ConversationRepository());
  sl.registerLazySingleton(() => MessageRepository());
  sl.registerLazySingleton(() => AddressRepository());
  sl.registerLazySingleton(() => OrderRepository());
  sl.registerLazySingleton(() => ProductRepository());

  //!Provider
  sl.registerLazySingleton(() => ConversationProvider());
  sl.registerLazySingleton(() => MessageProvider());
  sl.registerLazySingleton(() => ImageUploadRepository());
  sl.registerLazySingleton(() => ImageUploadProvider());
  sl.registerLazySingleton(() => AddressProvider());
  sl.registerLazySingleton(() => OrderProvider());

  sl.registerLazySingleton(() => SettingPayMentGateWayProvider());
  sl.registerLazySingleton(() => SettingPayMentGateWayRepository());

  sl.registerLazySingleton(() => ProductProvider());

  sl.registerLazySingleton(() => NewsCategoryProvider());
  sl.registerLazySingleton(() => NewsCategoryReponsitory());

  sl.registerLazySingleton(() => NewsProvider());
  sl.registerLazySingleton(() => NewsReponsitory());

  sl.registerLazySingleton(() => RateRepository());
  sl.registerLazySingleton(() => RateProvider());

  sl.registerLazySingleton(() => CartRepository());
  sl.registerLazySingleton(() => CartProvider());

  sl.registerLazySingleton(() => VoucherReponsitory());
  sl.registerLazySingleton(() => VoucherProvider());

  sl.registerLazySingleton(() => NotificationReponsitory());
  sl.registerLazySingleton(() => NotificationProvider());

  sl.registerLazySingleton(() => TransactionReponsitory());
  sl.registerLazySingleton(() => TransactionProvider());

  sl.registerLazySingleton(() => ProvinceReponsitory());
  sl.registerLazySingleton(() => ProvinceProvider());

  sl.registerLazySingleton(() => DistrictReponsitory());
  sl.registerLazySingleton(() => DistrictProvider());

  sl.registerLazySingleton(() => VillageReponsitory());
  sl.registerLazySingleton(() => VillageProvider());

  sl.registerLazySingleton(() => SettingBankProvider());
  sl.registerLazySingleton(() => SettingBankReponsitory());
  sl.registerLazySingleton(() => BannerRepository());
  sl.registerLazySingleton(() => BannerProvider());

  sl.registerLazySingleton(() => FlashSaleRepository());
  sl.registerLazySingleton(() => FlashSaleProvider());
  sl.registerLazySingleton(() => SettingRepository());
  sl.registerLazySingleton(() => SettingsProvider());
  sl.registerLazySingleton(() => PolicyAndTermReponsitory());
  sl.registerLazySingleton(() => PolicyAndTermProvider());
}
