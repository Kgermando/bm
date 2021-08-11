import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/drompdown_list/dropdown_categorie.dart';
import 'package:e_management/src/drompdown_list/dropdown_identifiant.dart';
import 'package:e_management/src/drompdown_list/dropdown_sous_cat.dart';
import 'package:e_management/src/drompdown_list/dropdown_type.dart';
import 'package:e_management/src/drompdown_list/dropdown_unity.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:flutter/material.dart';

class AddDetteForm extends StatefulWidget {
  const AddDetteForm({Key? key}) : super(key: key);

  @override
  _AddDetteFormState createState() => _AddDetteFormState();
}

class _AddDetteFormState extends State<AddDetteForm> {
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

  List<String> detteSousCat = [];
  List<String> detteType = [];
  List<String> detteIdentifiant = [];
  List<String> detteUnity = [];

  String? categorie;
  String? sousCategorie;
  String? type;
  String? identifiant;
  String? quantity;
  String? unity;
  String? price;
  String? personne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dettes"),
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
                personeField(),
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
        ));
  }

  Widget textField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Ecrivez les dettes clients ici",
        style: Theme.of(context).textTheme.headline5,
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
            detteSousCat = laitsCategorie;
            detteType = laitTypeCategorie;
            detteIdentifiant = laitIdentifiant;
            detteUnity = unites;
          } else if (produit == 'Boissons') {
            detteSousCat = boissonsCategorie;
            detteUnity = unites;
          } else if (produit == 'Bières') {
            detteSousCat = bieresCategorie;
            detteUnity = unites;
          } else if (produit == 'Fournitures') {
            detteSousCat = fournituresCategorie;
            detteUnity = unites;
          } else if (produit == 'Huiles végétales') {
            detteSousCat = huilesVegetaleCategorie;
            detteUnity = unites;
          } else if (produit == 'Serial') {
            detteSousCat = serialCategorie;
            detteUnity = unites;
          } else if (produit == 'Biscuits') {
            detteSousCat = biscuitsCategorie;
            detteUnity = unites;
          } else if (produit == 'Sucres') {
            detteSousCat = sucresCategorie;
            detteUnity = unites;
          } else if (produit == 'Sels') {
            detteSousCat = selsCategorie;
            detteUnity = unites;
          } else if (produit == 'Laits de beautés') {
            detteSousCat = laitBeauteCategorie;
            detteUnity = unites;
          } else if (produit == 'Divers') {
            detteSousCat = diversCategorie;
            detteUnity = unites;
          } else if (produit == 'Hygiènes') {
            detteSousCat = hygienesCategorie;
            detteUnity = unites;
          } else if (produit == 'Vin') {
            detteSousCat = vinCategorie;
            detteUnity = unites;
          } else if (produit == 'Autres') {
            detteSousCat = autresCategorie;
            detteUnity = unites;
          } else {
            detteSousCat = [];
            detteType = [];
            detteIdentifiant = [];
            detteUnity = [];
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
        items: detteSousCat.map((String value) {
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
        items: detteType.map((String value) {
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
        items: detteIdentifiant.map((String value) {
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
        items: detteUnity.map<DropdownMenuItem<String>>((String value) {
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

  Widget personeField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Personne',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => setState(() => personne = value.trim()),
      ),
    );
  }

  Widget saveForm() {
    return ElevatedButton(
      onPressed: () {
        // final formdette = _form.currentState!.validate();

        print("categorie $categorie");
        print("sousCategorie $sousCategorie");
        print("type $type");
        print("identifiant $identifiant");
        print("quantity $quantity");
        print("unity $unity");
        print("price $price");

        // print(formdette);
        addDette();

        Navigator.of(context).pop();
      },
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  Future addDette() async {
    final dette = DetteModel(
      categorie: categorie.toString(),
      sousCategorie: sousCategorie.toString(),
      type: type.toString(),
      identifiant: identifiant.toString(),
      quantity: quantity.toString(),
      unity: unity.toString(),
      price: price.toString(),
      date: DateTime.now(),
      personne: personne.toString(),
    );

    await ProductDatabase.instance.insertDette(dette);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${dette.sousCategorie} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
