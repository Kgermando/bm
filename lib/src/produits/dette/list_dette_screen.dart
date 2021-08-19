import 'dart:convert';

import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/produits/dette/add_dette_form.dart';
import 'package:e_management/src/produits/dette/detail_dette_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class ListDetteScreen extends StatefulWidget {
  const ListDetteScreen({Key? key}) : super(key: key);

  @override
  _ListDetteScreenState createState() => _ListDetteScreenState();
}

class _ListDetteScreenState extends State<ListDetteScreen> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    getData();
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

      // var scheduledNotificationDateTime =
      //     tz.TZDateTime.from(item.datePayement, tz.local);

      DateTime now = DateTime.now();
      DateTime datePayement = item.datePayement;
      Duration difference = now.isAfter(datePayement)
          ? now.difference(datePayement)
          : datePayement.difference(now);

      var scheduledNotificationDateTime =
          tz.TZDateTime.now(tz.local).add(new Duration(seconds: 5));

      print(scheduledNotificationDateTime);

      await _flutterLocalNotificationsPlugin.zonedSchedule(
          item.id!,
          '${item.personne}',
          'Echéance de payement ${item.categorie} ${item.sousCategorie} ${item.type}',
          // tz.TZDateTime.now(tz.local).add(difference),
          scheduledNotificationDateTime,
          NotificationDetails(
              android: AndroidNotificationDetails("123", "${item.categorie}",
                  '${item.sousCategorie} ${item.categorie}')),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    }
  }

  Future<void> getData() async {
    setState(() {
      ProductDatabase.instance.getAllDette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liste des dettes'),
          actions: [
            printPdf(),
            PopupMenuButton<MenuItem>(
              onSelected: (item) => MenuOptions().onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
                PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(MenuOptions().buildItem).toList(),
              ],
            )
          ],
        ),
        drawer: SideBarScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddDetteForm()));
          },
          // onPressed: scheduleNotification,
          tooltip: 'Ajoutez dettes',
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<DetteModel>>(
            future: ProductDatabase.instance.getAllDette(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DetteModel>> snapshot) {
              if (snapshot.hasData) {
                List<DetteModel>? dettes = snapshot.data;
                return RefreshIndicator(
                  onRefresh: getData,
                  child: ListView.builder(
                      itemCount: dettes!.length,
                      itemBuilder: (context, index) {
                        final dette = dettes[index];
                        return DetteItemWidget(dette: dette);
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget printPdf() {
    return ElevatedButton.icon(
        icon: Icon(Icons.print), label: Text(''), onPressed: () async {});
  }
}

class DetteItemWidget extends StatelessWidget {
  final DetteModel dette;
  const DetteItemWidget({Key? key, required this.dette}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailDetteScreen(dette: dette)));
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      child: Icon(
                    Icons.money_off,
                    size: 40.0,
                    color: Color(0xFF6200EE),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text("${dette.type} ${dette.identifiant}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis)),
                      ),
                      Text('${dette.categorie} -> ${dette.sousCategorie}',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${dette.price} FC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF6200EE),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Qty: ${dette.quantity} ${dette.unity}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
