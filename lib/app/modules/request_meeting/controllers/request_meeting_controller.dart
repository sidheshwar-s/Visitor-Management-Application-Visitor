import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/additional_user_model.dart';

class RequestMeetingController extends GetxController {
  TextEditingController purposeController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxBool isLaptopOrMobile = RxBool(false);
  RxBool isVehicle = RxBool(false);
  RxBool isOthers = RxBool(false);
  RxList<AdditionalUserModel> additionalMembers = RxList<AdditionalUserModel>();
  RxnString purpopseErrorText = RxnString(null);
  RxnString vehicleNumberErrorText = RxnString(null);
}
