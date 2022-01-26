import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:vms_visitor_flutter/app/modules/request_meeting/models/additional_members_model.dart';

class RequestMeetingModel {
  final String? empId;
  final String? purpose;
  final String? vehicleNumber;
  final List<String>? belongings;
  final AdditionalMembersModel? additionalMembers;
  RequestMeetingModel({
    this.empId,
    this.purpose,
    this.vehicleNumber,
    this.belongings,
    this.additionalMembers,
  });

  RequestMeetingModel copyWith({
    String? empId,
    String? purpose,
    String? vehicleNumber,
    List<String>? belongings,
    AdditionalMembersModel? additionalMembers,
  }) {
    return RequestMeetingModel(
      empId: empId ?? this.empId,
      purpose: purpose ?? this.purpose,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      belongings: belongings ?? this.belongings,
      additionalMembers: additionalMembers ?? this.additionalMembers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'empId': empId,
      'purpose': purpose,
      'vehicleNumber': vehicleNumber,
      'belongings': belongings,
      'additionalMembers': additionalMembers?.toMap(),
    };
  }

  factory RequestMeetingModel.fromMap(Map<String, dynamic> map) {
    return RequestMeetingModel(
      empId: map['empId'],
      purpose: map['purpose'],
      vehicleNumber: map['vehicleNumber'],
      belongings: List<String>.from(map['belongings']),
      additionalMembers: map['additionalMembers'] != null
          ? AdditionalMembersModel.fromMap(map['additionalMembers'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestMeetingModel.fromJson(String source) =>
      RequestMeetingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestMeetingModel(empId: $empId, purpose: $purpose, vehicleNumber: $vehicleNumber, belongings: $belongings, additionalMembers: $additionalMembers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestMeetingModel &&
        other.empId == empId &&
        other.purpose == purpose &&
        other.vehicleNumber == vehicleNumber &&
        listEquals(other.belongings, belongings) &&
        other.additionalMembers == additionalMembers;
  }

  @override
  int get hashCode {
    return empId.hashCode ^
        purpose.hashCode ^
        vehicleNumber.hashCode ^
        belongings.hashCode ^
        additionalMembers.hashCode;
  }
}
