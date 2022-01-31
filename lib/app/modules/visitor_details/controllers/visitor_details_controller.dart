import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/models/save_visitor_model.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/models/visitor_info_model.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/providers/visitor_details_providers.dart';
import 'package:vms_visitor_flutter/app/routes/app_pages.dart';

class VisitorDetailsController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final documentTypes = <String>[
    'Aadhar',
    'Pan Card',
    'Driving License',
    'ID card'
  ];
  RxString selectedDocumentType = RxString('Aadhar');
  VisitorInfoModel? visitorInfoModel;
  RxBool isLoading = RxBool(false);
  RxString otpValue = RxString('');
  Rx<File?> scannedDocument = Rx<File?>(null);
  RxnString scannerDocumentUrl = RxnString(null);
  Rx<File?> selfieFile = Rx<File?>(null);
  RxnString selfieUrl = RxnString(null);

  getVisitorsData() async {
    isLoading.value = true;
    visitorInfoModel =
        await VisitorDetailsProvider().getVisitorDetails(mobileController.text);
    handleRoutes();
    isLoading.value = false;
  }

  void handleRoutes() async {
    if (visitorInfoModel?.token == null) {
      Get.toNamed(Routes.OTP);
    } else {
      await storeToken();
      Get.toNamed(Routes.REQUEST_MEETING);
    }
  }

  Future<void> storeToken() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'authToken', value: visitorInfoModel!.token);
    addInterceptors();
  }

  void addInterceptors() async {
    const storage = FlutterSecureStorage();
    dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          var token = await storage.read(key: "authToken");
          log(token ?? '', name: "token");
          if (token != null && token != '') {
            request.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(request);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            Get.offNamedUntil(Routes.HOME, ModalRoute.withName(Routes.AUTH));
            return;
          }
          return handler.next(e);
        },
      ),
    );
  }

  void validateOtp() {
    isLoading.value = true;
    if (visitorInfoModel?.otp != null &&
        visitorInfoModel?.otp == otpValue.value) {
      Get.toNamed(Routes.VISITOR_DETIALS_FORM);
    } else {
      showSnackBar(
        title: "Invalid Otp",
        backgroundColor: kRed.withOpacity(0.7),
        foregroundColor: kWhite,
      );
    }
    isLoading.value = false;
  }

  void uploadFiles() async {
    if (scannedDocument.value == null) {
      return;
    }
    try {
      await FirebaseStorage.instance
          .ref('document-proofs/${DateTime.now().toIso8601String()}')
          .putFile(scannedDocument.value!)
          .then(
        (image) async {
          scannerDocumentUrl.value = await image.ref.getDownloadURL();
        },
      );
    } on FirebaseException catch (e) {
      showSnackBar(title: e.message);
    }
  }

  void uploadSelfie() async {
    if (selfieFile.value == null) {
      return;
    }
    try {
      await FirebaseStorage.instance
          .ref('selfie-images/${DateTime.now().toIso8601String()}')
          .putFile(selfieFile.value!)
          .then((image) async {
        selfieUrl.value = await image.ref.getDownloadURL();
      });
    } on FirebaseException catch (e) {
      showSnackBar(title: e.message);
    }
  }

  Future<Map<String, dynamic>> getVisitorJson() async {
    const storage = FlutterSecureStorage();
    String? company = await storage.read(key: "companyId");
    SaveVisitorModel visitorModel = SaveVisitorModel(
      name: nameController.text,
      phone: mobileController.text,
      address: addressController.text,
      company: company ?? 'none',
      selfieLink: selfieUrl.value ?? 'none',
      idType: selectedDocumentType.value,
      idLink: scannerDocumentUrl.value ?? 'none',
      companyName: companyNameController.text,
    );
    return visitorModel.toMap();
  }
}
