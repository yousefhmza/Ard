class LandRequestModel {
  int? offerTypeId;
  int? cityId;
  int? areaId;
  String? district;
  String? landSpace;
  String? price;
  String? contact;
  String? contactBy;
  String? usage;

  LandRequestModel({
   this.offerTypeId,
   this.cityId,
   this.areaId,
   this.district,
   this.landSpace,
   this.price,
   this.contact,
   this.contactBy,
   this.usage,
  });

  //copyWith
  LandRequestModel copyWith({
    int? offerTypeId,
    int? cityId,
    int? areaId,
    String? district,
    String? landSpace,
    String? price,
    String? contact,
    String? contactBy,
    String? usage,
  }) {
    return LandRequestModel(
      offerTypeId: offerTypeId ?? this.offerTypeId,
      cityId: cityId ?? this.cityId,
      areaId: areaId ?? this.areaId,
      district: district ?? this.district,
      landSpace: landSpace ?? this.landSpace,
      price: price ?? this.price,
      contactBy: contactBy ?? this.contactBy,
      contact: contact ?? this.contact,
      usage: usage ?? this.usage,
    );
  }
}
