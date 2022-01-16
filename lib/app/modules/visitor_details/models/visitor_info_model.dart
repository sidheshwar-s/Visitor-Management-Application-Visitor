import 'dart:convert';

import 'package:vms_visitor_flutter/app/modules/visitor_details/models/visitor_model.dart';

class VisitorInfoModel {
  final String? token;
  final String? otp;
  final VisitorModel? visitor;
  VisitorInfoModel({
    this.token,
    this.otp,
    this.visitor,
  });

  VisitorInfoModel copyWith({
    String? token,
    String? otp,
    VisitorModel? visitor,
  }) {
    return VisitorInfoModel(
      token: token ?? this.token,
      otp: otp ?? this.otp,
      visitor: visitor ?? this.visitor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'otp': otp,
      'visitor': visitor?.toMap(),
    };
  }

  factory VisitorInfoModel.fromMap(Map<String, dynamic> map) {
    return VisitorInfoModel(
      token: map['token'],
      otp: map['otp'],
      visitor:
          map['visitor'] != null ? VisitorModel.fromMap(map['visitor']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitorInfoModel.fromJson(String source) =>
      VisitorInfoModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VisitorInfoModel(token: $token, otp: $otp, visitor: $visitor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VisitorInfoModel &&
        other.token == token &&
        other.otp == otp &&
        other.visitor == visitor;
  }

  @override
  int get hashCode => token.hashCode ^ otp.hashCode ^ visitor.hashCode;
}
