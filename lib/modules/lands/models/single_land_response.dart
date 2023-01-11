// To parse this JSON data, do
//
//     final singleLandResponse = singleLandResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ared/modules/lands/models/lands_list_response.dart';

SingleLandResponse? singleLandResponseFromJson(String str) => SingleLandResponse.fromJson(json.decode(str));

class SingleLandResponse {
  SingleLandResponse({
    this.code,
    this.states,
    required this.message,
    required this.item,
  });

  final int? code;
  final bool? states;
  final String message;
  final List<LandItem> item;

  factory SingleLandResponse.fromJson(Map<String, dynamic> json) => SingleLandResponse(
        code: json["code"],
        states: json["states"],
        message: json["message"] ?? "",
        item: json["item"] == null ? [] : List<LandItem>.from(json["item"].map((x) => LandItem.fromJson(x))),
      );
}
