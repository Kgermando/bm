import 'package:e_management/src/produits/achats/add_achat_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class ListAchatScreen extends StatefulWidget {
  const ListAchatScreen({Key? key}) : super(key: key);

  @override
  _ListAchatScreenState createState() => _ListAchatScreenState();
}

class _ListAchatScreenState extends State<ListAchatScreen> {
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
      )),
      drawer: SideBarScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAchatScreen())
            );
        },
        tooltip: 'Ajoutez achats',
        child: Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}
