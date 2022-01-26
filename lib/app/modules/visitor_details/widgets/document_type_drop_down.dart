import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:vms_visitor_flutter/app/data/constants.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/controllers/visitor_details_controller.dart';

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
