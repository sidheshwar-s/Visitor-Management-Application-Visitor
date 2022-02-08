import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/controllers/request_meeting_controller.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/employee_model.dart';

class EmployeeListView extends GetView<RequestMeetingController> {
  const EmployeeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pick the employee'),
          centerTitle: true,
        ),
        body: Obx(() {
          return controller.employeesListModel.value?.employees != null
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: ListView.builder(
                    itemCount:
                        controller.employeesListModel.value?.employees?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentEmp = controller
                          .employeesListModel.value!.employees![index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => currentEmp.status == null ||
                                currentEmp.status != 'disabled'
                            ? showConfirmDialog(currentEmp, context)
                            : null,
                        child: DefaultTextStyle(
                          style: const TextStyle(color: kWhite),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: kDarkBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(currentEmp.image!),
                                      radius: 30,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentEmp.name ?? 'No name',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          currentEmp.designation ??
                                              'No designation  provided',
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: kWhite,
                                    ),
                                  ],
                                ),
                              ),
                              if (currentEmp.status != null &&
                                  currentEmp.status == 'disabled')
                                Positioned.fill(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: kGrey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text("Sorry no employee is available right now"),
                );
        }));
  }

  showConfirmDialog(EmployeeModel currentEmp, BuildContext context) {
    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(currentEmp.image!),
            radius: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            currentEmp.name ?? "No Name",
            style: Get.textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Are you sure you want to request a meeting?",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kRed),
                onPressed: () => Get.back(),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: kWhite),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kLightBlue),
                onPressed: () =>
                    controller.requestMeeting(currentEmp.id!, context),
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "CONFIRM",
                        style: TextStyle(color: kWhite),
                      ),
                      if (controller.isLoading.value)
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
