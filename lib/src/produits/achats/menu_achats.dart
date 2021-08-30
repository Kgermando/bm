import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/pdf/pdf_api.dart';
import 'package:e_management/src/pdf/pdf_product_api.dart';
import 'package:e_management/src/produits/achats/add_achat_form.dart';
import 'package:e_management/src/produits/achats/list_achat_screen.dart';
import 'package:e_management/src/produits/achats/list_rupture_stock.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:flutter/material.dart';

class MenuAchat extends StatefulWidget {
  const MenuAchat({Key? key}) : super(key: key);

  @override
  _MenuAchatState createState() => _MenuAchatState();
}

class _MenuAchatState extends State<MenuAchat>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Achats'), // ${controller.index + 1}
            actions: [
              printPdf(),
              PopupMenuButton<MenuItem>(
                onSelected: (item) => MenuOptions().onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
                  PopupMenuDivider(),
                  ...MenuItems.itemsSecond
                      .map(MenuOptions().buildItem)
                      .toList(),
                ],
              )
            ],
            bottom: TabBar(
              controller: controller,
              // indicatorWeight: 10,
              tabs: [
                Tab(text: 'Stocks', icon: Icon(Icons.shopping_bag_sharp)),
                Tab(
                    text: 'Rupture de stocks',
                    icon: Icon(Icons.shopping_bag_outlined))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAchatForm()));
            },
            tooltip: 'Ajoutez Achat',
            child: Icon(Icons.add),
          ),
          drawer: SideBarScreen(),
          body: TabBarView(
            controller: controller,
            children: [ListAchatScreen(), RuptureStock()],
          )),
    );
  }

  Widget printPdf() {
    return ElevatedButton.icon(
        icon: Icon(Icons.print),
        label: Text(''),
        onPressed: () async {
          final pdfFile = await PdfProductApi.generate();

          PdfApi.openFile(pdfFile);
        });
  }
}
