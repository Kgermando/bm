import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/produits/achats/detail_achat_screen.dart';
import 'package:e_management/themes.dart';
import 'package:flutter/material.dart';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';

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
      achatsPdfList = achatpdfList;
    });
  }

//  printPdf(),
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AchatModel>>(
        future: ProductDatabase.instance.getAllAchats(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AchatModel>> snapshot) {
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
        achat.type == element.type &&
        achat.identifiant == element.identifiant);

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
                        child: Row(
                          children: [
                            Text(
                              "${achat.sousCategorie} ${achat.type} ${achat.identifiant}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      Text('${achat.categorie}',
                          style: TextStyle(
                              color: Colors.grey[700],
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
                    child: Text('${achat.price} FC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: MyThemes.primary,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Stock: ${achatQty - sumQty} ${achat.unity}',
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

  // Returns the priority color
  getPriorityColor() {
    // Filter
    var filterVente = venteList.where((element) =>
      achat.categorie == element.categorie &&
      achat.sousCategorie == element.sousCategorie &&
      achat.type == element.type &&
      achat.type == element.type);

    // Quantités
    var filterQtyVente = filterVente.map((e) => double.parse(e.quantity));
    double sumQtyVente = 0;
    filterQtyVente.forEach((qty) => sumQtyVente += qty);

    double qtyAchat = double.parse(achat.quantity);

    double qtyVente = sumQtyVente * 100 / qtyAchat;

    // print(qtyVente);

    if (qtyVente <= 30.0) {
      return Colors.green[200];
    } else if (qtyVente <= 50.0) {
      return Colors.orange[300];
    } else if (qtyVente <= 80.0) {
      return Colors.orange[700];
    } else if (qtyVente <= 100.0) {
      return Colors.red[800];
    }
  }
}
