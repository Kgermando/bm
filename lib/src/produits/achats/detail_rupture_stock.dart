import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/models/rupture_stock.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/produits/achats/add_achat_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailRuptureStock extends StatefulWidget {
  const DetailRuptureStock({Key? key, required this.ruptureStock})
      : super(key: key);
  final RuptureStockModel ruptureStock;

  @override
  _DetailRuptureStockState createState() =>
      _DetailRuptureStockState(this.ruptureStock);
}

class _DetailRuptureStockState extends State<DetailRuptureStock> {
  final RuptureStockModel ruptureStock;

  _DetailRuptureStockState(this.ruptureStock);

  List<VenteModel> venteList = [];
  List<DetteModel> detteList = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadVente();
    loadDette();
  }

  void loadVente() async {
    List<VenteModel>? ventes = await ProductDatabase.instance.getAllVente();
    setState(() {
      venteList = ventes;
      // print(venteList);
    });
  }

  void loadDette() async {
    List<DetteModel> dette = await ProductDatabase.instance.getAllDette();
    setState(() {
      detteList = dette;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${ruptureStock.categorie}'),
          Container(
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.print),
                  label: Text(''),
                ),
                // editButton(context),
                deleteButton(context)
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAchatForm()));
        },
        tooltip: 'Ajoutez achats',
        child: Icon(Icons.edit),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  header(),
                  headerTitle(),
                  ruptureStockTitle(),
                  ruptureStocks(),
                  ventetitle(),
                  ventes(),
                  benfices(),
                ],
              ),
            ),
    );
  }

  Widget header() {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${ruptureStock.categorie.toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(DateFormat("dd.MM.yy HH:mm").format(ruptureStock.date),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        ],
      ),
    ));
  }

  Widget headerTitle() {
    return Card(
        child: Padding(
      padding: EdgeInsets.only(top: 28.0, bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(ruptureStock.sousCategorie,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(ruptureStock.type,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              overflow: TextOverflow.ellipsis),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(ruptureStock.identifiant,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    ));
  }

  Widget ruptureStockTitle() {
    return Card(
      child: Text(
        'RUPTURE DU STOCK',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }

  Widget ruptureStocks() {
    double prix = double.parse(ruptureStock.price);
    double quantite = double.parse(ruptureStock.quantity);
    // var = prix / quantite;
    return Card(
        child: Padding(
      padding: EdgeInsets.only(top: 28.0, bottom: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${ruptureStock.quantity} ${ruptureStock.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${ruptureStock.price} FC',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.blueGrey[800])),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1 ${ruptureStock.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${prix / quantite} FC',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            ],
          ),
        ],
      ),
    ));
  }

  Widget ventetitle() {
    return Card(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        'VENTES',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }

  Widget ventes() {
    // Filter
    var filter = venteList.where((element) =>
        ruptureStock.categorie == element.categorie &&
        ruptureStock.sousCategorie == element.sousCategorie &&
        ruptureStock.type == element.type &&
        ruptureStock.identifiant == element.identifiant);

    // Quantités
    var filterQty = filter.map((e) => int.parse(e.quantity));

    int sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);

    // Prix
    var filterPrice = filter.map((e) => int.parse(e.price));

    int sumPrice = 0;
    filterPrice.forEach((price) => sumPrice += price);

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
          child: Card(
              child: Padding(
        padding: EdgeInsets.only(top: 28.0, bottom: 10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${ruptureStock.unity} vendus',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                Text('Montant vendus',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$sumQty ${ruptureStock.unity}',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                Text('$sumPrice FC',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.blue[800])),
              ],
            ),
          ],
        ),
      ))),
    );
  }

  Widget benfices() {
    // Filter
    var filterVente = venteList.where((element) =>
        ruptureStock.categorie == element.categorie &&
        ruptureStock.sousCategorie == element.sousCategorie &&
        ruptureStock.type == element.type &&
        ruptureStock.identifiant == element.identifiant);

    // Quantités
    var filterQtyVente = filterVente.map((e) => int.parse(e.quantity));
    int sumQtyVente = 0;
    filterQtyVente.forEach((qty) => sumQtyVente += qty);

    // Prix
    var filterPriceVente = filterVente.map((e) => int.parse(e.price));
    int sumPriceVente = 0;
    filterPriceVente.forEach((price) => sumPriceVente += price);

    int qtyAchat = int.parse(ruptureStock.quantity);
    int prixAchat = int.parse(ruptureStock.price);

    var filterDette = detteList.where((element) =>
        ruptureStock.categorie == element.categorie &&
        ruptureStock.sousCategorie == element.sousCategorie &&
        ruptureStock.type == element.type &&
        ruptureStock.identifiant == element.identifiant);

    var filterQtyDette = filterDette.map((e) => int.parse(e.quantity));
    int sumQtyDette = 0;
    filterQtyDette.forEach((qty) => sumQtyDette += qty);

    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Card(
            child: Padding(
          padding: EdgeInsets.only(top: 28.0, bottom: 10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Restes des ${ruptureStock.unity}',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  Text('Revenues',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${qtyAchat - sumQtyVente - sumQtyDette} ${ruptureStock.unity}',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  Text('${sumPriceVente - prixAchat} FC',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.green[800])),
                ],
              ),
            ],
          ),
        )));
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        await ProductDatabase.instance.deleteAchat(ruptureStock.id!);

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${ruptureStock.type} vient d'être supprimé!"),
          backgroundColor: Colors.red[700],
        ));
      },
    );
  }
}
