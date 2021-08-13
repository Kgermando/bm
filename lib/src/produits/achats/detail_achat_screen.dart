import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/produits/achats/add_achat_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AchatDetailScreen extends StatefulWidget {
  final AchatModel achat;
  const AchatDetailScreen({Key? key, required this.achat}) : super(key: key);

  @override
  _AchatDetailScreenState createState() => _AchatDetailScreenState(this.achat);
}

class _AchatDetailScreenState extends State<AchatDetailScreen> {
  final AchatModel achat;

  _AchatDetailScreenState(this.achat);

  List<VenteModel> venteList = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadVente();
  }

  void loadVente() async {
    List<VenteModel>? ventes = await ProductDatabase.instance.getAllVente();
    setState(() {
      venteList = ventes;
      // print(venteList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${achat.categorie}'),
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
            context,
            MaterialPageRoute(
                builder: (context) => AddAchatForm()
              )
            );
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
              achattitle(),
              achats(),
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
          Text('${achat.categorie.toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(DateFormat("dd.MM.yy HH:mm").format(achat.date),
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
          Text(achat.sousCategorie,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(achat.type,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            overflow: TextOverflow.ellipsis
          ),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(
            achat.identifiant,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            overflow: TextOverflow.ellipsis
          ),
        ],
      ),
    ));
  }

  Widget achattitle() {
    return Card(
      child: Text(
        'ACHATS',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }

  Widget achats() {
    double prix = double.parse(achat.price);
    double quantite = double.parse(achat.quantity);
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
              Text('${achat.quantity} ${achat.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${achat.price} FC',
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
              Text('1 ${achat.unity}',
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
        achat.categorie == element.categorie &&
        achat.sousCategorie == element.sousCategorie &&
        achat.type == element.type && 
        achat.identifiant == element.identifiant
      );
    // print('$filter filter data');

    // Quantités
    var filterQty = filter.map((e) => int.parse(e.quantity));
    // print('$filterQty filter qty');
    int sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);
    // print('$sumQty quantit"s des produits vendus');

    // Prix
    var filterPrice = filter.map((e) => int.parse(e.price));
    // print('$filterPrice filter price');
    int sumPrice = 0;
    filterPrice.forEach((price) => sumPrice += price);
    // print('$sumPrice sommes des produits vendus');

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
                Text('${achat.unity} vendus',
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
                Text('$sumQty ${achat.unity}',
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
    var filter = venteList.where((element) =>
        achat.categorie == element.categorie &&
        achat.sousCategorie == element.sousCategorie &&
        achat.type == element.type &&
        achat.identifiant == element.identifiant
      );

    // Quantités
    var filterQty = filter.map((e) => int.parse(e.quantity));
    int sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);

    // Prix
    var filterPrice = filter.map((e) => int.parse(e.price));
    int sumPrice = 0;
    filterPrice.forEach((price) => sumPrice += price);

    int qtyAchat = int.parse(achat.quantity);
    int prixAchat = int.parse(achat.price);

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
              Text('Restes des ${achat.unity}',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              Text('Revenues',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    )
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${qtyAchat - sumQty} ${achat.unity}',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)
              ),
              Text('${sumPrice - prixAchat} FC',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.green[800]
                    )
              ),
            ],
          ),
          
        ],
      ),
    )));
  }


  Widget editButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddAchatForm(),
          ));
        });
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        await ProductDatabase.instance.deleteAchat(achat.id!);

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${achat.sousCategorie} vient d'être supprimé!"),
          backgroundColor: Colors.red[700],
        ));
      },
    );
  }
}
