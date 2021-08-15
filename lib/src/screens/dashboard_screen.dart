import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/produits/ventes/add_vente_form.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/stats/an.dart';
import 'package:e_management/src/stats/jours.dart';
import 'package:e_management/src/stats/mouth.dart';
import 'package:e_management/src/stats/semaine.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Business-Management '),  // ${controller.index + 1}
            actions: [
              PopupMenuButton<MenuItem>(
                onSelected: (item) => MenuOptions().onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
                  PopupMenuDivider(),
                  ...MenuItems.itemsSecond
                      .map(MenuOptions().buildItem)
                      .toList(),
                ],
              )
            ],
            bottom: TabBar(
              controller: controller,
              // indicatorWeight: 10,
              tabs: [
                Tab(text: 'Jour', icon: Icon(Icons.view_day)),
                Tab(text: 'Semaine', icon: Icon(Icons.weekend)),
                Tab(text: 'Mois', icon: Icon(Icons.motion_photos_pause_sharp)),
                Tab(text: 'An', icon: Icon(Icons.price_check)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddVenteForm()));
            },
            tooltip: 'Ajoutez ventes',
            child: Icon(Icons.add),
          ),
          drawer: SideBarScreen(),
          body: TabBarView(
            controller: controller,
            children: [
              JourStats(),
              SemaineStats(),
              MouthStats(),
              AnStats()
            ],
          )),
    );
  }
}
