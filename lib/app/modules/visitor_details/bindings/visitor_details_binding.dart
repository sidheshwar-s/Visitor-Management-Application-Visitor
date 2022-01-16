import 'package:get/get.dart';

import '../controllers/visitor_details_controller.dart';

class VisitorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorDetailsController>(
      () => VisitorDetailsController(),
    );
  }
}
