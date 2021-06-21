import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
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

  List<AchatModel> venteList = [];

  @override
  void initState() {
    super.initState();
    loadVente();
  }

  void loadVente() async {
    List<AchatModel>? ventes =
        await ProductDatabase.instance.getAllAchatsVente();
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
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: Text(''),
                ),
              ],
            ),
          )
        ],
      )),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            header(),
            headerTitle(),
            achattitle(),
            achats(),
            ventetitle(),
            ventes(),
            benficetitle(),
            benfices(),
            pertetitle(),
            pertes(),
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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(achat.nameProduct,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36)),
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
                      color: Colors.blueAccent)),
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
      child: Text(
        'VENTES',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }

  Widget ventes() {
    var venteCategorie = venteList.map((e) => e.categorie);
    var venteSousCategorie = venteList.map((e) => e.sousCategorie);
    var ventenameProduct = venteList.map((e) => e.nameProduct);
    var ventequantity = venteList.map((e) => e.quantity);
    var ventePrice = venteList.map((e) => e.price);

    print(venteCategorie);
    print(venteSousCategorie);
    print(ventenameProduct);
    print(ventequantity);
    print(ventePrice);

    double prix = double.parse(achat.price);
    double quantite = double.parse(achat.quantity);

    if (venteCategorie == achat.categorie &&
        venteSousCategorie == achat.sousCategorie &&
        ventenameProduct == achat.nameProduct) {
      print(ventequantity);
    }

    return Container(
      child: Container(),
    );
  }

  // void someFunction3() {
  //   var venteCategorie = venteList.map((e) => e.categorie);
  //   var venteSousCategorie = venteList.map((e) => e.sousCategorie);
  //   var ventenameProduct = venteList.map((e) => e.nameProduct);
  //   var ventequantity = venteList.map((e) => e.quantity);
  //   var ventePrice = venteList.map((e) => e.price);
  //   for (venteCategorie == achat.categorie; i < 10; i++) {
  //     if (i == 0) print(someFunction3); // OK
  //   }
  // }

  void venteOperation() {
    var venteCategorie = venteList.map((e) => e.categorie);
    var venteSousCategorie = venteList.map((e) => e.sousCategorie);
    var ventenameProduct = venteList.map((e) => e.nameProduct);
    var ventequantity = venteList.map((e) => e.quantity);
    var ventePrice = venteList.map((e) => e.price);

    double prix = double.parse(achat.price);
    double quantite = double.parse(achat.quantity);

    if (venteCategorie == achat.categorie &&
        venteSousCategorie == achat.sousCategorie &&
        ventenameProduct == achat.nameProduct) {
      print(ventequantity);
    }
  }

  Widget benficetitle() {
    return Card(
      child: Text(
        'BENEFICES',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }

  Widget benfices() {
    return Card();
  }

  Widget pertetitle() {
    return Card(
      child: Text(
        'PERTES',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }

  Widget pertes() {
    return Card();
  }
}
