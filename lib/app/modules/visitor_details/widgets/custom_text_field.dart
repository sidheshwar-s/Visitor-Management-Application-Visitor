import 'package:flutter/material.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';

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
