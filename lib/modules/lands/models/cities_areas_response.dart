// To parse this JSON data, do
//
//     final cityAreaResponse = cityAreaResponseFromJson(jsonString);

import 'dart:convert';

CityAreaResponse cityAreaResponseFromJson(String str) => CityAreaResponse.fromJson(json.decode(str));

class CityAreaResponse {
  CityAreaResponse({
    required this.code,
    required this.message,
   required this.cities,
  });

  final int code;
  final String message;
  final List<City> cities;

  factory CityAreaResponse.fromJson(Map<String, dynamic> json) => CityAreaResponse(
        code: json["code"],
        message: json["message"],
        cities: json["item"] == null ? [] : List<City>.from(json["item"].map((x) => City.fromJson(x))),
      );
}

class City {
  City({
    required this.id,
    required this.tite,
   required this.area,
  });

  final int id;
  final String tite;
  final List<Area> area;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        tite: json["tite"],
        area: ["area"] == null ? [] : List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
      );
}

class Area {
  Area({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        title: json["title"],
      );
}
