import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class AddVenteScreen extends StatelessWidget {
  const AddVenteScreen({Key? key}) : super(key: key);

  final String categorieValue = 'Boisson';
  static var _categorie = <String>[
    'Pain',
    'Lait',
    'Boisson',
    'Stylo',
    'Cahier',
    'Huile',
    'Farine',
    'Biscuit'
  ];

  final String sousCategorieValue = 'Zest';
  static var _sousCategorie = [
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
            Text('Ajoutez la vente'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )
      ),
      drawer: SideBarScreen(),
      body: Container(),
    );
  }

  Widget categorieField() {
    return DropdownButton<String>(
      value: categorieValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {},
      items: _categorie.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget sousCategorieFIeld() {
    return DropdownButton<String>(
      value: sousCategorieValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {},
      items: _sousCategorie.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget nameProductField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nom du produit vendu',
        labelStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  Widget quantityField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Quantités des produits vendus',
        labelStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  Widget priceField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Total d\'argents',
        labelStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  Widget saveForm() {
    return Container();
  }
}
