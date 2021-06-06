import 'package:e_management/src/produits/achats/aad_achat_screen.dart';
import 'package:e_management/src/produits/ventes/add_vente_screen.dart';
import 'package:e_management/src/produits/ventes/list_vente_screen.dart';
import 'package:e_management/src/screens/contact_screen.dart';
import 'package:e_management/src/screens/home_screen.dart';
import 'package:e_management/src/screens/shareapp_screen.dart';
import 'package:flutter/material.dart';

class SideBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("contact@eventdrc.com"),
            accountName: Text("Germain Kataku"),
            currentAccountPicture: CircleAvatar(
              child: Text("GK"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Acceuil"),
            onTap: () {
              print("Home Clicked");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Produits"),
            onTap: () {
                print("Produits Clicked");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list_sharp),
            title: Text("Liste des Ventes"),
            onTap: () {
                print("Ventes");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListVenteScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_photos),
            title: Text("Ajoutez votre vente"),
            onTap: () {
              print("Add Ventes");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddVenteScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_photos),
            title: Text("Ajoutez des produits"),
            onTap: () {
                print("Add produits");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAchatScreen())
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("Contactez-nous!"),
            onTap: () {
                print("Contact Clicked");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Partagez!"),
            onTap: () {
              print("Share Clicked");
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShareAppScreen())
              );
            },
          ),
        ],
      ),
    );
  }
}