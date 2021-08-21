import 'package:e_management/services/user_preferences.dart';
import 'package:e_management/src/auth/profile_screen.dart';
import 'package:e_management/src/models/user_model.dart';
import 'package:e_management/src/produits/achats/menu_achats.dart';
import 'package:e_management/src/produits/dette/list_dette_screen.dart';
import 'package:e_management/src/produits/ventes/list_vente_screen.dart';
import 'package:e_management/src/screens/contact_screen.dart';
import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class SideBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<User?>(
          future: UserPreferences.read(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? userInfo = snapshot.data;
              if (userInfo != null) {
                var userData = userInfo;

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName:
                          Text('${userInfo.firstName} ${userInfo.lastName}'),
                      accountEmail: Text(
                        userData.telephone,
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        ),
                        radius: 100.0
                      ),
                      onDetailsPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text("Dashboard"),
                      onTap: () {
                        print("Dashboard Clicked");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shop),
                      title: Text("Ventes"),
                      onTap: () {
                        print("Ventes");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListVenteScreen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag_sharp),
                      title: Text("Achats"),
                      onTap: () {
                        print("Achats Clicked");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuAchat()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.money_off_csred_sharp),
                      title: Text("Dettes"),
                      onTap: () {
                        print("List Dettes Clicked");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListDetteScreen()));
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.add_shopping_cart_sharp),
                    //   title: Text("Ajoutez votre vente"),
                    //   onTap: () {
                    //     print("Add Ventes");
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AddVenteForm()));
                    //   },
                    // ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.contact_page),
                      title: Text("Contactez-nous!"),
                      onTap: () {
                        print("Contact Clicked");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactScreen()));
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.settings),
                    //   title: Text("Paramètres"),
                    //   onTap: () {
                    //     print("Settings Clicked");
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => SettingsScreen()));
                    //   },
                    // ),
                  ],
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
