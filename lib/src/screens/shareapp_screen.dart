import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Partagez l\'application'),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.power_settings_new),
            label: Text(''),
          ),
        ],
      )),
      drawer: SideBarScreen(),
    );
  }
}
