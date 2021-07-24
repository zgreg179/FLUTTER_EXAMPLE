import 'package:flutter/foundation.dart';

class RegistrationModel extends ChangeNotifier {

  static const int WAITNG_STATUS =0;
  static const int INCORRECT_STATUS =1;
  static const int CORRECT_STATUS =2;

  late String _verifyCode = '1111';
  late String _inpCode = '';
  int _status = -1;
  String get inpCode => _inpCode;

  set inpCode(String value) {
    _inpCode = value;
    notifyListeners();
  }

  String get verifyCode => _verifyCode;
  set verifyCode(String value) {
    _verifyCode = value;
    notifyListeners();
  }

  int get status => _status;
  set status(int value) {
    _status = value;
    notifyListeners();
  }
}