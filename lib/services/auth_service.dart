import 'dart:convert';

import 'package:e_management/global/environment.dart';
import 'package:e_management/src/models/login_model.dart';
import 'package:e_management/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  static const _TOKEN_KEY = 'jwt';

  User? user;

  final _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read(key: 'jwt');
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'jwt');
  }

  Future<dynamic> login(String telephone, String password) async {
    Map data = {'telephone': telephone, 'password': password};

    var loginUrl = Uri.parse("${Environment.serverUrl}/auth/login");
    var body = jsonEncode(data);
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final resp = await http.post(loginUrl, body: body, headers: headers);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      print(resp.body);
      // final loginResponse = loginModelFromJson(resp.body);
      // user = loginResponse.user;
      // await _guardarToken(loginResponse.jwt);
      await _guardarToken("jwt");
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> register(
      String firstName,
      String lastName,
      String email,
      String telephone,
      String nameBusiness,
      String province,
      String typeAbonnement,
      DateTime createdAt,
      DateTime updatedAt) async {
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'telephone': telephone,
      'nameBusiness': nameBusiness,
      'province': province,
      'typeAbonnement': typeAbonnement,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };

    var registerUrl = Uri.parse("${Environment.serverUrl}/auth/register");

    final resp = await http.post(registerUrl,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final registerResponse = loginModelFromJson(resp.body);
      user = registerResponse.user;
      // await _guardarToken(registerResponse.jwt);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final jwt = await this._storage.read(key: 'jwt');
    var getuserUrl = Uri.parse("${Environment.serverUrl}/auth/user");

    final resp = await http.get(getuserUrl,
        headers: {'Content-Type': 'application/json', 'x-token': jwt!});

    if (resp.statusCode == 200) {
      // final userResponse = loginModelFromJson(resp.body);
      // user = userResponse.user;
      await _guardarToken("jwt");
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future<void> _guardarToken(String jwt) async =>
      await _storage.write(key: _TOKEN_KEY, value: jwt);

  Future<void> logout() async => await _storage.delete(key: _TOKEN_KEY);
}
