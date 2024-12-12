import 'package:flutter/material.dart';

class LeafyStateProvider with ChangeNotifier {
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
