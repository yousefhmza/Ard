// To parse this JSON data, do
//
//     final realestateAppraisalResponse = realestateAppraisalResponseFromJson(jsonString);

import 'dart:convert';

RealestateAppraisalResponse realestateAppraisalResponseFromJson(String str) => RealestateAppraisalResponse.fromJson(json.decode(str));


class RealestateAppraisalResponse {
    RealestateAppraisalResponse({
        this.code,
        this.message,
        this.item,
    });

    int? code;
    String? message;
    Item? item;

    factory RealestateAppraisalResponse.fromJson(Map<String, dynamic> json) => RealestateAppraisalResponse(
        code: json["code"] ?? null,
        message: json["message"] ?? null,
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
    );

  
}

class Item {
    Item({
        this.userId,
        this.offerId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    int? userId;
    String? offerId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        userId: json["user_id"] ?? null,
        offerId: json["offer_id"] ?? null,
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] ?? null,
    );

   
}
