import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/root_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/request_meeting/bindings/request_meeting_binding.dart';
import '../modules/request_meeting/views/request_meeting_view.dart';
import '../modules/visitor_details/bindings/visitor_details_binding.dart';
import '../modules/visitor_details/views/details_view.dart';
import '../modules/visitor_details/views/otp_view.dart';
import '../modules/visitor_details/views/visitor_details_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const RootView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.VISITOR_DETAILS,
      page: () => const VisitorDetailsView(),
      binding: VisitorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: VisitorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.VISITOR_DETAILS_FORM,
      page: () => const DetailsView(),
      binding: VisitorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_MEETING,
      page: () => const RequestMeetingView(),
      binding: RequestMeetingBinding(),
    ),
  ];
}
