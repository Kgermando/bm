import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/drompdown_list/dropdown_categorie.dart';
import 'package:e_management/src/drompdown_list/dropdown_identifiant.dart';
import 'package:e_management/src/drompdown_list/dropdown_sous_cat.dart';
import 'package:e_management/src/drompdown_list/dropdown_type.dart';
import 'package:e_management/src/drompdown_list/dropdown_unity.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:flutter/material.dart';

class AddAchatForm extends StatefulWidget {
  const AddAchatForm({Key? key}) : super(key: key);

  @override
  _AddAchatFormState createState() => _AddAchatFormState();
}

class _AddAchatFormState extends State<AddAchatForm> {
  final _form = GlobalKey<FormState>();

  // Categorie
  final List<String> categories = DropdownCategorie().categorie;

  // SousCategorie
  final List<String> laitsCategorie =
      DropdownSousCategorie().laitsSousCategorie;
  final List<String> alcoolCategorie =
      DropdownSousCategorie().alcoolSousCategorie;
  final List<String> boissonsCategorie =
      DropdownSousCategorie().boissonsSousCategorie;
  final List<String> bieresCategorie =
      DropdownSousCategorie().bieresSousCategorie;
  final List<String> fournituresCategorie =
      DropdownSousCategorie().fournituresSousCategorie;
  final List<String> huilesVegetaleCategorie =
      DropdownSousCategorie().huilesVegetaleSousCategorie;
  final List<String> serialCategorie =
      DropdownSousCategorie().serialSousCategorie;
  final List<String> biscuitsCategorie =
      DropdownSousCategorie().biscuitsSousCategorie;
  final List<String> sucresCategorie =
      DropdownSousCategorie().sucresSousCategorie;
  final List<String> selsCategorie = DropdownSousCategorie().selsSousCategorie;
  final List<String> diversCategorie =
      DropdownSousCategorie().diversSousCategorie;
  final List<String> autresCategorie =
      DropdownSousCategorie().autresSousCategorie;
  final List<String> laitBeauteCategorie =
      DropdownSousCategorie().laitBeauteSousCategorie;
  final List<String> hygienesCategorie =
      DropdownSousCategorie().hygienesSousCategorie;
  final List<String> vinCategorie = DropdownSousCategorie().vinSousCategorie;

  // Type
  final List<String> laitTypeCategorie = DropdownType().laitType;

  // Identifiant
  final List<String> laitIdentifiant = DropdownIdentifiant().laitIdentifiant;

  // Unités
  final List<String> unites = DropdownUnity().unites;
  final List<String> unitesLait = DropdownUnity().unitesLait;

  List<String> achatSousCat = [];
  List<String> achatType = [];
  List<String> achatIdentifiant = [];
  List<String> achatUnity = [];

  String? categorie;
  String? sousCategorie;
  String? type;
  String? identifiant;
  String? quantity;
  String? unity;
  String? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouveau article"),
      ),
      body: SingleChildScrollView(
        key: _form,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              textField(),
              categorieField(),
              sousCategorieField(),
              typeField(),
              identifiantField(),
              Row(
                children: [
                  Expanded(
                    child: quantityField(),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: unityField(),
                  )
                ],
              ),
              priceField(),
              saveForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget textField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Ajoutez votre achat ici",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget categorieField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Categorie',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        // hint: Text('Categorie'),
        value: categorie,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        items: categories.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          if (produit == 'Laits') {
            achatSousCat = laitsCategorie;
            achatType = laitTypeCategorie;
            achatIdentifiant = laitIdentifiant;
            achatUnity = unitesLait;
          } else if (produit == 'Boissons') {
            achatSousCat = boissonsCategorie;
            achatUnity = unites;
          } else if (produit == 'Bières') {
            achatSousCat = bieresCategorie;
            achatUnity = unites;
          } else if (produit == 'Fournitures') {
            achatSousCat = fournituresCategorie;
            achatUnity = unites;
          } else if (produit == 'Huiles végétales') {
            achatSousCat = huilesVegetaleCategorie;
            achatUnity = unites;
          } else if (produit == 'Serial') {
            achatSousCat = serialCategorie;
            achatUnity = unites;
          } else if (produit == 'Biscuits') {
            achatSousCat = biscuitsCategorie;
            achatUnity = unites;
          } else if (produit == 'Sucres') {
            achatSousCat = sucresCategorie;
            achatUnity = unites;
          } else if (produit == 'Sels') {
            achatSousCat = selsCategorie;
            achatUnity = unites;
          } else if (produit == 'Laits de beautés') {
            achatSousCat = laitBeauteCategorie;
            achatUnity = unites;
          } else if (produit == 'Divers') {
            achatSousCat = diversCategorie;
            achatUnity = unites;
          } else if (produit == 'Hygiènes') {
            achatSousCat = hygienesCategorie;
            achatUnity = unites;
          } else if (produit == 'Vin') {
            achatSousCat = vinCategorie;
            achatUnity = unites;
          } else if (produit == 'Autres') {
            achatSousCat = autresCategorie;
            achatUnity = unites;
          } else {
            achatSousCat = [];
            achatType = [];
            achatIdentifiant = [];
            achatUnity = [];
          }
          setState(() {
            unity = null;
            identifiant = null;
            type = null;
            sousCategorie = null;
            categorie = produit;
          });
        },
      ),
    );
  }

  Widget sousCategorieField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Sous Categorie',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        // hint: Text('Sous Categorie'),
        value: sousCategorie,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        items: achatSousCat.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          setState(() {
            // type = null;
            sousCategorie = produit;
          });
        },
      ),
    );
  }

  Widget typeField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        // hint: Text('Type'),
        value: type,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        items: achatType.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          setState(() {
            // identifiant = null;
            type = produit;
          });
        },
      ),
    );
  }

  Widget identifiantField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Identifiant',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        // hint: Text('Identifiant'),
        value: identifiant,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        items: achatIdentifiant.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          setState(() {
            identifiant = produit;
          });
        },
      ),
    );
  }

  Widget priceField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        // controller: priceController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Total d\'argents',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (price) => price != null && price.isEmpty
            ? 'Le prix ne peut pas être vide'
            : null,
        onChanged: (value) => setState(() => price = value.trim()),
      ),
    );
  }

  Widget quantityField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Quantités des produits achetés',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (quantity) => quantity != null && quantity.isEmpty
            ? 'La quantité ne peut pas être vide'
            : null,
        onChanged: (value) => setState(() => quantity = value.trim()),
      ),
    );
  }

  Widget unityField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Unité',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: unity,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 20,
        elevation: 16,
        isDense: true,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        items: achatUnity.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          setState(() {
            unity = produit;
          });
        },
      ),
    );
  }

  Widget saveForm() {
    return ElevatedButton(
      onPressed: () {
        // final formAchat = _form.currentState!.validate();

        print("categorie $categorie");
        print("sousCategorie $sousCategorie");
        print("type $type");
        print("identifiant $identifiant");
        print("quantity $quantity");
        print("unity $unity");
        print("price $price");

        // print(formAchat);
        addAchat();

        Navigator.of(context).pop();
      },
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  Future addAchat() async {
    final achat = AchatModel(
      categorie: categorie.toString(),
      sousCategorie: sousCategorie.toString(),
      type: type.toString(),
      identifiant: identifiant.toString(),
      quantity: quantity.toString(),
      unity: unity.toString(),
      price: price.toString(),
      date: DateTime.now(),
    );

    await ProductDatabase.instance.insertAchat(achat);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${achat.type} ${achat.identifiant} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
