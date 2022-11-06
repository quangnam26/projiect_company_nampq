import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // Login: ----------------------------------------------------------
  bool get getLogin {
    return _sharedPreference.getBool(Preferences.isLogin) ?? false;
  }

  void setLogin({required bool status}) {
    _sharedPreference.setBool(Preferences.isLogin, status);
  }

  Future<bool> removeLogin() async {
    return _sharedPreference.remove(Preferences.isLogin);
  }

  // splash: ----------------------------------------------------------
  bool get getSplash {
    return _sharedPreference.getBool(Preferences.isSplash) ?? false;
  }

  void setSplash({required bool status}) {
    _sharedPreference.setBool(Preferences.isSplash, status);
  }

  Future<bool> removeSplash() async {
    return _sharedPreference.remove(Preferences.isSplash);
  }

  // General Methods: Access token
  String get getJwtToken {
    return _sharedPreference.getString(Preferences.jwtToken) ?? '';
  }

  Future<void> setJwtToken(String authToken) async {
    await _sharedPreference.setString(Preferences.jwtToken, authToken);
  }

  Future<bool> removeJWTToken() async {
    return _sharedPreference.remove(Preferences.jwtToken);
  }

  // fcm token
  String get getFcmToken {
    return _sharedPreference.getString(Preferences.fcmToken) ?? '';
  }

  void setFcmToken(String fcmToken) {
    _sharedPreference.setString(Preferences.fcmToken, fcmToken);
  }

  Future<bool> removeFCMToken() async {
    return _sharedPreference.remove(Preferences.fcmToken);
  }

  // Language:---------------------------------------------------
  String get getLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage) ?? Platform.localeName;
  }

  void setLanguage(String language) {
    _sharedPreference.setString(Preferences.currentLanguage, language);
  }

  // Token Device
  String get getTokenDevice {
    return _sharedPreference.getString(Preferences.tokenDevice) ?? '';
  }

  void setTokenDevice(String tokenDevice) {
    _sharedPreference.setString(Preferences.tokenDevice, tokenDevice);
  }

  Future<bool> removeTokenDevice() async {
    return _sharedPreference.remove(Preferences.tokenDevice);
  }

  // Id User
  String get getIdUser {
    return _sharedPreference.getString(Preferences.idUser) ?? '';
  }

  void setIdUser(String id) {
    _sharedPreference.setString(Preferences.idUser, id);
  }

  Future<bool> removeIdUser() async {
    return _sharedPreference.remove(Preferences.idUser);
  }

  // Calling: ----------------------------------------------------------
  bool get getCalling {
    return _sharedPreference.getBool(Preferences.isCalling) ?? false;
  }

  void setCalling({required bool isCalling}) {
    _sharedPreference.setBool(Preferences.isCalling, isCalling);
  }

  Future<bool> removeCalling() async {
    return _sharedPreference.remove(Preferences.isCalling);
  }
}
