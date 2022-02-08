import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/additional_members_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/additional_user_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/employee_list_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/meeting_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/request_meeting_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/providers/request_meeting_providers.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/views/employee_list_view.dart';
import 'package:vms_visitor_flutter/app/routes/app_pages.dart';

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
  RxBool isLoading = RxBool(false);
  Rxn<EmployeesListModel?> employeesListModel = Rxn<EmployeesListModel?>();
  MeetingModel? meetingModel;
  static List<String> belongings = [];

  void getEmployeeList() async {
    isLoading.value = true;
    employeesListModel.value =
        await RequestMeetingProviders().getEmployeeList();
    isLoading.value = false;
    Get.to(() => const EmployeeListView());
  }

  void requestMeeting(String empId, BuildContext context) async {
    isLoading.value = true;
    RequestMeetingModel requestMeetingModel = RequestMeetingModel(
      empId: empId,
      purpose: purposeController.text,
      vehicleNumber: vehicleNumberController.text,
      belongings: getBelongings(),
      additionalMembers:
          AdditionalMembersModel(additionalMembers: additionalMembers),
    );
    meetingModel = await RequestMeetingProviders()
        .requestMeeting(requestMeetingModel, context);
    isLoading.value = false;
    log('got meeting details');
    Get.back();
    if (meetingModel != null) {
      Get.toNamed(Routes.ON_GOING_REQUEST);
    }
  }

  List<String>? getBelongings() {
    belongings.clear();
    if (isLaptopOrMobile.value) {
      belongings.add("Laptop/Mobile");
    }
    if (isVehicle.value) {
      belongings.add('Vehicle');
    }
    if (isOthers.value) {
      belongings.add('Others');
    }
    return belongings;
  }
}
