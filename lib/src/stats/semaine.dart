import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SemaineStats extends StatefulWidget {
  const SemaineStats({Key? key}) : super(key: key);

  @override
  _SemaineStatsState createState() => _SemaineStatsState();
}

class _SemaineStatsState extends State<SemaineStats> {
  List<VenteModel> venteList = [];
  List<AchatModel> achatList = [];

  @override
  void initState() {
    super.initState();
    loadVente();
    loadAchat();
  }

  void loadVente() async {
    List<VenteModel>? ventes =
        await ProductDatabase.instance.getAllVenteByWeek();
    setState(() {
      venteList = ventes;
    });
  }

  void loadAchat() async {
    List<AchatModel>? achats = await ProductDatabase.instance.getAllAchatWeek();
    setState(() {
      achatList = achats;
    });
  }
  
  
  List<SalesData> data = [
    SalesData('Lun', 35),
    SalesData('Mar', 28),
    SalesData('Mer', 34),
    SalesData('Jeu', 32),
    SalesData('Ven', 150),
    SalesData('Sam', 200),
    SalesData('Dim', 105)
  ];

  @override
  Widget build(BuildContext context) {
    var dataPrice = venteList.map((e) => int.parse(e.price)).toList();
    int sum = 0;
    dataPrice.forEach((data) => sum += data);

    var dataPriceAchat = achatList.map((e) => int.parse(e.price)).toList();
    int sumAchat = 0;
    dataPriceAchat.forEach((data) => sumAchat += data);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  child: Text('Total ventes par mois',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0)),
                ),
                Container(
                  child: Text('$sum FC',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                ),
              ],
            ),
            // SizedBox(width: 20.0,),
            Column(
              children: [
                Container(
                  child: Text('Revenus',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.green)),
                ),
                Container(
                  child: Text('${sumAchat - sum} FC',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.green)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Ventes par semaine'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<VenteModel, String>>[
                LineSeries<VenteModel, String>(
                    dataSource: venteList,
                    xValueMapper: (VenteModel vente, _) =>
                        (DateFormat("dd/MM").format(vente.date).toString()),
                    yValueMapper: (VenteModel vente, _) =>
                        int.parse(vente.price),
                    name: 'Ventes',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
        ),
        Expanded(
          child: SfCircularChart(
          title: ChartTitle(text: 'Ventes par marchandise'),
          legend: Legend(isVisible: true),
          series: <PieSeries<VenteModel, String>>[
            PieSeries<VenteModel, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: venteList,
              xValueMapper: (VenteModel vente, _) => vente.categorie,
              yValueMapper: (VenteModel vente, _) => int.parse(vente.price),
              dataLabelMapper: (VenteModel vente, _) => vente.categorie,
              dataLabelSettings: DataLabelSettings(isVisible: true)),
          ]
          )
        )
      ]),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
