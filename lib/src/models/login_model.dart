import 'dart:convert';

import 'package:e_management/src/models/user_model.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String ok;
  User? user;
  String jwt;

  LoginModel({
    required this.ok,
    required this.user,
    required this.jwt,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    ok: json["ok"], 
    user: User.fromJson(json["user"]),
    jwt: json["jwt"]
  );


  Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user!.toJson(),
        "jwt": jwt,
      };
}
