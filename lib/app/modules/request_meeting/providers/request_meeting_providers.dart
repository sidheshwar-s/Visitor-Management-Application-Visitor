import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/employee_list_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/meeting_model.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/request_meeting_model.dart';

class RequestMeetingProviders {
  Future<EmployeesListModel?> getEmployeeList() async {
    const url = '$apiUrl/visitor/getEmployees';
    try {
      Response response = await dioClient.get(url);
      EmployeesListModel employeeModel =
          EmployeesListModel.fromMap(response.data);
      return employeeModel;
    } on DioError catch (e) {
      showSnackBar(title: e.response?.data['message']);
    } catch (e) {
      showSnackBar(title: e.toString());
    }
  }

  Future<MeetingModel?> requestMeeting(
    RequestMeetingModel requestMeetingModel,
    BuildContext context,
  ) async {
    const url = '$apiUrl/meeting/requestForMeeting';
    try {
      Map<String, dynamic> data = requestMeetingModel.toMap();
      Response response = await dioClient.post(url, data: data);

      MeetingModel meetingModel =
          MeetingModel.fromMap(response.data['meeting']);
      return meetingModel;
    } on DioError catch (e) {
      log(e.message);
      final snackBar = SnackBar(
        content: Text('${e.response?.data['message']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      log(e.toString());
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
