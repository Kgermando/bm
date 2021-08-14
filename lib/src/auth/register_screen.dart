import 'package:e_management/services/auth_service.dart';
import 'package:e_management/src/auth/login_screen.dart';
import 'package:e_management/src/models/user_model.dart';
import 'package:e_management/src/utils/province.dart';
import 'package:e_management/themes.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? email;
  String? telephone;
  String? province;
  String? nameBusiness;
  String? typeAbonnement;
  String? password;
  String? passwordConfirm;
  // int? roleId;

  final List<String> provinces =
      Province().provinces;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff2f3f7),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                  color: MyThemes.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  )),
            ),
          ),
          SingleChildScrollView(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginTextBuild(),
                containerBuilder(),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget loginTextBuild() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Créez votre compte",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 30,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget containerBuilder() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logoBuild(),
                  firstNameBuild(),
                  lastNameBuild(),
                  emailBuild(),
                  telephoneBuild(),
                  provinceBuild(),
                  nameBusinessBuild(),
                  // typeAbonnementBuild(),
                  passwordBuild(),
                  passwordConfirmBuild(),
                  registerButtonBuild(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget logoBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.asset(
            "assets/images/logo.png",
            width: 200,
            height: 200,
          ),
        )
      ],
    );
  }

  Widget firstNameBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            firstName = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person_outline_sharp,
              color: MyThemes.primary,
            ),
            labelText: 'Prénom'),
      ),
    );
  }

  Widget lastNameBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            lastName = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person_outline_sharp,
              color: MyThemes.primary,
            ),
            labelText: 'Nom'),
      ),
    );
  }

  Widget emailBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: MyThemes.primary,
            ),
            labelText: 'Adresse email'),
      ),
    );
  }

  Widget telephoneBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          setState(() {
            telephone = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              color: MyThemes.primary,
            ),
            labelText: 'Téléphone'),
      ),
    );
  }

  Widget provinceBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Province',
          prefixIcon: Icon(
            Icons.place,
            color: MyThemes.primary,
          ),
        ),
        // hint: Text('Province'),
        value: province,
        isExpanded: true,
        items: provinces.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          setState(() {
            // type = null;
            province = produit;
          });
        },
      ),
    );
  }

  Widget nameBusinessBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            nameBusiness = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.business,
              color: MyThemes.primary,
            ),
            labelText: 'Nom de votre activité'),
      ),
    );
  }

  // Widget typeAbonnementBuild() {
  //   return Padding(
  //     padding: EdgeInsets.all(8),
  //     child: TextFormField(
  //       keyboardType: TextInputType.text,
  //       onChanged: (value) {
  //         setState(() {
  //           typeAbonnement = value;
  //         });
  //       },
  //       decoration: InputDecoration(
  //           prefixIcon: Icon(
  //             Icons.attach_money,
  //             color: MyThemes.primary,
  //           ),
  //           labelText: 'Type d\'abonnement'),
  //     ),
  //   );
  // }

  Widget passwordBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.password,
              color: MyThemes.primary,
            ),
            labelText: 'Mot de passe'),
      ),
    );
  }

  Widget passwordConfirmBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        // validator: (pwd) => passwordConfirm != password
        //     ? 'Le mot de passe ne correspond pas'
        //     : null,
        onChanged: (value) {
          setState(() {
            passwordConfirm = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.password,
              color: MyThemes.primary,
            ),
            labelText: 'Confirmer votre mot de passe'),
      ),
    );
  }

  Widget registerButtonBuild() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 10),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                print(firstName);
                print(lastName);
                print(email);
                print(telephone);
                print(province);
                print(nameBusiness);
                // print(typeAbonnement);
                print(password);
                print(passwordConfirm);

                createUser();
              },
              child: Text(
                'INSCRIPTION',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
              )))
    ]);
  }

  Future createUser() async {
    final user = User(
        firstName: firstName.toString(),
        lastName: lastName.toString(),
        email: email.toString(),
        telephone: telephone.toString(),
        nameBusiness: nameBusiness.toString(),
        province: province.toString(),
        typeAbonnement: "OPEN",
        password: password.toString(),
        passwordConfirm: passwordConfirm.toString());

    await AuthService().register(user);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${user.firstName} ${user.lastName} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
