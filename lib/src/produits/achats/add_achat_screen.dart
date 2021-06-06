import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class AddAchatScreen extends StatefulWidget {
  const AddAchatScreen({Key? key}) : super(key: key);

  @override
  _AddAchatScreenState createState() => _AddAchatScreenState();
}

class _AddAchatScreenState extends State<AddAchatScreen> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10));
  final String categorieValue =  'Selectionnez la categorie';
  static var _categorie = <String>[
    'Selectionnez la categorie',
    'Pain',
    'Lait',
    'Boisson',
    'Stylo',
    'Cahier',
    'Huile',
    'Farine',
    'Biscuit'
  ];

  final String sousCategorieValue = 'Selectionnez le sous categorie';
  static var _sousCategorie = [
    'Selectionnez le sous categorie',
    'Baguette',
    'Gateau',
    'Kanga journee',
    'Zest',
    'Oragina',
    'Bic Bic',
    'Speciale',
    'Salte',
    'Rouge',
    'Fromat',
    'Fraine de manioc'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Ajoutez vos achats'),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.power_settings_new),
            label: Text(''),
          ),
        ],
      )),
      drawer: SideBarScreen(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                categorieField(),
                sousCategorieFIeld(),
                nameProductField(),
                quantityField(),
                priceField(),
                Row(
                  children: [
                    Expanded(
                      child: saveForm(),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: deleteForm(),
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget categorieField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          // Text("Categorie"),
          InputDecorator(
            decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                contentPadding: EdgeInsets.all(5.0),
              ),
            child: DropdownButton<String>(
              value: categorieValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              isDense: true,
              isExpanded: true,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? newValue) {},
              items: _categorie.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget sousCategorieFIeld() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          // Text("Sous Categorie"),
          InputDecorator(
            decoration: InputDecoration(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.all(5.0),
            ),
            child: DropdownButton<String>(
              value: sousCategorieValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              isDense: true,
              isExpanded: true,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? newValue) {},
              items:
                _sousCategorie.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget nameProductField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Nom du produit vendu',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Widget quantityField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Quantités des produits vendus',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Widget priceField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Total d\'argents',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Widget saveForm() {
    return ElevatedButton(
      onPressed: () {
        setState(() {});
      },
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: style,
    );
  }

  Widget deleteForm() {
    return ElevatedButton(
      onPressed: () {
        setState(() {});
      },
      child: Text(
        'Supprimer',
        textScaleFactor: 1.5,
      ),
      style: style,
    );
  }
}
