import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';

class NextButton extends GetView<VisitorDetailsController> {
  const NextButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          primary: kDarkBlue,
        ),
        onPressed: onPressed,
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "Next",
                style: Get.textTheme.headline6?.copyWith(color: kWhite),
              ),
              const SizedBox(
                width: 10,
              ),
              if (!controller.isLoading.value)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kWhite,
                ),
              if (controller.isLoading.value)
                const SizedBox(
                  width: 5,
                ),
              if (controller.isLoading.value)
                const Center(
                  child: SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: kWhite,
                      strokeWidth: 2,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
