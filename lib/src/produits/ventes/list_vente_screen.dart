import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/produits/ventes/add_vente_form.dart';
import 'package:e_management/src/produits/ventes/detail_vente_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:flutter/material.dart';

class ListVenteScreen extends StatefulWidget {
  const ListVenteScreen({Key? key}) : super(key: key);

  @override
  _ListVenteScreenState createState() => _ListVenteScreenState();
}

class _ListVenteScreenState extends State<ListVenteScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      ProductDatabase.instance.getAllVenteByDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vos ventes'),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddVenteForm()));
          },
          tooltip: 'Ajoutez ventes',
          child: Icon(Icons.add),
        ),
        drawer: SideBarScreen(),
        body: FutureBuilder<List<VenteModel>>(
            future: ProductDatabase.instance.getAllVenteByDate(),
            builder: (BuildContext context,
                AsyncSnapshot<List<VenteModel>> snapshot) {
              if (snapshot.hasData) {
                List<VenteModel>? ventes = snapshot.data;
                print(ventes);
                return RefreshIndicator(
                  onRefresh: getData,
                  child: ListView.builder(
                      itemCount: ventes!.length,
                      itemBuilder: (context, index) {
                        final vente = ventes[index];
                        return VenteItemWidget(vente: vente);
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          )
        );
  }

  Widget printPdf() {
    return ElevatedButton.icon(
        icon: Icon(Icons.print), label: Text(''), onPressed: () async {});
  }

}

class VenteItemWidget extends StatelessWidget {
  const VenteItemWidget({Key? key, required this.vente}) : super(key: key);
  final VenteModel vente;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VenteDetailScreen(vente: vente)
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
                    Icons.add_chart,
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
                        child: Text("${vente.type} ${vente.identifiant}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20, overflow: TextOverflow.ellipsis)),
                      ),
                      Text('${vente.categorie} -> ${vente.sousCategorie}',
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
                    child: Text('${vente.price} FC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF6200EE),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Qty: ${vente.quantity} ${vente.unity}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)
                        ),
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
