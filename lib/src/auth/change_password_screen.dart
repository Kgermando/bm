import 'package:e_management/src/auth/login_screen.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({ Key? key }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? password;
  String? confirmPassword;

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
          labelText: 'Mot de passe',
        ),
      ),
    );
  }

  Widget confirmPasswordBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            confirmPassword = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.purple,
          ),
          labelText: 'Confirme le mot de passe',
        ),
      ),
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
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                'MODIFICATION',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
              )))
    ]);
  }


  Widget loginTextBuild() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Modification du mot de passe",
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
                passwordBuild(),
                confirmPasswordBuild(),
                loginButtonBuild()
              ],
            ),
          ),
        )
      ],
    );
  }


}
