import 'dart:convert';

class AdditionalUserModel {
  final String name;
  final String phone;
  AdditionalUserModel({
    required this.name,
    required this.phone,
  });

  AdditionalUserModel copyWith({
    String? name,
    String? phone,
  }) {
    return AdditionalUserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory AdditionalUserModel.fromMap(Map<String, dynamic> map) {
    return AdditionalUserModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AdditionalUserModel.fromJson(String source) =>
      AdditionalUserModel.fromMap(json.decode(source));

  @override
  String toString() => 'AdditionalUserModel(name: $name, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdditionalUserModel &&
        other.name == name &&
        other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
