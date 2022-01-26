import 'dart:convert';

class SaveVisitorModel {
  final String name;
  final String phone;
  final String address;
  final String company;
  final String selfieLink;
  final String idType;
  final String idLink;
  final String companyName;
  SaveVisitorModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.company,
    required this.selfieLink,
    required this.idType,
    required this.idLink,
    required this.companyName,
  });

  SaveVisitorModel copyWith({
    String? name,
    String? phone,
    String? address,
    String? company,
    String? selfieLink,
    String? idType,
    String? idLink,
    String? companyName,
  }) {
    return SaveVisitorModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      company: company ?? this.company,
      selfieLink: selfieLink ?? this.selfieLink,
      idType: idType ?? this.idType,
      idLink: idLink ?? this.idLink,
      companyName: companyName ?? this.companyName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'company': company,
      'selfieLink': selfieLink,
      'idType': idType,
      'idLink': idLink,
      'companyName': companyName,
    };
  }

  factory SaveVisitorModel.fromMap(Map<String, dynamic> map) {
    return SaveVisitorModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      company: map['company'] ?? '',
      selfieLink: map['selfieLink'] ?? '',
      idType: map['idType'] ?? '',
      idLink: map['idLink'] ?? '',
      companyName: map['companyName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SaveVisitorModel.fromJson(String source) =>
      SaveVisitorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SaveVisitorModel(name: $name, phone: $phone, address: $address, company: $company, selfieLink: $selfieLink, idType: $idType, idLink: $idLink, companyName: $companyName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveVisitorModel &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.company == company &&
        other.selfieLink == selfieLink &&
        other.idType == idType &&
        other.idLink == idLink &&
        other.companyName == companyName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        company.hashCode ^
        selfieLink.hashCode ^
        idType.hashCode ^
        idLink.hashCode ^
        companyName.hashCode;
  }
}
