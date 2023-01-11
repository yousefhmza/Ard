// To parse this JSON data, do
//
//     final areaFeatureInfoResponse = areaFeatureInfoResponseFromJson(jsonString);

import 'dart:convert';

AreaFeatureInfoResponse areaFeatureInfoResponseFromJson(String str) => AreaFeatureInfoResponse.fromJson(json.decode(str));

class AreaFeatureInfoResponse {
  AreaFeatureInfoResponse({
    this.featureInfoResponse,
  });

  FeatureInfoResponse? featureInfoResponse;

  factory AreaFeatureInfoResponse.fromJson(Map<String, dynamic> json) => AreaFeatureInfoResponse(
        featureInfoResponse: json["FeatureInfoResponse"] == null ? null : FeatureInfoResponse.fromJson(json["FeatureInfoResponse"]),
      );
}

class FeatureInfoResponse {
  FeatureInfoResponse({
    this.OBJECTID,
    this.Shape,
    this.Subtype,
    this.detailsLandUse,
    this.mainLandUse,
    this.description,
    this.created_date,
    this.last_edited_date,
    this.region_Id,
    this.sector_Id,
    this.amana_Id,
    this.governorate_Id,
    this.municipality_Id,
    this.city_Id,
    this.district_Id,
    this.subDistrictName_Id,
    this.subDivisionPlan_Id,
    this.block_Id,
    this.parcel_Id,
    this.parcelIDOld,
    this.parcelCode,
    this.parcelStatus,
    this.measuredArea,
    this.subParcelCount,
    this.drawingNumber,
    this.dateOfDrawing,
    this.drawingStatus,
    this.drawingVersion,
    this.subDivisionPlanPartNumber,
    this.street_Id,
    this.deedNumber,
    this.subDivisionPlanName_ar,
    this.subDivisionPlanName_en,
    this.ownershipType,
    this.approvalNumber,
    this.subDivisionParcelNumber,
    this.asbuiltRemarks,
    this.isRegistered,
    this.isLicensed,
    this.transaction_Id,
    this.layer,
    this.dateOfApproval,
    this.approvedBy,
    this.dateOfApprovalHijri,
    this.isRegulated,
    this.isBuilt,
    this.dateOfRegistered,
    this.dateOfLicense,
    this.dateOfRegisteredHijri,
    this.dateOfLicenseHijri,
    this.LicenseNumber,
    this.noOfFloors,
    this.constructionPercentage,
    this.rearDefection,
    this.sideDefection,
    this.frontDefection,
    this.mainLandUseDescription,
    this.subtypeDescription,
    this.detailsLandUseDescription,
    this.SubDivisionParcel_Unified_Id,
    this.isCommercial,
    this.buildingCondition,
    this.subMunicipality_Id,
    this.SHAPE_Length,
    this.SHAPE_Area,
    this.AREASQM,
  });

  String? OBJECTID;
  String? Shape;
  String? Subtype;
  String? detailsLandUse;
  String? mainLandUse;
  String? description;
  String? created_date;
  String? last_edited_date;
  String? region_Id;
  String? sector_Id;
  String? amana_Id;
  String? governorate_Id;
  String? municipality_Id;
  String? city_Id;
  String? district_Id;
  String? subDistrictName_Id;
  String? subDivisionPlan_Id;
  String? block_Id;
  String? parcel_Id;
  String? parcelIDOld;
  String? parcelCode;
  String? parcelStatus;
  String? measuredArea;
  String? subParcelCount;
  String? drawingNumber;
  String? dateOfDrawing;
  String? drawingStatus;
  String? drawingVersion;
  String? subDivisionPlanPartNumber;
  String? street_Id;
  String? deedNumber;
  String? subDivisionPlanName_ar;
  String? subDivisionPlanName_en;
  String? ownershipType;
  String? approvalNumber;
  String? subDivisionParcelNumber;
  String? asbuiltRemarks;
  String? isRegistered;
  String? isLicensed;
  String? transaction_Id;
  String? layer;
  String? dateOfApproval;
  String? approvedBy;
  String? dateOfApprovalHijri;
  String? isRegulated;
  String? isBuilt;
  String? dateOfRegistered;
  String? dateOfLicense;
  String? dateOfRegisteredHijri;
  String? dateOfLicenseHijri;
  String? LicenseNumber;
  String? noOfFloors;
  String? constructionPercentage;
  String? rearDefection;
  String? sideDefection;
  String? frontDefection;
  String? mainLandUseDescription;
  String? subtypeDescription;
  String? detailsLandUseDescription;
  String? SubDivisionParcel_Unified_Id;
  String? isCommercial;
  String? buildingCondition;
  String? subMunicipality_Id;
  String? SHAPE_Length;
  String? SHAPE_Area;
  String? AREASQM;

