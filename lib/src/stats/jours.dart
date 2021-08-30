import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class JourStats extends StatefulWidget {
  const JourStats({Key? key}) : super(key: key);

  @override
  _JourStatsState createState() => _JourStatsState();
}

class _JourStatsState extends State<JourStats> {
  List<VenteModel> venteList = [];
  List<AchatModel> achatList = [];

  @override
  void initState() {
    super.initState();
    loadVente();
    loadAchat();
  }

  @override
  void dispose() {
    loadVente();
    loadAchat();
    super.dispose();
  }

  void loadVente() async {
    List<VenteModel>? ventes =
        await ProductDatabase.instance.getAllVenteByDay();
    if (this.mounted) {
      setState(() {
        venteList = ventes;
      });
    }
  }

  void loadAchat() async {
    List<AchatModel>? achats = await ProductDatabase.instance.getAllAchatDay();
    if (this.mounted) {
      setState(() {
        achatList = achats;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var achatData = achatList
      .map((e) => {e.categorie, e.sousCategorie, e.type, e.identifiant});

    var venteData = venteList
      .map((e) => {e.categorie, e.sousCategorie, e.type, e.identifiant});



    print('venteData $venteData');


    bool dataCompared = achatData == venteData;
    print('dataCompared $dataCompared');

    int vtotal = 0;
    venteList.forEach((element) {
      if (dataCompared) {
        var dataPriceVente = venteList.map((e) => int.parse(e.price)).toList();
        dataPriceVente.forEach((data) => vtotal += data );
      } else {
        var dataPriceVente = venteList.map((e) => int.parse(e.price)).toList();
        dataPriceVente.forEach((data) => vtotal += data);
      }
    });

    print(vtotal);

  
    // Ventes
    var dataPriceVente = venteList.map((e) => int.parse(e.price)).toList();
    int sumVente = 0;
    dataPriceVente.forEach((data) => sumVente += data);

    // Achats
    var dataPriceAchat = achatList.map((e) => int.parse(e.price)).toList();
    int sumAchat = 0;
    dataPriceAchat.forEach((data) => sumAchat += data);
    var revenues = sumVente - sumAchat;

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
                    child: Text('Total ventes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0)),
                  ),
                  Container(
                    child: Text('$sumVente FC',
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
                    child: Text('$revenues FC',
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
                title: ChartTitle(text: 'Ventes par jour'),
                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<VenteModel, String>>[
                  LineSeries<VenteModel, String>(
                      dataSource: venteList,
                      xValueMapper: (VenteModel vente, _) =>
                          (DateFormat("HH:mm").format(vente.date).toString()),
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
                    xValueMapper: (VenteModel vente, _) => vente.sousCategorie,
                    yValueMapper: (VenteModel vente, _) =>
                        int.parse(vente.price),
                    dataLabelMapper: (VenteModel vente, _) =>
                        vente.sousCategorie,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ]))
        ],
      ),
    );
  }
}
