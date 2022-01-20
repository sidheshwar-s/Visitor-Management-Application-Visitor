import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/models/visitor_info_model.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/providers/visitor_details_provider.dart';
import 'package:vms_visitor_flutter/app/routes/app_pages.dart';

class VisitorDetailsController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  VisitorInfoModel? visitorInfoModel;
  RxBool isLoading = RxBool(false);
  RxString otpValue = RxString('');

  getVisitorsData() async {
    isLoading.value = true;
    visitorInfoModel =
        await VisitorDetailsProvider().getVisitorDetails(mobileController.text);
    handleRoutes();
    isLoading.value = false;
  }

  void handleRoutes() {
    if (visitorInfoModel?.token == null) {
      Get.toNamed(Routes.OTP);
    }
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
          }
        },
      ),
    );
  }

  void validateOtp() {
    isLoading.value = true;
    if (visitorInfoModel?.otp != null &&
        visitorInfoModel?.otp == otpValue.value) {
      // next page
    } else {
      showSnackBar(
        title: "Invalid Otp",
        backgroundColor: kRed.withOpacity(0.7),
        foregroundColor: kWhite,
      );
    }
    isLoading.value = false;
  }
}
