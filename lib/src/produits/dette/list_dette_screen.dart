import 'package:e_management/resources/products_database.dart';
import 'package:e_management/services/auth_service.dart';
import 'package:e_management/src/auth/login_screen.dart';
import 'package:e_management/src/auth/profile_screen.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/produits/dette/add_dette_form.dart';
import 'package:e_management/src/produits/dette/detail_dette_screen.dart';
import 'package:e_management/src/screens/setting_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:flutter/material.dart';

class ListDetteScreen extends StatefulWidget {
  const ListDetteScreen({Key? key}) : super(key: key);

  @override
  _ListDetteScreenState createState() => _ListDetteScreenState();
}

class _ListDetteScreenState extends State<ListDetteScreen> {
  @override
  void initState() {
    super.initState();
    getData();
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
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(buildItem).toList(),
                PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(buildItem).toList(),
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
      icon: Icon(Icons.print),
      label: Text(''),
      onPressed: () async {}
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: Colors.black, size: 20),
          const SizedBox(width: 12),
          Text(item.text)
        ],
      ));

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case MenuItems.itemProfile:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfileScreen()));

        break;
      case MenuItems.itemLogout:
        // Remove stockage jwt here.
        AuthService().logout();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        break;
    }
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
                builder: (context) => DetailDetteScreen(dette: dette)
              )
            );
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
                        child: Text(dette.sousCategorie,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,
                                overflow: TextOverflow.ellipsis)),
                      ),
                      Text('${dette.categorie} -> ${dette.sousCategorie}',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 16, overflow: TextOverflow.ellipsis))
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
