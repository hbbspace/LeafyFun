import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PlantProvider with ChangeNotifier {
  bool _hasScanned = false;
  bool _isInGarden = false;

  bool get hasScanned => _hasScanned;
  bool get isInGarden => _isInGarden;

  void setScanStatus(bool status) {
    _hasScanned = status;
    notifyListeners();
  }

  void setGardenStatus(bool status) {
    _isInGarden = status;
    notifyListeners();
  }
}
