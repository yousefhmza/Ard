import 'package:ared/modules/offers/models/offer_attributes_response.dart';
import 'package:dio/dio.dart';

class AddOfferBody {
  String title;
  String price;
  String streetWidth;
  String streetHeight;
  String space;
  String totalPrice;
  String relationship;
  String offerDetails;
  AttributeItem? offerType;
  String view;
  AttributeItem? usage;
  bool termsAgreed;
  List<AttributeItem> services;

  AddOfferBody({
    this.title = "",
    this.price = "",
    this.streetWidth = "0.0",
    this.streetHeight = "0.0",
    this.space = "",
    this.totalPrice = "",
    this.relationship = "",
    this.offerDetails = "",
    this.offerType,
    this.view = "",
    this.usage,
    this.termsAgreed = false,
    required this.services,
  });

  void copyWith({
    String? title,
    String? price,
    String? streetWidth,
    String? streetHeight,
    String? space,
    String? totalPrice,
    String? relationship,
    String? offerDetails,
    AttributeItem? offerType,
    String? view,
    AttributeItem? usage,
    bool? termsAgreed,
    List<AttributeItem>? services,
  }) {
    this.title = title ?? this.title;
    this.price = price ?? this.price;
    this.streetWidth = streetWidth ?? this.streetWidth;
    this.streetHeight = streetHeight ?? this.streetHeight;
    this.space = space ?? this.space;
    this.totalPrice = totalPrice ?? this.totalPrice;
    this.relationship = relationship ?? this.relationship;
    this.offerDetails = offerDetails ?? this.offerDetails;
    this.offerType = offerType ?? this.offerType;
    this.view = view ?? this.view;
    this.usage = usage ?? this.usage;
    this.termsAgreed = termsAgreed ?? this.termsAgreed;
    this.services = services ?? this.services;
  }

  void resetValues() {
    title = "";
    price = "";
    streetWidth = "0.0";
    streetHeight = "0.0";
    space = "";
    totalPrice = "";
    relationship = "";
    offerDetails = "";
    offerType;
    usage;
    view = "";
    termsAgreed = false;
    services = [];
  }

  FormData toFormData() {
    final FormData formData = FormData.fromMap({
      "title": title,
      "price": price,
      "street_width": streetWidth,
      "street_height": streetHeight,
      "space": space,
      "total_price": totalPrice,
      "relationship": relationship,
      "offer_details": offerDetails,
      "offer_type": offerType?.id.toString() ?? "",
      "view": view,
      "using": usage?.id.toString() ?? "",
      "service": services.map((e) => e.id.toString()).toList().join(","),
    });
    return formData;
  }
}
