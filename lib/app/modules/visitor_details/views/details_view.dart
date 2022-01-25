import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/views/document_upload_view.dart';

class DetailsView extends GetView<VisitorDetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your details",
                style: Get.textTheme.headline5
                    ?.copyWith(color: kDarkBlue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextFields(
                controller: controller.nameController,
                icon: const Icon(Icons.person),
              ),
              CustomTextFields(
                controller: controller.companyNameController,
                icon: const Icon(Icons.apartment),
              ),
              CustomTextFields(
                controller: controller.addressController,
                icon: const Icon(Icons.location_on_rounded),
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.scannerDocumentUrl == null)
                Center(
                  child: Text(
                    "Select Document type",
                    style: Get.textTheme.headline6?.copyWith(color: kDarkBlue),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              if (controller.scannerDocumentUrl == null)
                DocumentTypeDropDown(controller: controller),
              const SizedBox(
                height: 20,
              ),
              if (controller.scannerDocumentUrl == null)
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.upload,
                      color: kBlack,
                    ),
                    onPressed: () {
                      controller.scannedDocument.value = null;
                      Get.to(() => const DocumentUploadView());
                    },
                    label: const Text(
                      "Upload Document",
                      style:
                          TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.photo,
                    color: kBlack,
                  ),
                  onPressed: () {
                    controller.scannedDocument.value = null;
                    Get.to(() => const DocumentUploadView());
                  },
                  label: const Text(
                    "Capture Selfie",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
  }) : super(key: key);

  final TextEditingController controller;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: kWhite),
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: "Enter your name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
