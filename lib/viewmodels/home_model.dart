import 'package:flutter/material.dart';
import 'package:ripple_animation/ui/shared/globals.dart';

class HomeModel extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  bool _isHalfWay = false;

  bool get isHalfWay => _isHalfWay;

  set isHalfWay(bool value) {
    _isHalfWay = value;
    notifyListeners();
  }

  bool _isToggled = false;

  bool get isToggled => _isToggled;

  set isToggled(bool value) {
    _isToggled = value;
    notifyListeners();
  }

  Color _backGroundColor = Global.palette[0];

  Color get backGroundColor => _backGroundColor;

  set backGroundColor(Color value) {
    _backGroundColor = value;
    notifyListeners();
  }

  Color _foreGroundColor = Global.palette[1];

  Color get foreGroundColor => _foreGroundColor;

  set foreGroundColor(Color value) {
    _foreGroundColor = value;
  }

  void swapColors(){
    if(_isToggled) {
      _backGroundColor = Global.palette[1];
      _foreGroundColor = Global.palette[0];
    }                            else{
      _backGroundColor = Global.palette[0];
      _foreGroundColor = Global.palette[1];
    }
    notifyListeners();
  }
}
