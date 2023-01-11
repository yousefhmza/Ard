// To parse this JSON data, do
//
//     final commentsResponse = commentsResponseFromJson(jsonString);

import 'dart:convert';

CommentsResponse commentsResponseFromJson(String str) => CommentsResponse.fromJson(json.decode(str));

class CommentsResponse {
  CommentsResponse({
    required this.code,
    required this.message,
    required this.comments,
  });

  int code;
  String message;
  List<SingleComment> comments;

  factory CommentsResponse.fromJson(Map<String, dynamic> json) => CommentsResponse(
        code: json["code"],
        message: json["message"],
        comments: json["item"] == null ? [] : List<SingleComment>.from(json["item"].map((x) => SingleComment.fromJson(x))),
      );
}

class SingleComment {
  SingleComment({
    this.id,
    this.userName,
    this.userId,
    this.createdAt,
    this.offer,
    this.offerId,
    this.comment,
    this.rate,
  });

  int? id;
  int? userId;
  int? offerId;
  double? rate;
  String? userName;
  String? offer;
  String? comment;
  DateTime? createdAt;

  factory SingleComment.fromJson(Map<String, dynamic> json) => SingleComment(
        id: json["id"],
        userId: json["user_id"],
        offerId: json["offer_id"],
        rate: json["rate"] == null ? 0 : json["rate"].toDouble(),
        userName: json["user_name"],
        offer: json["offer"],
        comment: json["comment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );
}
