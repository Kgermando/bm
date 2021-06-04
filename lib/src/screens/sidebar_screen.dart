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
              Navigator.pushNamed(context,'/');
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Produits"),
            onTap: () {
                print("Produits Clicked");
              Navigator.pushNamed(context,'/produits');
            },
          ),
          ListTile(
            leading: Icon(Icons.list_sharp),
            title: Text("Liste des Ventes"),
            onTap: () {
                print("Ventes");
              Navigator.pushNamed(context,'/ventes');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_photos),
            title: Text("Ajoutez votre vente"),
            onTap: () {
                print("Add Ventes");
              Navigator.pushNamed(context,'/addventes');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_photos),
            title: Text("Ajoutez des produits"),
            onTap: () {
                print("Add produits");
              Navigator.pushNamed(context,'/addproduits');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_comment_rounded),
            title: Text("Ajoutez une Categories"),
            onTap: () {
                print("Add Categories");
              Navigator.pushNamed(context,'/addcategory');
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("Contactez-nous"),
            onTap: () {
                print("Contact Clicked");
              Navigator.pushNamed(context,'/contact');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share with Friends"),
            onTap: () {
                print("Share Clicked");
              Navigator.pushNamed(context,'/shareapps');
            },
          ),
        ],
      ),
    );
  }
}