import 'dart:html';

import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

class AddAchatScreen extends StatefulWidget {
  final AchatModel? achat;

  const AddAchatScreen({Key? key, this.achat}) : super(key: key);

  @override
  _AddAchatScreenState createState() => _AddAchatScreenState();
}

class _AddAchatScreenState extends State<AddAchatScreen> {
  final formKey = GlobalKey<FormState>();

  final categorieController = TextEditingController();
  final sousCategorieController = TextEditingController();
  final nameProductController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  
  @override
  void dispose() {
    categorieController.dispose();
    sousCategorieController.dispose();
    nameProductController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  final String categorieValue = 'Selectionnez la categorie';
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
      // drawer: SideBarScreen(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
              labelText: 'Categorie',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              // contentPadding: EdgeInsets.all(5.0),
            ),
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 28,
              elevation: 16,
              isDense: true,
              isExpanded: true,
              style: const TextStyle(color: Colors.deepPurple),
              items: _categorie.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                print(value);
                categorie = value!;
              },
              value: categorieValue,
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
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Sous Categorie',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              // contentPadding: EdgeInsets.all(5.0),
            ),
            child: DropdownButton<String>(
              value: sousCategorieValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 28,
              elevation: 16,
              isDense: true,
              isExpanded: true,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                print(value);
                sousCategorie = value!;
              },
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
        controller: nameProductController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Nom du produit vendu',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (String? value) {
          if(value!.isEmpty) {
            return 'Remplissez le nom du produit';
          }
          return null;
        },
        onSaved: (String? value) {
          print(value);
          nameProduct = value!;
        },
      ),
    );
  }

  Widget quantityField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: quantityController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Quantités des produits vendus',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (String? value) {
          if(value!.isEmpty) {
            return 'Remplissez la quantité';
          }
          return null;
        },
        onSaved: (String? value) {
          // print(value);
          quantity = value!;
        },
      ),
    );
  }

  Widget priceField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Total d\'argents',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Mettez le montant total d\'achat';
          }
          return null;
        },
      ),
    );
  }

  Widget saveForm() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          AchatModel achat = AchatModel(
            categorie: categorieValue, 
            sousCategorie: sousCategorie, 
            nameProduct: nameProduct, 
            quantity: quantityController.value,

            quantityController.value.text,
            priceController.value.text,
            date: DateTime.now()
          );
          ProductDatabase.instance.insertAchat(achat);
          Navigator.pop(context);
        }
      },
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
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
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }


  // Future updateNote() async {
  //   final achat = widget.achat!.copy(
  //     categorie: categorieController,
  //     date: DateTime.now(),
  //   );

  //   await ProductDatabase.instance.updataAchat(achat);
  // }

  // Future addNote() async {
  //   final achat = AchatModel(
  //     categorie: title,
  //     sousCategorie: true,
  //     nameProduct: number,
  //     quantity: description,
  //     price: ,
  //     date: DateTime.now(),
  //   );

  //   await ProductDatabase.instance.insertAchat(achat);
  // }
}
