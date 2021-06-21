import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class StatistiqueWiddget extends StatefulWidget {
  const StatistiqueWiddget({ Key? key }) : super(key: key);

  @override
  _StatistiqueWiddgetState createState() => _StatistiqueWiddgetState();
}

class _StatistiqueWiddgetState extends State<StatistiqueWiddget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Statistiques'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )
      ),
      drawer: SideBarScreen(),
      body: Container(
        padding: EdgeInsets.all(8.0),
        
      ),
    );
  }
}