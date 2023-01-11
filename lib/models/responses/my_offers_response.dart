// To parse this JSON data, do
//
//     final myOffersResponse = myOffersResponseFromJson(jsonString);

import 'dart:convert';

MyOffersResponse myOffersResponseFromJson(String str) => MyOffersResponse.fromJson(json.decode(str));

class MyOffersResponse {
  MyOffersResponse({
    required this.code,
    required this.states,
    required this.message,
    required this.item,
  });

  final int code;
  final bool states;
  final String message;
  final List<OfferItem> item;

  factory MyOffersResponse.fromJson(Map<String, dynamic> json) => MyOffersResponse(
        code: json["code"],
        states: json["states"],
        message: json["message"],
        item: List<OfferItem>.from(json["item"].map((x) => OfferItem.fromJson(x))),
      );
}

class OfferItem {
  OfferItem({
    this.id,
    this.title,
    this.createdAt,
    this.userName,
    this.userId,
    this.price,
    this.totalPrice,
    this.space,
    this.relationship,
    this.offerType,
    this.view,
    this.using,
    this.active,
    this.status,
    required this.service,
  });

  final int? id;
  final String? title;
  final DateTime? createdAt;
  final String? userName;
  final int? userId;
  final String? price;
  final String? totalPrice;
  final String? space;
  final String? relationship;
  final String? offerType;
  final String? view;
  final String? using;
  final String? active;
  final String? status;
  final List<Service> service;

  factory OfferItem.fromJson(Map<String, dynamic> json) => OfferItem(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        userName: json["user_name"],
        userId: json["user_id"],
        price: json["price"],
        totalPrice: json["total_price"],
        space: json["space"],
        relationship: json["relationship"],
        offerType: json["offer_type"],
        view: json["view"],
        using: json["using"],
        active: json["active"],
        status: json["status"],
        service: json["service"] == null ? [] : List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
      );
}

class Service {
  Service({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        title: json["title"],
      );
}
