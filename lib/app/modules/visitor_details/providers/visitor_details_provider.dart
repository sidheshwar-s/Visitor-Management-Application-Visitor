import 'package:dio/dio.dart';
import 'package:vms_visitor_flutter/app/data/common.dart';
import 'package:vms_visitor_flutter/app/modules/visitor_details/models/visitor_info_model.dart';

class VisitorDetailsProvider {
  Future<VisitorInfoModel?> getVisitorDetails(String phoneNumber) async {
    final url = "$apiUrl/visitor/searchVisitor?phone=$phoneNumber";
    try {
      Response response = await dioClient.get(url);
      VisitorInfoModel visitorInfoModel =
          VisitorInfoModel.fromMap(response.data);
      return visitorInfoModel;
    } on DioError catch (e) {
      showSnackBar(title: e.message);
    } catch (e) {
      showSnackBar(title: e.toString());
    }
  }
}
