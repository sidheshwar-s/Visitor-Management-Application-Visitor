import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/mobile_text_field.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/widgets/next_button.dart';
import '../controllers/visitor_details_controller.dart';

class VisitorDetailsView extends GetView<VisitorDetailsController> {
  const VisitorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: Get.textTheme.headline4?.copyWith(
                  height: 1.5,
                  color: kDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please enter your mobile number to continue",
                style: Get.textTheme.headline6?.copyWith(
                  color: kDarkBlue,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MobileTextField(controller: controller),
              const SizedBox(
                height: 50,
              ),
              const NextButton()
            ],
          ),
        ),
      ),
    );
  }
}
