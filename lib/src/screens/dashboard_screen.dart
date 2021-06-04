import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Dashboard'),
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