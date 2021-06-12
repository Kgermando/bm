import 'package:flutter/material.dart';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/produits/achats/add_achat_screen.dart';
import 'package:e_management/src/produits/achats/detail_achat_screen.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/widgets/achat_card_widget.dart';

class ListAchatScreen extends StatefulWidget {
  @override
  _ListAchatScreenState createState() => _ListAchatScreenState();
}

class _ListAchatScreenState extends State<ListAchatScreen> {
  late List<AchatModel> achats = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshAchats();
  }

  @override
  void dispose() {
    ProductDatabase.instance.closaAchat();
    super.dispose();
  }

  Future refreshAchats() async {
    // setState(() => isLoading = true);

    this.achats = await ProductDatabase.instance.getAllAchats();
    print(this.achats);

    // setState(() => isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Liste des achats'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )
      ),
      drawer: SideBarScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAchatScreen()));
        },
        tooltip: 'Ajoutez achats',
        child: Icon(Icons.add),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : achats.isEmpty
                ? Text(
                    'Pas d\articles!',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : buildAchats(),
      ),
    );
  }

  Widget buildAchats() {
    return ListView.builder(
      itemCount: achats.length,
      itemBuilder: (context, index) {
        final achat = achats[index];

        return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AchatDetailScreen(achatId: achat.id!),
              ));

              refreshAchats();
            },
            child: AchatCardWidget(achat: achat, index: index));
      },
    );
  }
}
