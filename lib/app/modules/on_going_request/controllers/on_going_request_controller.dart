import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/controllers/request_meeting_controller.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/meeting_model.dart';
import 'package:vms_visitor_flutter/app/routes/app_pages.dart';

class OnGoingRequestController extends GetxController {
  MeetingModel? meetingModel =
      Get.find<RequestMeetingController>().meetingModel;

  RxString status = RxString('upComing');

  @override
  void onInit() {
    super.onInit();
    handleRoutes();
  }

  void handleRoutes() async {
    await Future.delayed(const Duration(seconds: 55));

    if (status.value == 'upcoming') {
      log("changing route due to timeout");
      Future.delayed(const Duration(seconds: 5), () {
        Get.offAllNamed(Routes.HOME);
      });
      WidgetsBinding.instance?.addPostFrameCallback(
        (timeStamp) {
          Get.defaultDialog(
            title: '',
            titlePadding: const EdgeInsets.only(),
            content: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: kRed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.no_accounts_sharp),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Sorry no response from the employee, Try again or come back later",
                  style: Get.textTheme.headline6?.copyWith(height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "THANK YOU!",
                )
              ],
            ),
            onWillPop: () async {
              Get.offAllNamed(Routes.HOME);
              return true;
            },
          );
        },
      );
    }
  }
}
