import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tatweer_maximo/models/security_group.dart';
import '../constants.dart';
import '../screens/main_screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<Map<String, dynamic>> {
  UserNotifier()
      : super({
          'apikey': '',
          'securityGroups': [],
          'currentSG': '',
        });

  Future<http.Response> _basicAuthLogin(String maxAuthEncoded) {
    return http.post(
      Uri.parse('${Constants.baseUrl}oslc/apitoken/create?lean=1'),
      headers: <String, String>{
        'maxauth': maxAuthEncoded,
      },
      body: jsonEncode(<String, dynamic>{"expiration": -1}),
    );
  }

  Future<http.Response> _LDAPLogin(String maxAuthEncoded) {
    return http.post(
      Uri.parse('${Constants.baseUrl}oslc/apitoken/create?lean=1'),
      headers: <String, String>{
        'Authorization': 'Basic $maxAuthEncoded',
      },
      body: jsonEncode(<String, dynamic>{"expiration": -1}),
    );
  }

  Future<http.Response> _getLoggedInUserInfo([String? localApiKey]) {
    var usedApiKey = state["apikey"] != '' ? state["apikey"] : localApiKey;
    return http.get(
      Uri.parse('${Constants.baseUrl}oslc/whoami?lean=1'),
      headers: <String, String>{'apikey': usedApiKey, 'expiration': '-1'},
    );
  }

  Future<http.Response> _loadLoggedInSecurityGroups() {
    return http.get(
      Uri.parse(
          '${Constants.baseUrl}oslc/os/MAXGROUPHTTP?lean=1&savedQuery=SECURGROUP%3ALOGGEDIN_SECGROUPS&oslc.select=groupname,mobilesc,mobilescdesc.description,mobilescweight'),
      headers: <String, String>{
        'apikey': state["apikey"],
      },
    );
  }

  SecurityGroup _setHeighestWeightSG(List<SecurityGroup> securityGroups) {
    var heighestWeightSC = securityGroups[0];
    for (var i = 1; i < securityGroups.length; i++) {
      if (securityGroups[i].mobileSCWeight > heighestWeightSC.mobileSCWeight) {
        heighestWeightSC = securityGroups[i];
      }
    }
    return heighestWeightSC;
  }

  Future<http.Response> _revokeApiKey() {
    return http.post(
      Uri.parse('${Constants.baseUrl}oslc/apitoken/revoke?lean=1'),
      headers: <String, String>{
        'apikey': state["apikey"],
      },
      body: jsonEncode(<String, String>{}),
    );
  }

  Map<String, dynamic> getUserInfo() {
    return state;
  }

  // Save APIKEY to shared preferences (local storage)
  Future<List<SecurityGroup>> _getLoggedInSecurityGroups() async {
    final loggedInUserSecurityGroupsResponse =
        await _loadLoggedInSecurityGroups();
    var parsedloggedInUserSecurityGroups =
        json.decode(loggedInUserSecurityGroupsResponse.body);
    final List<SecurityGroup> loggedInUserSecurityGroups = [];
    for (final securityGroup in parsedloggedInUserSecurityGroups["member"]) {
      if (securityGroup["mobilesc"] != null) {
        loggedInUserSecurityGroups.add(
          SecurityGroup(
            mobileSCWeight: securityGroup["mobilescweight"],
            groupname: securityGroup["groupname"],
            mobileSC: securityGroup["mobilesc"],
            mobileSCDescription: securityGroup["mobilescdesc"]["description"],
          ),
        );
      }
    }

    return loggedInUserSecurityGroups;
  }

  // Save credintials to shared preferences (local storage)
  Future<void> saveCredintialsToSharedPreferences(
      Map<String?, String?> credintials) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', credintials["username"]!);
    await prefs.setString('password', credintials["password"]!);
  }

  // Retrieve credintials from shared preferences (local storage)
  Future<Map<String?, String?>> getCredintialsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "username": prefs.getString('username'),
      "password": prefs.getString('password'),
    };
  }

  // Remove credintials from shared preferences (local storage)
  Future<void> removeCredintialsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');
  }

  // Save APIKEY to shared preferences (local storage)
  Future<void> saveApiKeyToSharedPreferences(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiKey', apiKey);
  }

  // Retrieve APIKEY from shared preferences (local storage)
  Future<String?> getApiKeyFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiKey');
  }

  // Remove APIKEY from shared preferences (local storage)
  Future<void> removeApiKeyFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('apiKey');
  }

  Future<void> checkApiKeyExistance() async {
    String? apikey = '';
    if (state["apikey"] == '') {
      apikey = await getApiKeyFromSharedPreferences();
      if (apikey != '') {
        if (await checkApiKeyValidity(apikey)) {
          state = {...state, "apikey": apikey};
          await _setAllLoggedInUserData();
        } else {
          // if apikey is expired - use saved credintials to login again
          final credintials = await getCredintialsFromSharedPreferences();
          await logIn(credintials);
        }
      }
    }
  }

  Future<bool> checkApiKeyValidity(String? apiKey) async {
    try {
      final response = await _getLoggedInUserInfo(apiKey);
      final parsedResponse = json.decode(response.body);
      if (parsedResponse["Error"] != null) {
        if (parsedResponse["Error"]["statusCode"] == "400") {
          return false;
        }
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  // logout user if APIKEY is expired
  Future<bool> checkApiKeyExpiry(String? apiKey) async {
    try {
      if (await checkApiKeyValidity(apiKey)) {
        return true;
      }
      await removeApiKeyFromSharedPreferences();
      authStreamController.sink.add('');
      return false;
    } catch (error) {
      return false;
    }
  }

  String getApiKey() {
    return state["apikey"];
  }

  List<SecurityGroup> getSecurityGroups() {
    return state["securityGroups"] ?? [];
  }

  String getCurrentSC() {
    return state["currentSG"].mobileSC;
  }

  void setCurrentSG(SecurityGroup securityGroup) {
    state = {...state, "currentSG": securityGroup};
  }

  Future<String> logOut(Function disableLoadingSpinner) async {
    try {
      await removeApiKeyFromSharedPreferences();
      await removeCredintialsFromSharedPreferences();
      final response = await _revokeApiKey();
      disableLoadingSpinner();
      authStreamController.sink.add('');
      return response.toString();
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> logIn(Map<String?, String?> credintials) async {
    final maxAuth = '${credintials["username"]}:${credintials["password"]}';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final maxAuthEncoded = stringToBase64.encode(maxAuth);

    final response = await _basicAuthLogin(maxAuthEncoded);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    if (parsedResponse["apikey"] != null) {
      await saveApiKeyToSharedPreferences(parsedResponse["apikey"]);
      await saveCredintialsToSharedPreferences(credintials);
      state = {...state, "apikey": parsedResponse["apikey"]};
      final userInfoResponse = await _getLoggedInUserInfo();
      final loggedInUserSecurityGroups = await _getLoggedInSecurityGroups();
      if (loggedInUserSecurityGroups.isEmpty) {
        await _revokeApiKey();
        await removeApiKeyFromSharedPreferences();
        state = {"apikey": '', ...state};
        return 'EMPTYSG';
      }
      final heighestWeightSG = _setHeighestWeightSG(loggedInUserSecurityGroups);
      final Map<String, dynamic> parsedUserInfoResponse =
          json.decode(userInfoResponse.body);
      final String originalProfileImageUrl =
          parsedUserInfoResponse["_imagelibref"] ?? '';
      final String correctImageUrl = originalProfileImageUrl.replaceAll(
          Constants.baseWrongImageUrl, Constants.baseCorrectImageUrl);
      state = {
        ...state,
        ...parsedUserInfoResponse,
        "profileImageUrl": correctImageUrl,
        "securityGroups": loggedInUserSecurityGroups,
        "apikey": parsedResponse["apikey"],
        "currentSG": heighestWeightSG
      };
      return parsedResponse["apikey"];
    }
    return '';
  }

  Future<String> _setAllLoggedInUserData() async {
    final userInfoResponse = await _getLoggedInUserInfo();
    final loggedInUserSecurityGroups = await _getLoggedInSecurityGroups();
    if (loggedInUserSecurityGroups.isEmpty) {
      await _revokeApiKey();
      state = {"apikey": '', ...state};
      return 'EMPTYSG';
    }
    final heighestWeightSG = _setHeighestWeightSG(loggedInUserSecurityGroups);
    final Map<String, dynamic> parsedUserInfoResponse =
        json.decode(userInfoResponse.body);
    final String originalProfileImageUrl =
        parsedUserInfoResponse["_imagelibref"] ?? '';
    final String correctImageUrl = originalProfileImageUrl.replaceAll(
        Constants.baseWrongImageUrl, Constants.baseCorrectImageUrl);

    state = {
      ...state,
      ...parsedUserInfoResponse,
      "profileImageUrl": correctImageUrl,
      "securityGroups": loggedInUserSecurityGroups,
      "currentSG": heighestWeightSG
    };
    return '';
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, Map<String, dynamic>>((ref) {
  return UserNotifier();
});
