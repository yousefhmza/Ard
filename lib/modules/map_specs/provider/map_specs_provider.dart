import 'package:flutter/material.dart';

class MapSpecsProvider extends ChangeNotifier {
  bool showMyOffers = true;
  bool showPriceMark = true;
  bool showMapColors = true;

  void setMapSpecs({
    bool? showMyOffers,
    bool? showPriceMark,
    bool? showMapColors,
  }) {
    this.showMyOffers = showMyOffers ?? this.showMyOffers;
    this.showPriceMark = showPriceMark ?? this.showPriceMark;
    this.showMapColors = showMapColors ?? this.showMapColors;
    notifyListeners();
  }
}
