import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/pdf/pdf_api.dart';
import 'package:e_management/src/pdf/pdf_product_api.dart';
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

  List<AchatModel> achatsPdfList = [];

  Future<void> getData() async {
    List<AchatModel>? achatpdfList =
        await ProductDatabase.instance.getAllAchats();
    setState(() {
      ProductDatabase.instance.getAllAchats();
      achatsPdfList = achatpdfList;
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
            printPdf(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )),
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
            }));
  }

  Widget printPdf() {
    return ElevatedButton.icon(
        icon: Icon(Icons.print),
        label: Text(''),
        onPressed: () async {
          // final achatPdf = AchatModel(
          //     categorie: '',
          //     sousCategorie: '',
          //     nameProduct: '',
          //     quantity: '',
          //     unity: '',
          //     price: '',
          //     date: DateTime.now(),
          // );
          final pdfFile = await PdfProductApi.generate();

          PdfApi.openFile(pdfFile);
        });
  }

}

class AchatItemWidget extends StatefulWidget {
  const AchatItemWidget({Key? key, required this.achat}) : super(key: key);
  final AchatModel achat;

  @override
  _AchatItemWidgetState createState() => _AchatItemWidgetState(this.achat);
}

class _AchatItemWidgetState extends State<AchatItemWidget> {
  final AchatModel achat;

  _AchatItemWidgetState(this.achat);

  List<VenteModel> venteList = [];

  @override
  void initState() {
    super.initState();
    loadVente();
  }

  void loadVente() async {
    List<VenteModel>? ventes = await ProductDatabase.instance.getAllVente();
    setState(() {
      venteList = ventes;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter
    var filter = venteList.where((element) =>
        achat.categorie == element.categorie &&
        achat.sousCategorie == element.sousCategorie &&
        achat.nameProduct == element.nameProduct);

    // Quantités
    var filterQty = filter.map((e) => double.parse(e.quantity));
    double sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);

    double achatQty = double.parse(achat.quantity);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AchatDetailScreen(achat: achat)));
      },
      child: Card(
        color: getPriorityColor(),
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
                              fontWeight: FontWeight.bold, 
                              fontSize: 20, 
                              overflow: TextOverflow.ellipsis
                            )
                            ),
                      ),
                      Text('${achat.categorie} -> ${achat.sousCategorie}',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16, overflow: TextOverflow.ellipsis))
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
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                        'Stock: ${achatQty - sumQty} ${achat.unity}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Returns the priority color
  getPriorityColor() {
    // Filter
    var filter = venteList.where((element) =>
        achat.categorie == element.categorie &&
        achat.sousCategorie == element.sousCategorie &&
        achat.nameProduct == element.nameProduct);

    // Quantités
    var filterQty = filter.map((e) => double.parse(e.quantity));
    double sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);

    double qty = double.parse(achat.quantity);

    double qtyAchat1 = (qty / 1);
    double qtyAchat2 = (qty / 2);
    double qtyAchat3 = (qty / 3);
    double qtyAchat4 = (qty / 4);
    double qtyAchat5 = (qty / 5);
    double qtyAchat6 = (qty / 6);
    double qtyAchat7 = (qty / 7);
    double qtyAchat8 = (qty / 8);
    double qtyAchat9 = (qty / 9);
    double qtyAchat10 = (qty / 10);
    double qtyAchat12 = (qty / 12);
    double qtyAchat15 = (qty / 15);
    double qtyAchat18 = (qty / 18);
    double qtyAchat19 = (qty / 18 - 1);
    double qtyAchat20 = (qty / 20);

    if (sumQty == qtyAchat1) {
      return Colors.red[900];
    } else if (sumQty <= qtyAchat2) {
      return Colors.green[200];
    } else if (sumQty <= qtyAchat3) {
      return Colors.orange[100];
    } else if (sumQty <= qtyAchat4) {
      return Colors.orange[300];
    } else if (sumQty <= qtyAchat5) {
      return Colors.orange[500];
    } else if (sumQty <= qtyAchat6) {
      return Colors.orange[700];
    } else if (sumQty <= qtyAchat7) {
      return Colors.orange[900];
    } else if (sumQty <= qtyAchat8) {
      return Colors.red[500];
    } else if (sumQty <= qtyAchat9) {
      return Colors.red[600];
    } else if (sumQty <= qtyAchat10) {
      return Colors.red[700];
    } else if (sumQty <= qtyAchat12) {
      return Colors.red[800];
    } else if (sumQty <= qtyAchat15) {
      return Colors.red[900];
    } else if (sumQty <= qtyAchat18) {
      return Colors.pink[800];
    } else if (sumQty <= qtyAchat19) {
      return Colors.pink[900];
    } else if (sumQty <= qtyAchat20) {
      return Colors.purple[900];
    } else {
      return Colors.lightBlue[100];
    }
  }
}
