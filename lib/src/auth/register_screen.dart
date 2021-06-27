import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? telephone;
  String? province;
  String? nameBusiness;
  String? typeAbonnement;
  String? password;
  String? confirmPassword;
  int? roleId;

  final String provinceValue = 'Kinshasa';

  var _provinces = <String>[
    'Bas-Uele',
    'Équateur',
    'Haut-Katanga,'
        'Haut-Lomami',
    'Haut-Uele',
    'Ituri	Bunia',
    'Kasaï	Tshikapa',
    'Kasaï central',
    'Kasaï oriental',
    'Kinshasa',
    'Kongo-Central',
    'Kwango',
    'Kwilu',
    'Lomami',
    'Lualaba',
    'Mai-Ndombe',
    'Maniema',
    'Mongala',
    'Nord-Kivu',
    'Nord-Ubangi',
    'Sankuru',
    'Sud-Kivu',
    'Sud-Ubangi',
    'Tanganyika',
    'Tshopo',
    'Tshuapa',
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff2f3f7),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  )),
            ),
          ),
          SingleChildScrollView(
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
    return Row(
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
                userNameBuild(),
                emailBuild(),
                telephoneBuild(),
                provinceBuild(),
                nameBusinessBuild(),
                typeAbonnementBuild(),
                passwordBuild(),
                confirmPasswordBuild(),
                registerButtonBuild(),
              ],
            ),
          ),
        )
      ],
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
              color: Colors.purple,
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
              color: Colors.purple,
            ),
            labelText: 'Nom'),
      ),
    );
  }


  Widget userNameBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            username = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.purple,
            ),
            labelText: 'Nom d\'utilisateur'),
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
              color: Colors.purple,
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
              color: Colors.purple,
            ),
            labelText: 'Téléphone'),
      ),
    );
  }

  Widget provinceBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.place,
                  color: Colors.purple,
                ),
                labelText: 'Province'
            ),
            value: provinceValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            
            items: _provinces.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
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
            color: Colors.purple,
          ),
          labelText: 'Nom de votre activité'
        ),
      ),
    );
  }

    Widget typeAbonnementBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            typeAbonnement = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.attach_money,
              color: Colors.purple,
            ),
            labelText: 'Type d\'abonnement'),
      ),
    );
  }

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
              color: Colors.purple,
            ),
            labelText: 'Mot de passe'),
      ),
    );
  }

    Widget confirmPasswordBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            confirmPassword = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.password,
              color: Colors.purple,
            ),
            labelText: 'Confirmer votre mot de passe'),
      ),
    );
  }


  Widget registerButtonBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 10),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
            },
            child: Text(
              'INSCRIPTION',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height / 50,
              ),
            )
          )
        )
      ]
    );
  }
}
