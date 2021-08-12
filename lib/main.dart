import 'package:e_management/src/auth/login_screen.dart';
import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:localized/localized.dart';

final storage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B-Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data != "") {
            var str = snapshot.data;
            print(str); 
            // var jwt = str.toString().split(".");
            if (str.toString().length != 3) {
              return LoginScreen();
            } else {
              return DashboardScreen();
            }
          } else {
            return LoginScreen();
          }
        }
      ),
      // localizationsDelegates: [
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [Locale('en', 'US')],
    );
  }
}
