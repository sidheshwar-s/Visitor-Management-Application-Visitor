import 'package:get/get.dart';

import '../controllers/request_meeting_controller.dart';

class RequestMeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestMeetingController>(
      () => RequestMeetingController(),
    );
  }
}
