import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/core/view/widgets/custom_text.dart';
import 'package:ared/modules/lands/models/cities_areas_response.dart';
import 'package:ared/modules/lands/models/land_request_model.dart';
import 'package:ared/modules/lands/models/lands_list_response.dart';
import 'package:ared/modules/lands/models/offer_attributes_response.dart';
import 'package:ared/modules/lands/repositories/land_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

enum landSpecilist { residential, commercial }

class LandsProvider extends ChangeNotifier {
  final LandRepository _repo;
  LandsProvider(this._repo);

  bool offerAttributesLoading = true;
  OfferAttributes? offerAttributes;
  List<City> cities = [];
  bool isLoading = false;
  bool sendRequestLoading = false;
  Failure? failure;
  List<LandItem> landList = [];
  LandRequestModel landRequestModel = LandRequestModel();
  Future<void> getOfferAttributes() async {
    if (offerAttributes != null) return;
    isLoading = true;
    notifyListeners();
    failure = null;
    try {
      offerAttributesLoading = true;
      notifyListeners();
      Either<Failure, OfferAttributes> result = await _repo.getOfferAttributes();
      result.fold((l) => offerAttributes = null, (r) {
        offerAttributes = r;
      });
    } catch (e) {
      kEchoError('error $e');
      failure = Failure(200, '$e');
    }
    isLoading = false;
    offerAttributesLoading = false;
    notifyListeners();
  }

  Future<void> getCitiesAndAreas() async {
    if (cities.isNotEmpty) return;
    isLoading = true;
    notifyListeners();
    failure = null;
    try {
      offerAttributesLoading = true;
      notifyListeners();
      Either<Failure, List<City>> result = await _repo.getCitiesAndAreas();
      result.fold((l) => cities = [], (r) {
        cities = r;
      });
    } catch (e) {
      kEchoError('error $e');
      failure = Failure(200, '$e');
    }
    offerAttributesLoading = false;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getLands() async {
    isLoading = true;
    notifyListeners();
    failure = null;
    try {
      List<LandItem> list = await _repo.getLands();
      landList.addAll(list);
      kEcho("lands list ${list.length}");
      kEcho("lands list ${landList.length}");
      notifyListeners();
    } catch (e) {
      kEchoError('error $e');
      failure = Failure(200, '$e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> sendLandRequest() async {
    //check if all fields are filled
    if (landRequestModel.offerTypeId == null) {
      Alerts.showToast(AppStrings.selectLandType);
      return false;
    }
    if (landRequestModel.usage == null) {
      Alerts.showToast(AppStrings.selectSpecialist);
      return false;
    }
    if (landRequestModel.cityId == null) {
      Alerts.showToast(AppStrings.selectCity);
      return false;
    }
    if (landRequestModel.areaId == null) {
      Alerts.showToast(AppStrings.selectArea);
      return false;
    }
    if (landRequestModel.price == null) {
      Alerts.showToast(AppStrings.enterPrice);
      return false;
    }
    if (landRequestModel.contact == null) {
      Alerts.showToast(AppStrings.enterContant);
      return false;
    }
    if (landRequestModel.contactBy == null) {
      Alerts.showToast(AppStrings.selectContantByType);
      return false;
    }

    sendRequestLoading = true;
    notifyListeners();
    try {
      offerAttributesLoading = true;
      notifyListeners();
      Either<String, String> result = await _repo.sendLandRequest(landRequestModel);
      result.fold((l) => Alerts.showToast(l), (r) {
        Alerts.showToast(r);
        return true;
      });
    } catch (e) {
      kEchoError('error $e');
    }
    sendRequestLoading = false;
    notifyListeners();
    return false;
  }

  List<DropdownMenuItem<String>> getLandTypeDropDownItems() {
    if (offerAttributes == null) return [];
    if (offerAttributes!.type == null) return [];
    return offerAttributes!.type!.map((e) {
      return DropdownMenuItem<String>(value: e.title, child: CustomText(e.title));
    }).toList();
  }

  String? getSelectedLandTypeValue() {
    if (landRequestModel.offerTypeId == null) return null;
    if (offerAttributes == null) return null;
    if (offerAttributes!.type == null) return null;
    AttributeItem type = offerAttributes!.type!.firstWhere((element) => element.id == landRequestModel.offerTypeId!);
    return type.title;
  }

  List<DropdownMenuItem<String>> getSpecialistDropDownItems() {
    List<DropdownMenuItem<String>> list = [];
    list.add(DropdownMenuItem<String>(value: landSpecilist.residential.toString(), child: const CustomText(AppStrings.residential)));
    list.add(DropdownMenuItem<String>(value: landSpecilist.commercial.toString(), child: const CustomText(AppStrings.commercial)));
    return list;
  }

  String? getSpecialistValue() {
    if (landRequestModel.usage == null) return null;
    if (landRequestModel.usage == landSpecilist.residential.toString()) return landSpecilist.residential.toString();
    if (landRequestModel.usage == landSpecilist.commercial.toString()) return landSpecilist.commercial.toString();
    return null;
  }

  List<DropdownMenuItem<String>> getCitiesDropDownItems() {
    if (cities.isEmpty) return [];
    return cities.map((e) {
      return DropdownMenuItem<String>(value: e.tite, child: CustomText(e.tite));
    }).toList();
  }

  String? getCityValue() {
    if (landRequestModel.cityId == null) return null;
    City city = cities.firstWhere((element) => element.id == landRequestModel.cityId);
    return city.tite;
  }

  List<DropdownMenuItem<String>> getAreasDropDownItems() {
    kEcho('areas called city id = ${landRequestModel.cityId}');
    kEcho('city: ${landRequestModel.cityId}');
    if (landRequestModel.cityId == null) return [];
    City city = cities.firstWhere((element) => element.id == landRequestModel.cityId);
    if (city.area.isEmpty) return [];
    return city.area.map((e) {
      return DropdownMenuItem<String>(value: e.title, child: CustomText(e.title));
    }).toList();
  }

  String? getAreaValue() {
    if (landRequestModel.areaId == null) return null;
    City city = cities.firstWhere((element) => element.id == landRequestModel.cityId);
    if (city.area.isEmpty) return null;
    Area area = city.area.firstWhere((element) => element.id == landRequestModel.areaId);
    return area.title;
  }

  void init() {
    //clear all data
    isLoading = false;
    sendRequestLoading = false;
    failure = null;
  }

  void refresh() {
    notifyListeners();
  }
}
