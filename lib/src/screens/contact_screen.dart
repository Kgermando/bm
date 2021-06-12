import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Contactez nous!'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )
      ),
      drawer: SideBarScreen(),
    );
  }
}