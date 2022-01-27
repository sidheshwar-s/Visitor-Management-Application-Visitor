import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:vms_visitor_flutter/app/modules/request_meeting/models/employee_model.dart';

class EmployeesListModel {
  final List<EmployeeModel>? employees;
  EmployeesListModel({
    this.employees,
  });

  EmployeesListModel copyWith({
    List<EmployeeModel>? employees,
  }) {
    return EmployeesListModel(
      employees: employees ?? this.employees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employees': employees?.map((x) => x.toMap()).toList(),
    };
  }

  factory EmployeesListModel.fromMap(Map<String, dynamic> map) {
    return EmployeesListModel(
      employees: map['employees'] != null
          ? List<EmployeeModel>.from(
              map['employees']?.map((x) => EmployeeModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeesListModel.fromJson(String source) =>
      EmployeesListModel.fromMap(json.decode(source));

  @override
  String toString() => 'EmployeesListModel(employees: $employees)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeesListModel &&
        listEquals(other.employees, employees);
  }

  @override
  int get hashCode => employees.hashCode;
}
