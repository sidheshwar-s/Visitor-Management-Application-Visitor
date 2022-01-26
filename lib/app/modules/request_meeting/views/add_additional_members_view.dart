import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/controllers/request_meeting_controller.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/additional_user_model.dart';

class AddAdditionalMembersView extends GetView<RequestMeetingController> {
  const AddAdditionalMembersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Members'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 10),
        child: FloatingActionButton.extended(
          onPressed: () {
            handleAdditionalMembersInput();
          },
          label: const Text("ADD"),
          icon: const Icon(Icons.add),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.additionalMembers.length,
              itemBuilder: (BuildContext context, int index) {
                final currentMember = controller.additionalMembers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: kWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: kBlue,
                        ),
                        padding: const EdgeInsets.only(left: 15, right: 16),
                        height: 50,
                        child: Row(
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Text(
                              "Member Details",
                              style: Get.textTheme.headline6?.copyWith(
                                color: kWhite,
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  controller.additionalMembers.removeAt(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: kRed,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              currentMember.name,
                              style: Get.textTheme.headline6
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              currentMember.phone,
                              style: Get.textTheme.headline6
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void handleAdditionalMembersInput() {
    Get.defaultDialog(
      backgroundColor: kDarkBlue,
      title: "Add details",
      titleStyle: const TextStyle(color: kWhite),
      titlePadding: const EdgeInsets.only(top: 20),
      content: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: kWhite),
              controller: controller.nameController,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhite),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhite),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhite),
                ),
                hintText: "Enter name",
                hintStyle: TextStyle(color: kWhite.withOpacity(0.5)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: const TextStyle(color: kWhite),
              controller: controller.phoneController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  counterText: '',
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: kWhite),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: kWhite),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: kWhite),
                  ),
                  hintStyle: TextStyle(
                    color: kWhite.withOpacity(0.5),
                  ),
                  hintText: "Enter phone number"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: kLightBlue),
              onPressed: () {
                AdditionalUserModel newMember = AdditionalUserModel(
                  name: controller.nameController.text,
                  phone: controller.phoneController.text,
                );
                controller.additionalMembers.add(newMember);
                controller.nameController.clear();
                controller.phoneController.clear();
                Get.back();
              },
              child: const Text(
                "Confirm",
                style: TextStyle(color: kWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
