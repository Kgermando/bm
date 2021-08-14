class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String telephone;
  final String nameBusiness;
  final String province;
  final String typeAbonnement;
  final String? password;
  final String? passwordConfirm;
  final String? imagePath;
  final bool? isDarkMode;

  const User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.nameBusiness,
    required this.province,
    required this.typeAbonnement,
    this.password,
    this.passwordConfirm,
    this.imagePath,
    this.isDarkMode,
  });

  User copy({
    String? firstName,
    String? lastName,
    String? email,
    String? telephone,
    String? nameBusiness,
    String? province,
    String? typeAbonnement,
    String? password,
    String? passwordConfirm,
    String? imagePath,
    bool? isDarkMode,
  }) =>
      User(
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          telephone: telephone ?? this.telephone,
          nameBusiness: nameBusiness ?? this.nameBusiness,
          province: province ?? this.province,
          typeAbonnement: typeAbonnement ?? this.typeAbonnement,
          password: password ?? this.password,
          passwordConfirm: passwordConfirm ?? this.passwordConfirm,
          imagePath: imagePath ?? this.imagePath,
          isDarkMode: isDarkMode ?? this.isDarkMode,
        );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        telephone: json["telephone"],
        nameBusiness: json["nameBusiness"],
        province: json["province"],
        typeAbonnement: json["typeAbonnement"],
        // password: json["password"],
        // passwordConfirm: json["passwordConfirm"],
        imagePath: json['imagePath'],
        isDarkMode: json['isDarkMode'],
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
        'imagePath': imagePath,
        'isDarkMode': isDarkMode,
      };
}
