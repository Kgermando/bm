import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class ListVenteScreen extends StatelessWidget {
  const ListVenteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Liste des ventes'),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.power_settings_new),
            label: Text(''),
          ),
        ],
      )),
      drawer: SideBarScreen(),
      body: Container(),
    );
  }

  Widget buildtile(VenteModel vente) {
    return Column(
      children: [
        ListTile(
          title: Text('${vente.categorie} > ${vente.sousCategorie}'),
          subtitle: Text('${vente.quantity} ${vente.nameProduct}'),
          trailing: Column(
            children: [
              Icon(Icons.money),
              Text('${vente.price} FC')
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
