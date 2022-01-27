import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/views/add_additional_members_view.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/models/visitor_model.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/next_button.dart';

import '../controllers/request_meeting_controller.dart';

class RequestMeetingView extends GetView<RequestMeetingController> {
  const RequestMeetingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VisitorDetailsController visitorDetailsController =
        Get.find<VisitorDetailsController>();
    final VisitorModel visitorInfoModel =
        visitorDetailsController.visitorInfoModel!.visitor!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(visitorInfoModel.selfieLink!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hello ${visitorInfoModel.name} Welcome back,",
                  style: Get.textTheme.headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Enter your purpose of visit",
                  style: Get.textTheme.headline6
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextField(
                    controller: controller.purposeController,
                    decoration: InputDecoration(
                        hintText: "Purpose",
                        errorText: controller.purpopseErrorText.value),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Enter your vehicle number",
                  style: Get.textTheme.headline6
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextField(
                    controller: controller.vehicleNumberController,
                    decoration: InputDecoration(
                        errorText: controller.vehicleNumberErrorText.value,
                        hintText: "Vehicle Number"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Choose your belongings",
                  style: Get.textTheme.headline6
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => CheckboxListTile(
                    contentPadding: const EdgeInsets.only(),
                    title: const Text(
                      "Laptop/Mobile",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: controller.isLaptopOrMobile.value,
                    onChanged: (newValue) {
                      controller.isLaptopOrMobile.value = newValue ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    contentPadding: const EdgeInsets.only(),
                    title: const Text(
                      "Vehicle",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: controller.isVehicle.value,
                    onChanged: (newValue) {
                      controller.isVehicle.value = newValue ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    contentPadding: const EdgeInsets.only(),
                    title: const Text(
                      "Others",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: controller.isOthers.value,
                    onChanged: (newValue) {
                      controller.isOthers.value = newValue ?? false;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                NextButton(
                  onPressed: () async {
                    if (controller.purposeController.text == '') {
                      controller.purpopseErrorText.value =
                          "This field is required";
                      return;
                    }
                    Get.to(() => const AddAdditionalMembersView());
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
