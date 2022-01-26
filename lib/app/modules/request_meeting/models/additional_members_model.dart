import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/additional_user_model.dart';

class AdditionalMembersModel {
  final List<AdditionalUserModel>? additionalMembers;
  AdditionalMembersModel({
    this.additionalMembers,
  });

  AdditionalMembersModel copyWith({
    List<AdditionalUserModel>? additionalMembers,
  }) {
    return AdditionalMembersModel(
      additionalMembers: additionalMembers ?? this.additionalMembers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'additionalMembers': additionalMembers?.map((x) => x.toMap()).toList(),
    };
  }

  factory AdditionalMembersModel.fromMap(Map<String, dynamic> map) {
    return AdditionalMembersModel(
      additionalMembers: map['additionalMembers'] != null
          ? List<AdditionalUserModel>.from(map['additionalMembers']
              ?.map((x) => AdditionalUserModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdditionalMembersModel.fromJson(String source) =>
      AdditionalMembersModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AdditionalMembersModel(additionalMembers: $additionalMembers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdditionalMembersModel &&
        listEquals(other.additionalMembers, additionalMembers);
  }

  @override
  int get hashCode => additionalMembers.hashCode;
}
