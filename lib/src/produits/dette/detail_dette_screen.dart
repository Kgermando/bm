import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/produits/dette/add_dette_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailDetteScreen extends StatelessWidget {
  final DetteModel dette;
  const DetailDetteScreen({Key? key, required this.dette}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${dette.nameProduct}'),
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
            dettes()
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
          Text('${dette.categorie.toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(DateFormat("dd.MM.yy HH:mm").format(dette.date),
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
          Text(dette.sousCategorie,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          SizedBox(
            child: Container(
              child: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Text(dette.nameProduct,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36)),
        ],
      ),
    ));
  }

  Widget dettes() {
    double prix = double.parse(dette.price);
    double quantite = double.parse(dette.quantity);
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
              Text('${dette.quantity} ${dette.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${dette.price} FC',
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
              Text('1 ${dette.unity}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              Text('${prix / quantite} FC',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dette de ${dette.personne}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)
                ),
            ],
          ),
        ],
      ),
    ));
  }


  Widget editButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddDetteScreen(dette: dette),
          ));
        });
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        await ProductDatabase.instance.deleteDette(dette.id!);

        Navigator.of(context).pop();
        SnackBar(
          content: Text("${dette.nameProduct} vient d'être supprimé!"),
          backgroundColor: Colors.red[700],
        );
      },
    );
  }


}
