// To parse this JSON data, do
//
//     final landsListResponse = landsListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ared/modules/auth/models/response/user_model.dart';

LandsListResponse? landsListResponseFromJson(String str) => LandsListResponse.fromJson(json.decode(str));

class LandsListResponse {
  LandsListResponse({
    required this.code,
    required this.states,
    required this.message,
    required this.landItem,
  });

  final int? code;
  final bool? states;
  final String? message;
  final List<LandItem> landItem;

  factory LandsListResponse.fromJson(Map<String, dynamic> json) => LandsListResponse(
        code: json["code"],
        states: json["states"],
        message: json["message"],
        landItem: json["item"] == null ? [] : List<LandItem>.from(json["item"].map((x) => LandItem.fromJson(x))),
      );
}

class LandItem {
  LandItem({
    this.id,
    this.city,
    this.area,
    this.district,
    this.offerType,
    this.using,
    this.space,
    this.price,
    this.user,
  });

  final int? id;
  final String? city;
  final String? area;
  final String? district;
  final String? offerType;
  final int? using;
  final String? space;
  final String? price;
  final User? user;

  factory LandItem.fromJson(Map<String, dynamic> json) => LandItem(
        id: json["id"],
        city: json["city"],
        area: json["area"],
        district: json["district"],
        offerType: json["offer_type"],
        using: json["using"],
        space: json["space"],
        price: json["price"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}
