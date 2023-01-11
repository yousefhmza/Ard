// To parse this JSON data, do
//
//     final subscriptionResponse = subscriptionResponseFromJson(jsonString);

import 'dart:convert';

SubscriptionResponse subscriptionResponseFromJson(String str) => SubscriptionResponse.fromJson(json.decode(str));


class SubscriptionResponse {
    SubscriptionResponse({
        required this.code,
        required this.message,
        required this.item,
    });

    final int code;
    final String message;
    final SubscriptionInfo item;

    factory SubscriptionResponse.fromJson(Map<String, dynamic> json) => SubscriptionResponse(
        code: json["code"],
        message: json["message"],
        item: SubscriptionInfo.fromJson(json["item"]),
    );

  
}

class SubscriptionInfo {
    SubscriptionInfo({
        required this.bankName,
        required this.accountNumber,
        required this.iban,
        required this.content,
    });

    final String bankName;
    final String accountNumber;
    final String iban;
    final String content;

    factory SubscriptionInfo.fromJson(Map<String, dynamic> json) => SubscriptionInfo(
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        iban: json["IBAN"],
        content: json["content"],
    );

}
