// To parse this JSON data, do
//
//     final offerAttributesResponse = offerAttributesResponseFromJson(jsonString);

import 'dart:convert';

OfferAttributesResponse offerAttributesResponseFromJson(String str) => OfferAttributesResponse.fromJson(json.decode(str));

class OfferAttributesResponse {
  OfferAttributesResponse({
    this.code,
    this.message,
    this.item,
  });

  int? code;
  String? message;
  OfferAttributes? item;

  factory OfferAttributesResponse.fromJson(Map<String, dynamic> json) => OfferAttributesResponse(
        code: json["code"],
        message: json["message"],
        item: OfferAttributes.fromJson(json["item"]),
      );
}

class OfferAttributes {
  OfferAttributes({
    this.service,
    this.type,
    this.advertiserAttributeItem,
  });

  List<AttributeItem>? service;
  List<AttributeItem>? type;
  List<AttributeItem>? advertiserAttributeItem;

  factory OfferAttributes.fromJson(Map<String, dynamic> json) => OfferAttributes(
        service: List<AttributeItem>.from(json["Service"].map((x) => AttributeItem.fromJson(x))),
        type: List<AttributeItem>.from(json["Type"].map((x) => AttributeItem.fromJson(x))),
        advertiserAttributeItem: List<AttributeItem>.from(json["AdvertiserType"].map((x) => AttributeItem.fromJson(x))),
      );
}

class AttributeItem {
  AttributeItem({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory AttributeItem.fromJson(Map<String, dynamic> json) => AttributeItem(
        id: json["id"],
        title: json["title"],
      );
}