  factory FeatureInfoResponse.fromJson(Map<String, dynamic> json) => FeatureInfoResponse(
        OBJECTID: json["FIELDS"]["@OBJECTID"],
        Shape: json["FIELDS"]["@Shape"],
        Subtype: json["FIELDS"]["@Subtype"],
        detailsLandUse: json["FIELDS"]["@detailsLandUse"],
        mainLandUse: json["FIELDS"]["@mainLandUse"],
        description: json["FIELDS"]["@description"],
        created_date: json["FIELDS"]["@created_date"],
        last_edited_date: json["FIELDS"]["@last_edited_date"],
        region_Id: json["FIELDS"]["@region_Id"],
        sector_Id: json["FIELDS"]["@sector_Id"],
        amana_Id: json["FIELDS"]["@amana_Id"],
        governorate_Id: json["FIELDS"]["@governorate_Id"],
        municipality_Id: json["FIELDS"]["@municipality_Id"],
        city_Id: json["FIELDS"]["@city_Id"],
        district_Id: json["FIELDS"]["@district_Id"],
        subDistrictName_Id: json["FIELDS"]["@subDistrictName_Id"],
        subDivisionPlan_Id: json["FIELDS"]["@subDivisionPlan_Id"],
        block_Id: json["FIELDS"]["@block_Id"],
        parcel_Id: json["FIELDS"]["@parcel_Id"],
        parcelIDOld: json["FIELDS"]["@parcelIDOld"],
        parcelCode: json["FIELDS"]["@parcelCode"],
        parcelStatus: json["FIELDS"]["@parcelStatus"],
        measuredArea: json["FIELDS"]["@measuredArea"],
        subParcelCount: json["FIELDS"]["@subParcelCount"],
        drawingNumber: json["FIELDS"]["@drawingNumber"],
        dateOfDrawing: json["FIELDS"]["@dateOfDrawing"],
        drawingStatus: json["FIELDS"]["@drawingStatus"],
        drawingVersion: json["FIELDS"]["@drawingVersion"],
        subDivisionPlanPartNumber: json["FIELDS"]["@subDivisionPlanPartNumber"],
        street_Id: json["FIELDS"]["@street_Id"],
        deedNumber: json["FIELDS"]["@deedNumber"],
        subDivisionPlanName_ar: json["FIELDS"]["@subDivisionPlanName_ar"],
        subDivisionPlanName_en: json["FIELDS"]["@subDivisionPlanName_en"],
        ownershipType: json["FIELDS"]["@ownershipType"],
        approvalNumber: json["FIELDS"]["@approvalNumber"],
        subDivisionParcelNumber: json["FIELDS"]["@subDivisionParcelNumber"],
        asbuiltRemarks: json["FIELDS"]["@asbuiltRemarks"],
        isRegistered: json["FIELDS"]["@isRegistered"],
        isLicensed: json["FIELDS"]["@isLicensed"],
        transaction_Id: json["FIELDS"]["@transaction_Id"],
        layer: json["FIELDS"]["@layer"],
        dateOfApproval: json["FIELDS"]["@dateOfApproval"],
        approvedBy: json["FIELDS"]["@approvedBy"],
        dateOfApprovalHijri: json["FIELDS"]["@dateOfApprovalHijri"],
        isRegulated: json["FIELDS"]["@isRegulated"],
        isBuilt: json["FIELDS"]["@isBuilt"],
        dateOfRegistered: json["FIELDS"]["@dateOfRegistered"],
        dateOfLicense: json["FIELDS"]["@dateOfLicense"],
        dateOfRegisteredHijri: json["FIELDS"]["@dateOfRegisteredHijri"],
        dateOfLicenseHijri: json["FIELDS"]["@dateOfLicenseHijri"],
        LicenseNumber: json["FIELDS"]["@LicenseNumber"],
        noOfFloors: json["FIELDS"]["@noOfFloors"],
        constructionPercentage: json["FIELDS"]["@constructionPercentage"],
        rearDefection: json["FIELDS"]["@rearDefection"],
        sideDefection: json["FIELDS"]["@sideDefection"],
        frontDefection: json["FIELDS"]["@frontDefection"],
        mainLandUseDescription: json["FIELDS"]["@mainLandUseDescription"],
        subtypeDescription: json["FIELDS"]["@subtypeDescription"],
        detailsLandUseDescription: json["FIELDS"]["@detailsLandUseDescription"],
        SubDivisionParcel_Unified_Id: json["FIELDS"]["@SubDivisionParcel_Unified_Id"],
        isCommercial: json["FIELDS"]["@isCommercial"],
        buildingCondition: json["FIELDS"]["@buildingCondition"],
        subMunicipality_Id: json["FIELDS"]["@subMunicipality_Id"],
        SHAPE_Length: json["FIELDS"]["@SHAPE_Length"],
        SHAPE_Area: json["FIELDS"]["@SHAPE_Area"],
        AREASQM: json["FIELDS"]["@AREASQM"],
      );
}
