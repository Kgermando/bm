
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? telephone;
  String? nameBusiness;
  String? province;
  String? typeAbonnement;
  String? password;
  String? passwordConfirm;
  // DateTime? createdAt;
  // DateTime? updatedAt;


  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.nameBusiness,
    required this.province,
    required this.typeAbonnement,
    required this.password,
    required this.passwordConfirm,
    // required this.createdAt,
    // required this.updatedAt,
  });

 
  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        telephone: json["telephone"],
        nameBusiness: json["nameBusiness"],
        province: json["province"],
        typeAbonnement: json["typeAbonnement"],
        password: json["password"],
        passwordConfirm: json["passwordConfirm"],
        // createdAt: json["createdAt"],
        // updatedAt: json["updatedAt"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "telephone": telephone,
        "nameBusiness": nameBusiness,
        "province": province,
        "typeAbonnement": typeAbonnement,
        "password": password,
        "passwordConfirm": passwordConfirm,
        // "createdAt": createdAt,
        // "updatedAt": updatedAt,
      };
}
