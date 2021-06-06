import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class AddAchatScreen extends StatefulWidget {
  const AddAchatScreen({ Key? key }) : super(key: key);

  @override
  _AddAchatScreenState createState() => _AddAchatScreenState();
}

class _AddAchatScreenState extends State<AddAchatScreen> {
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
}