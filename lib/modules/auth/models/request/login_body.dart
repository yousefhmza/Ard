class LoginBody {
  String phoneNumber;
  String otp;

  LoginBody({this.phoneNumber = "", this.otp = ""});

  void copyWith({String? phoneNumber, String? otp}) {
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.otp = otp ?? this.otp;
  }

  void resetValues() {
    phoneNumber = "";
    otp = "";
  }

  Map<String, dynamic> toJson() {
    return {
      if (phoneNumber.isNotEmpty) "mobile": phoneNumber,
      if (otp.isNotEmpty) "otp": otp,
    };
  }
}
