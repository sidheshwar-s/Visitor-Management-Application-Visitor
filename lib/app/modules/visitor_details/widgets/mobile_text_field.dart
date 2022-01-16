import 'package:flutter/material.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';

class MobileTextField extends StatelessWidget {
  const MobileTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VisitorDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.mobileController,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 5,
            bottom: 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.phone),
              SizedBox(
                width: 10,
              ),
              Text(
                "+91",
              ),
            ],
          ),
        ),
        hintText: "Mobile number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
