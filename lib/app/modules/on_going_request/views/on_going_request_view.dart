import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/controllers/request_meeting_controller.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/employee_model.dart';
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
            : SingleChildScrollView(
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
                          backgroundImage: NetworkImage(employeeModel.image!),
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
                        style: Get.textTheme.headline6?.copyWith(color: kRed),
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
              ),
      ),
    );
  }
}
