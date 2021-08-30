import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/auth/login_screen.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/timezone.dart' as tz;

final storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final String title = 'B-Management';

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    scheduleNotification();
  }

  Future<void> onSelectNotification(String? payload) async {
    debugPrint('$payload');
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('sdsdsdsd'),
              content: Text('Payload: $payload'),
            ));
  }

  Future<DetteModel?> scheduleNotification() async {
    List<DetteModel> detteList = await ProductDatabase.instance.getAllDette();

    for (var item in detteList) {
      print(item.categorie);

      DateTime now = DateTime.now();
      DateTime datePayement = item.datePayement;
      Duration difference = now.isAfter(datePayement)
          ? now.difference(datePayement)
          : datePayement.difference(now);

      var scheduledNotificationDateTime =
          tz.TZDateTime.now(tz.UTC).add(difference);

      // var scheduledNotificationDateTime =
      //     tz.TZDateTime.now(tz.UTC).add(new Duration(seconds: 5));

      await _flutterLocalNotificationsPlugin.zonedSchedule(
          item.id!,
          '${item.personne}',
          'Echéance de payement ${item.categorie} ${item.sousCategorie} ${item.type}',
          scheduledNotificationDateTime,
          NotificationDetails(
              android: AndroidNotificationDetails("123", "${item.categorie}",
                  '${item.sousCategorie} ${item.categorie}')),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(builder: (context) {
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
              }),
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('fr', 'FR')],
        );
      }),
    );
  }
}
