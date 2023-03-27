// ignore_for_file: file_names

import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class SessionKeys {
  static String theme = 'theme';
  static String fcmToken = 'fcmToken';
  static String loginUser = 'loginUser';
  static String userID = 'userID';
}

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  save(String key, value) {
    GetStorage().write(key, value);
  }

  readData(String key) {
    final data = GetStorage().read(key);
    return data != null ? json.decode(data) : null;
  }

  saveData(String key, value) {
    GetStorage().write(key, json.encode(value));
  }

  remove(String key) {
    GetStorage().remove(key);
  }

  containKey(String key) {
    final allKeys = GetStorage().getKeys();
    return allKeys.contains(key);
  }

  //=======================================================================
  //===================== Save Keys with values ===========================
  //=======================================================================

  saveFCMToken({String? token}) {
    saveData(SessionKeys.fcmToken, token);
  }

  saveUserId({String? userID}) => saveData(SessionKeys.userID, userID);

  //=======================================================================
  //======================== Get Keys with values =========================
  //=======================================================================

  String? getToken() {
    if (containKey(SessionKeys.fcmToken)) {
      return readData(SessionKeys.fcmToken);
    }
    return null;
  }

  bool get isUserLogin {
    var isContain = containKey(SessionKeys.userID);
    return isContain;
  }

  String get userID {
    return readData(SessionKeys.userID);
  }

  bool get isLightMode {
    return readData(SessionKeys.theme);
  }

  clearSession() {
    remove(SessionKeys.userID);
    remove(SessionKeys.fcmToken);
    remove(SessionKeys.loginUser);
  }
}
