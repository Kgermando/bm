import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/produits/dette/add_dette_form.dart';
import 'package:e_management/src/produits/dette/detail_dette_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:e_management/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListDetteScreen extends StatefulWidget {
  const ListDetteScreen({Key? key}) : super(key: key);

  @override
  _ListDetteScreenState createState() => _ListDetteScreenState();
}

class _ListDetteScreenState extends State<ListDetteScreen> {
  @override
  void initState() {
    getData();
    super.initState();
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
                    Icons.money_off_csred_sharp,
                    size: 40.0,
                    color: MyThemes.primary,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                            "${dette.sousCategorie} ${dette.type} ${dette.identifiant}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis)),
                      ),
                      Text('${dette.categorie}',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
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
                          fontSize: 14,
                          color: MyThemes.primary,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Qty: ${dette.quantity} ${dette.unity}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10)),
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
