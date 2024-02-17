import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  final SharedPreferences _preferences;
  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _authTimer;
  bool isAdmin = false;

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String? get userId {
    return _userId;
  }

  AppPreference(this._preferences);

  void setUserLoggedIn(authData) {
    _token = authData.token;
    _userId = authData.userId;
    _expiryDate =
        DateTime.now().add(Duration(seconds: int.parse(authData.expiryDate)));

    _preferences.setString('token', _token!);
    _preferences.setString('userId', _userId!);
    _preferences.setString('expiryDate', _expiryDate!.toIso8601String());

    autoLogout();
  }

  bool isUserLoggedin() {
    if (!_preferences.containsKey('expiryDate') ||
        !_preferences.containsKey('token') ||
        !_preferences.containsKey('userId')) {
      return false;
    }

    _expiryDate = DateTime.parse(_preferences.getString('expiryDate')!);
    if (_expiryDate!.isBefore(DateTime.now())) {
      return false;
    }
    _token = _preferences.getString('token');
    _userId = _preferences.getString('userId');
    if (_userId == "gOAcYngxZdSFPKjk8sQnnrZMnni1") {
      isAdmin = true;
    }

    autoLogout();
    return true;
  }

  Future<void> logout() async {
    _preferences.remove('token');
    _preferences.remove('userId');
    _preferences.remove('expiryDate');
    _token = null;
    _userId = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
  }

  Future<void> autoLogout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
