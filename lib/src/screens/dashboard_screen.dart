import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
            Text('E-Management'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )),
        drawer: SideBarScreen(),
        body: VenteDashboardScreen());
  }
}

class VenteDashboardScreen extends StatefulWidget {
  const VenteDashboardScreen({Key? key}) : super(key: key);

  @override
  _VenteDashboardScreenState createState() => _VenteDashboardScreenState();
}

class _VenteDashboardScreenState extends State<VenteDashboardScreen> {
  List<VenteModel> venteList = [];

  @override
  void initState() {
    super.initState();
    loadVente();
  }

  void loadVente() async {
    List<VenteModel>? ventes = await ProductDatabase.instance.getAllVenteByDate();
    setState(() {
      venteList = ventes;
      // print(venteList);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
    var dataPrice = venteList.map((e) => double.parse(e.price)).toList();
    // print(dataPrice);
    double sum = 0;
    dataPrice.forEach((data) => sum += data);

    return Container(
      height: 300.0,
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Text('Ventes journalières',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0)),
              ),
              Container(
                child: Text('$sum FC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0)),
              ),
              Container(
                // width: 300.0,
                height: 200.0,
                child: Sparkline(
                  data: dataPrice,
                  lineColor: Colors.purple,
                  lineWidth: 6.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
