import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/controllers/request_meeting_controller.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/employee_model.dart';
import 'package:vms_visitor_flutter/app/routes/app_pages.dart';
import '../controllers/on_going_request_controller.dart';

class OnGoingRequestView extends GetView<OnGoingRequestController> {
  const OnGoingRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RequestMeetingController requestMeetingController =
        Get.find<RequestMeetingController>();
    EmployeeModel? employeeModel =
        requestMeetingController.meetingModel?.employee;

    controller.onInit();

    return Scaffold(
      body: SafeArea(
        child: employeeModel == null
            ? const Center(child: Text("Sorry something went wrong"))
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("meetings")
                    .doc(requestMeetingController.meetingModel!.id)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var status = snapshot.data['status'];
                    controller.status.value = status;
                    log(status);
                    if (status == 'accepted') {
                      handleAccepted();
                    }
                    if (status == 'rejected') {
                      handleRejection(snapshot.data['rejectedReasons']);
                    }
                    if (status == 'rescheduled') {
                      handleReschedule(snapshot.data['rescheduledTime']);
                    }
                  }
                  if (snapshot.hasError) {
                    const Center(
                      child: Text("Sorry something went wrong"),
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(employeeModel.image!),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            employeeModel.name ?? 'No name',
                            style: Get.textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Hold on we are requesting your meeting",
                            textAlign: TextAlign.center,
                            style:
                                Get.textTheme.headline6?.copyWith(color: kRed),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          LottieBuilder.asset('assets/lotties/connecting.json'),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              primary: kDarkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: kWhite,
                            ),
                            label: const Text(
                              "Back to List",
                              style: TextStyle(color: kWhite),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

void handleReschedule(String rescheduletime) {
  var time =
      DateFormat.jm().format(DateFormat("hh:mm:ss").parse(rescheduletime));
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
                color: kBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today,
                color: kWhite,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your meeting request was rescheduled",
              style: Get.textTheme.headline6?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Please comeback at $time",
              style: const TextStyle(fontWeight: FontWeight.bold),
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

void handleRejection(String rejectedReason) {
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
              child: const Icon(
                Icons.cancel,
                color: kWhite,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your meeting request was rejected",
              style: Get.textTheme.headline6?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              rejectedReason,
              style: const TextStyle(fontWeight: FontWeight.bold),
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

void handleAccepted() {
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
                color: kGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.done,
                color: kWhite,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your meeting request was accepted!",
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
