import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/produits/ventes/add_vente_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class VenteDetailScreen extends StatelessWidget {
  const VenteDetailScreen({Key? key, required this.vente}) : super(key: key);
  final VenteModel vente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${vente.nameProduct}'),
            Container(
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.print),
                    label: Text(''),
                  ),
                  editButton(context),
                  deleteButton(context)
                ],
              ),
            )
          ],
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            header(),
            headerTitle(),
            // ventetitle(),
            ventes()
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
          Text('${vente.categorie.toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(DateFormat("dd.MM.yy HH:mm").format(vente.date),
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
          Text(vente.sousCategorie,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(vente.nameProduct,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36)),
        ],
      ),
    ));
  }

  // Widget ventetitle() {
  //   return Card(
  //     child: Text(
  //       'Ventes',
  //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
  //     ),
  //   );
  // }

  Widget ventes() {
    double prix = double.parse(vente.price);
    double quantite = double.parse(vente.quantity);
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
              Text('${vente.quantity} ${vente.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${vente.price} FC',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.blueGrey[900])),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1 ${vente.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${prix / quantite} FC',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            ],
          ),
        ],
      ),
    ));
  }

  deleteVente() {
    return ElevatedButton(
      onPressed: venteData,
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  void venteData() async {
    final ventes = vente.id;

    await ProductDatabase.instance.deleteVente(ventes!);
    SnackBar(
      content: Text("${vente.nameProduct} vient d'être supprimé!"),
      backgroundColor: Colors.red[700],
    );

  }


    Widget editButton(BuildContext context) {
      return IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddVenteScreen(vente: vente),
        ));

      });
    }

    Widget deleteButton(BuildContext context) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await ProductDatabase.instance.deleteVente(vente.id!);

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${vente.nameProduct} vient d'être supprimé!"),
          backgroundColor: Colors.red[700],
        ));
        },
      );
    }

}
