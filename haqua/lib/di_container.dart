import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/repository/auth_repository.dart';
import 'package:template/data/repository/history_quiz_repository.dart';
import 'package:template/data/repository/notification_repository.dart';
import 'package:template/data/repository/otp_repository.dart';
import 'package:template/data/repository/province_repository.dart';
import 'package:template/data/repository/question_repository.dart';
import 'package:template/data/repository/quiz_repository.dart';
import 'package:template/data/repository/reviews_repository.dart';
import 'package:template/data/repository/settings_repository.dart';
import 'package:template/data/repository/specialize_reponsitory.dart';
import 'package:template/data/repository/subspecialize_repository.dart';
import 'package:template/data/repository/transaction_repository.dart';
import 'package:template/data/repository/upload_files_repository.dart';
import 'package:template/data/repository/user_repository.dart';
import 'package:template/data/repository/userspecialize_repository.dart';
import 'package:template/data/repository/withdraw_money_respository.dart';
import 'package:template/helper/izi_network.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/certificate_provider.dart';
import 'package:template/provider/history_quiz_provider.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/provider/otp_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/quiz_provider.dart';
import 'package:template/provider/reviews_provider.dart';
import 'package:template/provider/settings_provider.dart';
import 'package:template/provider/specialize_provider.dart';
import 'package:template/provider/subspecialize_provider.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/upload_files_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/provider/userspecialize_provider.dart';
import 'package:template/provider/withdraw_money_provider.dart';
import 'data/datasource/remote/dio/izi_socket.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/certificate_repository.dart';
import 'sharedpref/shared_preference_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// External.
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<IZISize>(IZISize());
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

  /// Core.
  sl.registerLazySingleton(() => IZINetwork(sl()));
  sl.registerSingleton<DioClient>(DioClient());

  /// Socket.
  sl.registerSingleton<IZISocket>(IZISocket());


  /// Auth.
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => AuthProvider());

  /// Question.
  sl.registerLazySingleton(() => QuestionRepository());
  sl.registerLazySingleton(() => QuestionProvider());

  /// SubSpecialize.
  sl.registerLazySingleton(() => SubSpecializeRepository());
  sl.registerLazySingleton(() => SubSpecializeProvider());

  /// OTP.
  sl.registerLazySingleton(() => OTPRepository());
  sl.registerLazySingleton(() => OTPProvider());

  /// UserSpeciaLize.
  sl.registerLazySingleton(() => UserSpeciaLizeRepository());
  sl.registerLazySingleton(() => UserSpecializeProvider());

  /// Specialize.
  sl.registerLazySingleton(() => SpecializeRepository());
  sl.registerLazySingleton(() => SpecializeProvider());

  /// Upload Files.
  sl.registerLazySingleton(() => UploadFilesRepository());
  sl.registerLazySingleton(() => UploadFilesProvider());

  /// User.
  sl.registerLazySingleton(() => UserRepository());
  sl.registerLazySingleton(() => UserProvider());

  //Transaction
  sl.registerLazySingleton(() => TransactionRepository());
  sl.registerLazySingleton(() => TransactionProvider());

  /// Reviews.
  sl.registerLazySingleton(() => ReviewsReponsitory());
  sl.registerLazySingleton(() => ReviewsProvider());

  /// Notification.
  sl.registerLazySingleton(() => NotificationRepository());
  sl.registerLazySingleton(() => NotificationProvider());

  /// Provinces.
  sl.registerLazySingleton(() => WithDrawMoneyRespository());
  sl.registerLazySingleton(() => WithDrawMoneyProvider());

  /// Account.
  sl.registerLazySingleton(() => ProvinceRepository());
  sl.registerLazySingleton(() => ProvinceProvider());

  /// Certificate.
  sl.registerLazySingleton(() => CertificateRepository());
  sl.registerLazySingleton(() => CertificateProvider());

  /// History quiz.
  sl.registerLazySingleton(() => HistoryQuizRepository());
  sl.registerLazySingleton(() => HistoryQuizProvider());

  /// Quiz.
  sl.registerLazySingleton(() => QuizReposository());
  sl.registerLazySingleton(() => QuizProvider());

  /// Settings.
  sl.registerLazySingleton(() => SettingsRepository());
  sl.registerLazySingleton(() => SettingsProvider());
}
