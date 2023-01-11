// To parse this JSON data, do
//
//     final basicResponse = basicResponseFromJson(jsonString);

import 'dart:convert';

BasicResponse basicResponseFromJson(String str) => BasicResponse.fromJson(json.decode(str));

class BasicResponse {
  BasicResponse({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;

  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse(
        success: json["success"] ?? json["states"] ?? false,
        message: json["message"] ?? "NA",
      );
}
