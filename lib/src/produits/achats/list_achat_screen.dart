import 'package:e_management/src/produits/achats/detail_achat_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/produits/achats/add_achat_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';

class ListAchatScreen extends StatefulWidget {
  @override
  _ListAchatScreenState createState() => _ListAchatScreenState();
}

class _ListAchatScreenState extends State<ListAchatScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      ProductDatabase.instance.getAllAchats();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Liste des achats'),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.power_settings_new),
                label: Text(''),
              ),
            ],
          )
        ),
        drawer: SideBarScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAchatScreen()));
          },
          tooltip: 'Ajoutez achats',
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<AchatModel>>(
          future: ProductDatabase.instance.getAllAchats(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AchatModel>> snapshot) {
            if (snapshot.hasData) {
              List<AchatModel>? achats = snapshot.data;
              return RefreshIndicator(
                onRefresh: getData,
                child: ListView.builder(
                    itemCount: achats!.length,
                    itemBuilder: (context, index) {
                      final achat = achats[index];
                      return AchatItemWidget(achat: achat);
                    }),
                
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        )
      );
  }
}

class AchatItemWidget extends StatelessWidget {
  const AchatItemWidget({Key? key, required this.achat}) : super(key: key);
  final AchatModel achat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AchatDetailScreen(achat: achat)));
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
                    Icons.shopping_bag_sharp,
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
                        child: Text(achat.nameProduct,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text('${achat.categorie} -> ${achat.sousCategorie}',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 16))
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
                    child: Text('${achat.price} FC',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6200EE),
                      )
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Qty: ${achat.quantity} ${achat.unity}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14
                        )
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
