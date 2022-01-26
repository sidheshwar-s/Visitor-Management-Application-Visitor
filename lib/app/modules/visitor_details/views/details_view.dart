import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/providers/visitor_details_providers.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/custom_text_field.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/document_type_drop_down.dart';
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
                            onPressed: onPressedForUploadDocument(),
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
                            onPressed: onPressedForSelfieUpload(),
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
                  if (isAllDetailsAvailable())
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

  onPressedForUploadDocument() async {
    XFile? picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (picture == null) {
      showSnackBar(
        title: "Kindly upload your any proof",
        message: "It is cumpulsory to proceed forward",
      );
      return;
    }
    controller.scannedDocument.value = File(picture.path);
    controller.uploadFiles();
  }

  onPressedForSelfieUpload() async {
    XFile? picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (picture == null) {
      showSnackBar(
        title: "Kindly take your selfie",
        message: "It is cumpulsory to proceed forward",
      );
      return;
    }
    controller.selfieFile.value = File(picture.path);
    controller.uploadSelfie();
  }

  bool isAllDetailsAvailable() {
    return controller.scannerDocumentUrl.value != null &&
        controller.selfieUrl.value != null &&
        !controller.nameController.isBlank! &&
        !controller.addressController.isBlank! &&
        !controller.companyNameController.isBlank!;
  }
}
