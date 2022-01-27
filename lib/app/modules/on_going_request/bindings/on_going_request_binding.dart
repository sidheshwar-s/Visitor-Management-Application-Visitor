import 'package:get/get.dart';

import '../controllers/on_going_request_controller.dart';

class OnGoingRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnGoingRequestController>(
      () => OnGoingRequestController(),
    );
  }
}
