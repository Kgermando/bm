import 'package:e_management/src/auth/forgot_password_screen.dart';
import 'package:e_management/src/auth/register_screen.dart';
import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidgetForm(),
    );
  }
}

class LoginWidgetForm extends StatefulWidget {
  const LoginWidgetForm({Key? key}) : super(key: key);

  @override
  _LoginWidgetFormState createState() => _LoginWidgetFormState();
}

class _LoginWidgetFormState extends State<LoginWidgetForm> {
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
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
                    signUpButtonBuild(),
                  ],
                ),
              )
            ],
          ),
        ));
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

  Widget usernameBuild() {
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

  Widget passwordBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.purple,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  Widget forgotPasswordBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
            },
            child: Text('Mot de passe oublié?'))
      ],
    );
  }

  Widget loginButtonBuild() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                'CONNEXION',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
              )))
    ]);
  }

  Widget buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OU -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget loginTextBuild() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Connectez-vous ici",
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
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logoBuild(),
                usernameBuild(),
                passwordBuild(),
                forgotPasswordBuild(),
                loginButtonBuild(),
                buildOrRow(),
                // buildSocialBtnRow(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget signUpButtonBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Créez votre compte  ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'ici',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]))))
      ],
    );
  }
}
