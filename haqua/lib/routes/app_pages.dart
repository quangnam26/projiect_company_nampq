import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/routes/route_path/areas_of_expertise_routers.dart';
import 'package:template/routes/route_path/%20transaction_details_routers.dart';
import 'package:template/routes/route_path/account_routers.dart';
import 'package:template/routes/route_path/bank_transfer_routers.dart';
import 'package:template/routes/route_path/call_screen_routers.dart';
import 'package:template/routes/route_path/create_question_routers.dart';
import 'package:template/routes/route_path/detail_profile_people_routers.dart';
import 'package:template/routes/route_path/detail_question_routers.dart';
import 'package:template/routes/route_path/help_wating_list_routers.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/routes/route_path/introduction_routers.dart';
import 'package:template/routes/route_path/izi_preview_image_routers.dart';
import 'package:template/routes/route_path/izi_successful_routers.dart';
import 'package:template/routes/route_path/login_routers.dart';
import 'package:template/routes/route_path/otp_screen_routers.dart';
import 'package:template/routes/route_path/quotation_routers.dart';
import 'package:template/routes/route_path/ready_routers.dart';
import 'package:template/routes/route_path/my_wallet_routers.dart';
import 'package:template/routes/route_path/notification_routers.dart';
import 'package:template/routes/route_path/recharge_routers.dart';
import 'package:template/routes/route_path/review_and_payment_routers.dart';
import 'package:template/routes/route_path/share_video_routers.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/routes/route_path/thank_you_routers.dart';
import 'package:template/routes/route_path/withdraw_money_routers.dart';

import 'route_path/payment_for_people_answer_ques_routers.dart';
import 'route_path/sign_in_or_sign_up_routers.dart';
import 'route_path/sign_up_routers.dart';

class AppPages {
  static List<GetPage> list = [
    //  ... NotificationRouters.list,
    ...SplashRoutes.list,
    ...HomeRoutes.list,
    ...AccountRouter.list,
    ...QuotationRoutes.list,
    ...CreateQuestionRoutes.list,
    ...DetailQuestionRoutes.list,
    ...IZIPreviewImageRoutes.list,
    ...IZISuccessfulRoutes.list,
    ...CallVideoScreenRoutes.list,
    ...ReviewAndPaymentRoutes.list,
    ...HelpWatingListRoutes.list,
    ...DetailProfilePeopleListRoutes.list,
    ...PaymentForPeppleAnswerQuesListRoutes.list,
    ...ShareVideoRoutes.list,
    ...RechargeRouters.list,
    ...BankTranferRouters.list,
    ...IntroductionRoutes.list,
    ...SignInOrSignUpRoutes.list,
    ...LoginRoutes.list,
    ...SignUpRoutes.list,
    ...OTPScreenRoutes.list,
    ...AreasOfExpertiseRoutes.list,
    ...ThankYouRoutes.list,
    ...ReadyScreenRoutes.list,
    ...NotificationRouters.list,
    ...MyWalletRouters.list,
    ...TransactionDetailsRouters.list,
    ...WithDrawMoneyRouters.list
  ];
}
