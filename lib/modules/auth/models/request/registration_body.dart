class RegistrationBody {
  String mobile;
  String name;
  String email;
  String idType;
  String idNumber;
  String licenseNumber;

  RegistrationBody({
    this.mobile = "",
    this.name = "",
    this.email = "",
    this.idType = "",
    this.idNumber = "",
    this.licenseNumber = "",
  });

  void copyWith({
    String? mobile,
    String? name,
    String? email,
    String? idType,
    String? idNumber,
    String? licenseNumber,
  }) {
    this.mobile = mobile ?? this.mobile;
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.idType = idType ?? this.idType;
    this.idNumber = idNumber ?? this.idNumber;
    this.licenseNumber = licenseNumber ?? this.licenseNumber;
  }

  void resetValues() {
    mobile = '';
    name = '';
    email = '';
    idType = '';
    idNumber = '';
    licenseNumber = '';
  }

  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
      "name": name,
      "email": email,
      "id_type": idType,
      "id_number": idNumber,
      "license_number": licenseNumber,
    };
  }
}
