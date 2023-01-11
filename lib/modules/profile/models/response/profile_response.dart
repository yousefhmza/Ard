// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

class ProfileResponse {
  ProfileResponse({
    required this.code,
    required this.states,
    required this.user,
    required this.subscription,
    required this.message,
  });

  final int code;
  final bool states;
  final String message;
  final User user;
  final Subscription? subscription;
  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        code: json["code"],
        states: json["states"],
        message: json["message"],
        user: User.fromJson(json["item"]),
        subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
      );
}

class Subscription {
  Subscription({
    required this.id,
    required this.from,
    required this.to,
    required this.image,
  });

  final int id;
  final DateTime from;
  final DateTime to;
  final String image;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
        "image": image,
      };
}
