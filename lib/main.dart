import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_management/src/auth/login_screen.dart';
import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'B-Management';

  Future<String> get jwtOrEmpty async {  
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: FutureBuilder(
              future: jwtOrEmpty,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                if (snapshot.data != "") {
                  var str = snapshot.data;
                  print(str);
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
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('fr', 'FR')],
          );
        }
      ),
    );
  }
}
