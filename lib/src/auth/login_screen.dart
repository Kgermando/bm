import 'package:e_management/services/auth_service.dart';
import 'package:e_management/src/auth/forgot_password_screen.dart';
import 'package:e_management/src/auth/register_screen.dart';
import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:e_management/themes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                telephoneBuild(),
                passwordBuild(),
                forgotPasswordBuild(),
                loginButtonBuild(),
                buildOrRow(),
                // buildSocialBtnRow(),
                SizedBox(
                  height: 15.0,
                ),
                signUpButtonBuild()
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget telephoneBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: _telephone,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: MyThemes.primary,
            ),
            labelText: 'Téléphone'),
      ),
    );
  }

  Widget passwordBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        controller: _password,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: MyThemes.primary,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
            },
            child: Text('Mot de passe oublié?'))
      ],
    );
  }

  Widget loginButtonBuild() {
    return isLoading
        ? CircularProgressIndicator()
        : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 1.4 * (MediaQuery.of(context).size.height / 20),
                width: 5 * (MediaQuery.of(context).size.width / 10),
                margin: EdgeInsets.only(bottom: 5),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 10),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });

                      if (_telephone.text.isEmpty || _password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Remplissez tous les champs!"),
                          backgroundColor: Colors.redAccent[400],
                        ));
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        
                        AuthService()
                          .login(_telephone.text, _password.text)
                            .then((value) {
                          if (value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Login succès!"),
                              backgroundColor: Colors.green[700],
                            ));
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Login erreur verifiez vos coordonnées!"),
                              backgroundColor: Colors.red[700],
                            ));
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      'CONNEXION',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ))),
          ]);
  }

  Widget buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5),
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

  Widget signUpButtonBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 5),
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
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'ici',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]))))
      ],
    );
  }
}
