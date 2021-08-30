import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/rupture_stock.dart';
import 'package:e_management/src/produits/achats/detail_rupture_stock.dart';
import 'package:e_management/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RuptureStock extends StatefulWidget {
  const RuptureStock({Key? key}) : super(key: key);

  @override
  _RuptureStockState createState() => _RuptureStockState();
}

class _RuptureStockState extends State<RuptureStock> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<RuptureStockModel> ruptureStockList = [];

  Future<void> getData() async {
    List<RuptureStockModel>? rupturestockData =
        await ProductDatabase.instance.getAllRuptureStock();

    setState(() {
      ruptureStockList = rupturestockData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RuptureStockModel>>(
        future: ProductDatabase.instance.getAllRuptureStock(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RuptureStockModel>> snapshot) {
          if (snapshot.hasData) {
            List<RuptureStockModel>? ruptureStocks = snapshot.data;
            return RefreshIndicator(
              onRefresh: getData,
              child: ListView.builder(
                  itemCount: ruptureStocks!.length,
                  itemBuilder: (context, index) {
                    final ruptureStock = ruptureStocks[index];
                    return RuptureStockWidget(ruptureStock: ruptureStock);
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }


}

class RuptureStockWidget extends StatefulWidget {
  const RuptureStockWidget({Key? key, required this.ruptureStock})
      : super(key: key);
  final RuptureStockModel ruptureStock;

  @override
  _RuptureStockWidgetState createState() =>
      _RuptureStockWidgetState(this.ruptureStock);
}

class _RuptureStockWidgetState extends State<RuptureStockWidget> {
  final RuptureStockModel ruptureStock;

  _RuptureStockWidgetState(this.ruptureStock);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailRuptureStock(ruptureStock: ruptureStock)));
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 40.0,
                    color: MyThemes.primary,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              "${ruptureStock.sousCategorie} ${ruptureStock.type} ${ruptureStock.identifiant}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      Text('${ruptureStock.categorie}',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${ruptureStock.price} FC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: MyThemes.primary,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                        'Achat le ${DateFormat("dd.MM.yy").format(ruptureStock.date)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 10)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
