import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/next_button.dart';

class OtpView extends GetView<VisitorDetailsController> {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "We have sent you an SMS code",
                  style: Get.textTheme.headline4?.copyWith(color: kDarkBlue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "on number +91 ${controller.mobileController.text.substring(0, 4)}XXXXXX",
                  style: Get.textTheme.headline6?.copyWith(color: kWhite),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kHalfWhite,
                  ),
                  child: PinCodeTextField(
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(15),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: kHalfWhite,
                      selectedFillColor: kHalfWhite,
                      inactiveColor: kDarkBlue,
                    ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    obscureText: true,
                    controller: controller.otpController,
                    appContext: context,
                    length: 4,
                    onChanged: (otp) {
                      controller.otpValue.value = otp;
                    },
                    errorTextSpace: 25,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                NextButton(
                  onPressed: () {
                    controller.validateOtp();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
