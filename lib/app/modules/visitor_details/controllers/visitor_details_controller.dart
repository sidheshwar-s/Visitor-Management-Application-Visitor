import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/providers/visitor_details_provider.dart';

class VisitorDetailsController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  RxBool isLoading = RxBool(false);

  getVisitorsData() async {
    isLoading.value = true;
    await VisitorDetailsProvider().getVisitorDetails(mobileController.text);
    isLoading.value = false;
  }
}
