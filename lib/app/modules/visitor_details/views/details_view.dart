import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/providers/visitor_details_providers.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/next_button.dart';

class DetailsView extends GetView<VisitorDetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your details",
                    style: Get.textTheme.headline5?.copyWith(
                        color: kDarkBlue, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextFields(
                    controller: controller.nameController,
                    icon: const Icon(Icons.person),
                    hintText: "Enter your name",
                  ),
                  CustomTextFields(
                    controller: controller.companyNameController,
                    icon: const Icon(Icons.apartment),
                    hintText: "Enter your compnay name",
                  ),
                  CustomTextFields(
                    controller: controller.addressController,
                    icon: const Icon(Icons.location_on_rounded),
                    hintText: "Enter your address",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.scannerDocumentUrl.value == null)
                    Center(
                      child: Text(
                        "Select Document type",
                        style:
                            Get.textTheme.headline6?.copyWith(color: kDarkBlue),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.scannerDocumentUrl.value == null)
                    DocumentTypeDropDown(controller: controller),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.scannerDocumentUrl.value == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.upload,
                              color: kBlack,
                            ),
                            onPressed: () async {
                              XFile? picture = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                              );
                              if (picture == null) {
                                showSnackBar(
                                  title: "Kindly upload your any proof",
                                  message:
                                      "It is cumpulsory to proceed forward",
                                );
                                return;
                              }
                              controller.scannedDocument.value =
                                  File(picture.path);
                              controller.uploadFiles();
                            },
                            label: const Text(
                              "Upload Document",
                              style: TextStyle(
                                  color: kBlack, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (controller.scannedDocument.value != null &&
                            controller.scannerDocumentUrl.value == null)
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          )
                      ],
                    ),
                  if (controller.scannerDocumentUrl.value == null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (controller.selfieUrl.value == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.photo,
                              color: kBlack,
                            ),
                            onPressed: () async {
                              XFile? picture = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                              );
                              if (picture == null) {
                                showSnackBar(
                                  title: "Kindly take your selfie",
                                  message:
                                      "It is cumpulsory to proceed forward",
                                );
                                return;
                              }
                              controller.selfieFile.value = File(picture.path);
                              controller.uploadSelfie();
                            },
                            label: const Text(
                              "Capture Selfie",
                              style: TextStyle(
                                  color: kBlack, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (controller.selfieFile.value != null &&
                            controller.selfieUrl.value == null)
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          )
                      ],
                    ),
                  if (controller.scannerDocumentUrl.value != null &&
                      controller.selfieUrl.value != null &&
                      !controller.nameController.isBlank! &&
                      !controller.addressController.isBlank! &&
                      !controller.companyNameController.isBlank!)
                    NextButton(
                      onPressed: () async {
                        controller.isLoading.value = true;
                        Map<String, dynamic> data =
                            await controller.getVisitorJson();
                        await VisitorDetailsProvider().sendVisitorData(data);
                        controller.isLoading.value = false;
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentTypeDropDown extends StatelessWidget {
  const DocumentTypeDropDown({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VisitorDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: kGrey, width: 2),
        ),
        child: Obx(
          () => DropdownButton<String>(
            value: controller.selectedDocumentType.value,
            items: controller.documentTypes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (selected) {
              if (selected != null) {
                controller.selectedDocumentType.value = selected;
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final Icon icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: kWhite),
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
