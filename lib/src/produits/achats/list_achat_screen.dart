import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/pdf/pdf_api.dart';
import 'package:e_management/src/pdf/pdf_product_api.dart';
import 'package:e_management/src/produits/achats/add_achat_form.dart';
import 'package:e_management/src/produits/achats/detail_achat_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:flutter/material.dart';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';

class ListAchatScreen extends StatefulWidget {
  @override
  _ListAchatScreenState createState() => _ListAchatScreenState();
}

class _ListAchatScreenState extends State<ListAchatScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<AchatModel> achatsPdfList = [];

  Future<void> getData() async {
    List<AchatModel>? achatpdfList =
        await ProductDatabase.instance.getAllAchats();
    setState(() {
      ProductDatabase.instance.getAllAchats();
      achatsPdfList = achatpdfList;
    });
  }
//  printPdf(),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des achats'),
        actions: [
          printPdf(),
          PopupMenuButton<MenuItem>(
            onSelected: (item) => MenuOptions().onSelected(context, item),
            itemBuilder: (context) => [
              ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
              PopupMenuDivider(),
              ...MenuItems.itemsSecond.map(MenuOptions().buildItem).toList(),
            ],
          )
        ],
      ),
      drawer: SideBarScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAchatForm()));
        },
        tooltip: 'Ajoutez achats',
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<AchatModel>>(
          future: ProductDatabase.instance.getAllAchats(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AchatModel>> snapshot) {
            if (snapshot.hasData) {
              List<AchatModel>? achats = snapshot.data;
              return RefreshIndicator(
                onRefresh: getData,
                child: ListView.builder(
                    itemCount: achats!.length,
                    itemBuilder: (context, index) {
                      final achat = achats[index];
                      return AchatItemWidget(achat: achat);
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
        }
      )
    ); 
  }


  Widget printPdf() {
    return ElevatedButton.icon(
        icon: Icon(Icons.print),
        label: Text(''),
        onPressed: () async {
          // final achatPdf = AchatModel(
          //     categorie: '',
          //     sousCategorie: '',
          //     nameProduct: '',
          //     quantity: '',
          //     unity: '',
          //     price: '',
          //     date: DateTime.now(),
          // );
          final pdfFile = await PdfProductApi.generate();

          PdfApi.openFile(pdfFile);
        });
  }
}

class AchatItemWidget extends StatefulWidget {
  const AchatItemWidget({Key? key, required this.achat}) : super(key: key);
  final AchatModel achat;

  @override
  _AchatItemWidgetState createState() => _AchatItemWidgetState(this.achat);
}

class _AchatItemWidgetState extends State<AchatItemWidget> {
  final AchatModel achat;

  _AchatItemWidgetState(this.achat);

  List<VenteModel> venteList = [];

  @override
  void initState() {
    super.initState();
    loadVente();
  }

  void loadVente() async {
    List<VenteModel>? ventes = await ProductDatabase.instance.getAllVente();
    setState(() {
      venteList = ventes;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter
    var filter = venteList.where((element) =>
        achat.categorie == element.categorie &&
        achat.sousCategorie == element.sousCategorie &&
        achat.type == element.type && 
        achat.identifiant == element.identifiant);

    // Quantités
    var filterQty = filter.map((e) => double.parse(e.quantity));
    double sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);

    double achatQty = double.parse(achat.quantity);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AchatDetailScreen(achat: achat)));
      },
      child: Card(
        color: getPriorityColor(),
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
                    Icons.shopping_bag_sharp,
                    size: 40.0,
                    color: Color(0xFF6200EE),
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
                            Text("${achat.type} ${achat.identifiant}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis
                                ),
                            ),
                          ],
                        ),
                      ),
                      Text('${achat.categorie} -> ${achat.sousCategorie}',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
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
                    child: Text('${achat.price} FC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF6200EE),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('Stock: ${achatQty - sumQty} ${achat.unity}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Returns the priority color
  getPriorityColor() {
    // Filter
    var filter = venteList.where((element) =>
        achat.categorie == element.categorie &&
        achat.sousCategorie == element.sousCategorie &&
        achat.type == element.type &&
        achat.type == element.type
      );

    // Quantités
    var filterQty = filter.map((e) => double.parse(e.quantity));
    double sumQty = 0;
    filterQty.forEach((qty) => sumQty += qty);

    double qty = double.parse(achat.quantity);

    double qtyVente = sumQty * 100 / qty;

    // print(qtyVente);

    if(qtyVente <= 30.0) {
      return Colors.green[200];
    } else if (qtyVente <= 50.0) {
      return Colors.orange[300];
    } else if (qtyVente <= 80.0) {
      return Colors.orange[700];
    } else if (qtyVente <= 100.0) {
      return Colors.red[800];
    }
  }
}
