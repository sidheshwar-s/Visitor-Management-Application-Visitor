import 'package:flutter/material.dart';
import 'package:document_scanner/document_scanner.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';

class DocumentUploadView extends StatefulWidget {
  const DocumentUploadView({Key? key}) : super(key: key);

  @override
  State<DocumentUploadView> createState() => _DocumentUploadViewState();
}

class _DocumentUploadViewState extends State<DocumentUploadView> {
  VisitorDetailsController controller = Get.find<VisitorDetailsController>();
  Future<PermissionStatus>? cameraPermissionFuture;

  @override
  void initState() {
    cameraPermissionFuture = Permission.camera.request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<PermissionStatus>(
          future: cameraPermissionFuture,
          builder:
              (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.isGranted) {
                return Stack(
                  children: <Widget>[
                    Obx(
                      () => Column(
                        children: <Widget>[
                          Expanded(
                            child: controller.scannedDocument.value != null
                                ? Image(
                                    image: FileImage(
                                        controller.scannedDocument.value!),
                                  )
                                : DocumentScanner(
                                    noGrayScale: true,
                                    onDocumentScanned:
                                        (ScannedImage scannedImage) {
                                      controller.scannedDocument.value =
                                          scannedImage
                                              .getScannedDocumentAsFile();
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return controller.scannedDocument.value != null
                          ? Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: ElevatedButton(
                                child: const Text("CONFIRM"),
                                onPressed: () {
                                  controller.uploadFiles();
                                  Get.back();
                                },
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                    Obx(() {
                      return controller.scannedDocument.value != null
                          ? Positioned(
                              bottom: 80,
                              left: 0,
                              right: 0,
                              child: ElevatedButton(
                                child: const Text("RETRY"),
                                onPressed: () {
                                  controller.scannedDocument.value = null;
                                },
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                  ],
                );
              } else {
                return const Center(
                  child: Text("camera permission denied"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
