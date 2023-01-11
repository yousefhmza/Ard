import 'dart:io';

class User {
  int id;
  String image;
  String name;
  String email;
  String idType;
  String idNumber;
  String licenseNumber;
  String mobileNumber;
  //Data required for updating profile
  String moreInfo = '';
  String nationalityId = '';
  File? imageAsFile;
  User({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.idType,
    required this.idNumber,
    required this.licenseNumber,
    required this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        image: json["image"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        idType: json["id_type"] ?? "",
        idNumber: json["id_number"] ?? "",
        licenseNumber: json["license_number"] ?? "",
        mobileNumber: json["mobile"] ?? "",
      );
}
