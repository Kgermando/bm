import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/drompdown_list/dropdown_categorie.dart';
import 'package:e_management/src/drompdown_list/dropdown_identifiant.dart';
import 'package:e_management/src/drompdown_list/dropdown_sous_cat.dart';
import 'package:e_management/src/drompdown_list/dropdown_type.dart';
import 'package:e_management/src/drompdown_list/dropdown_unity.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:flutter/material.dart';

class AddVenteForm extends StatefulWidget {
  const AddVenteForm({Key? key}) : super(key: key);

  @override
  _AddVenteFormState createState() => _AddVenteFormState();
}

class _AddVenteFormState extends State<AddVenteForm> {
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
  final List<String> diversCategorie =
      DropdownSousCategorie().diversSousCategorie;
  final List<String> laitBeauteCategorie =
      DropdownSousCategorie().laitBeauteSousCategorie;
  final List<String> hygienesCategorie =
      DropdownSousCategorie().hygienesSousCategorie;
  final List<String> vinCategorie = DropdownSousCategorie().vinSousCategorie;
  final List<String> alcoolSousCategorie =
      DropdownSousCategorie().alcoolSousCategorie;

  // Type
  final List<String> laitTypeCategorie = DropdownType().laitType;
  final List<String> boissonsType = DropdownType().boissonsType;
  final List<String> bierreType = DropdownType().bierreType;
  final List<String> fournitureType = DropdownType().fournitureType;
  final List<String> huilesVegetaleType = DropdownType().huilesVegetaleType;
  final List<String> serialVegetaleType = DropdownType().serialVegetaleType;
  final List<String> biscuitsType = DropdownType().biscuitsType;
  final List<String> laitBeauteType = DropdownType().laitBeauteType;
  final List<String> vinType = DropdownType().vinType;

  // Identifiant
  final List<String> laitIdentifiant = DropdownIdentifiant().laitIdentifiant;
  final List<String> biossonsIdentifiant =
      DropdownIdentifiant().biossonsIdentifiant;
  final List<String> fournituresIdentifiant =
      DropdownIdentifiant().fournituresIdentifiant;
  final List<String> serialIdentifiant =
      DropdownIdentifiant().serialIdentifiant;
  final List<String> biscuitsIdentifiant =
      DropdownIdentifiant().biscuitsIdentifiant;
  final List<String> laitBeauteIdentifiant =
      DropdownIdentifiant().laitBeauteIdentifiant;

  // Unités
  final List<String> unites = DropdownUnity().unites;
  final List<String> unitesLait = DropdownUnity().unitesLait;
  final List<String> unitesBoissons = DropdownUnity().unitesBoissons;
  final List<String> unitesBierre = DropdownUnity().unitesBierre;
  final List<String> unitesFournitures = DropdownUnity().unitesFournitures;
  final List<String> unitesHuileVegetale = DropdownUnity().unitesHuileVegetale;
  final List<String> unitesSerial = DropdownUnity().unitesSerial;
  final List<String> unitesBiscuits = DropdownUnity().unitesBiscuits;
  final List<String> unitesLaitBeaute = DropdownUnity().unitesLaitBeaute;

  List<String> venteSousCat = [];
  List<String> venteType = [];
  List<String> venteIdentifiant = [];
  List<String> venteUnity = [];

  String? categorie;
  String? sousCategorie;
  String? type;
  String? identifiant;
  String? quantity;
  String? unity;
  String? price;

  bool isLoading = false;

  @override
  void initState() {
    loadAchats();

    super.initState();
  }

  List<AchatModel> achatList = [];
  List<AchatModel> categorieAchat = [];

  void loadAchats() async {
    List<AchatModel>? achats = await ProductDatabase.instance.getAllAchats();
    setState(() {
      categorieAchat = achats;
      achatList = achats;
    });

    print('categorieAchat $categorieAchat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nouveau vente"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _form,
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
                  quantityField(),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: quantityField(),
                  //     ),
                  //     SizedBox(
                  //       width: 5.0,
                  //     ),
                  //     Expanded(
                  //       child: unityField(),
                  //     )
                  //   ],
                  // ),
                  // priceField(),
                  saveForm()
                ],
              ),
            ),
          ),
        ));
  }

  Widget textField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Ajoutez votre vente ici",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget categorieField() {
    var catList = categorieAchat.map((e) => e.categorie).toSet();

    // print('catList $catList');

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
        items: catList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          if (produit == 'Laits') {
            venteSousCat = laitsCategorie;
            venteType = laitTypeCategorie;
            venteIdentifiant = laitIdentifiant;
            venteUnity = unitesLait;
          } else if (produit == 'Boissons') {
            venteSousCat = boissonsCategorie;
            venteType = boissonsType;
            venteIdentifiant = biossonsIdentifiant;
            venteUnity = unitesBoissons;
          } else if (produit == 'Bières') {
            venteSousCat = bieresCategorie;
            venteType = bierreType;
            venteIdentifiant = biossonsIdentifiant;
            venteUnity = unitesBierre;
          } else if (produit == 'Fournitures') {
            venteSousCat = fournituresCategorie;
            venteType = fournitureType;
            venteIdentifiant = fournituresIdentifiant;
            venteUnity = unitesFournitures;
          } else if (produit == 'Huiles végétales') {
            venteSousCat = huilesVegetaleCategorie;
            venteType = huilesVegetaleType;
            venteIdentifiant = serialIdentifiant;
            venteUnity = unitesHuileVegetale;
          } else if (produit == 'Serial') {
            venteSousCat = serialCategorie;
            venteType = serialVegetaleType;
            venteIdentifiant = serialIdentifiant;
            venteUnity = unitesSerial;
          } else if (produit == 'Biscuits') {
            venteSousCat = biscuitsCategorie;
            venteType = biscuitsType;
            venteIdentifiant = biscuitsIdentifiant;
            venteUnity = unitesBiscuits;
          } else if (produit == 'Laits de beautés') {
            venteSousCat = laitBeauteCategorie;
            venteType = laitBeauteType;
            venteIdentifiant = laitBeauteIdentifiant;
            venteUnity = unitesLaitBeaute;
          } else if (produit == 'Hygiènes') {
            venteSousCat = hygienesCategorie;
            venteType = vinType;
            venteIdentifiant = biscuitsIdentifiant;
            venteUnity = unites;
          } else if (produit == 'Vin') {
            venteSousCat = vinCategorie;
            venteType = vinType;
            venteIdentifiant = laitBeauteIdentifiant;
            venteUnity = unitesBoissons;
          } else if (produit == 'Alcool') {
            venteSousCat = alcoolSousCategorie;
            venteType = vinType;
            venteIdentifiant = laitBeauteIdentifiant;
            venteUnity = unitesBoissons;
          } else if (produit == 'Divers') {
            venteSousCat = diversCategorie;
            venteType = vinType;
            venteIdentifiant = biscuitsIdentifiant;
            venteUnity = unites;
          } else {
            venteSousCat = [];
            venteType = [];
            venteIdentifiant = [];
            venteUnity = [];
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
        items: venteSousCat.map((String value) {
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
        items: venteType.map((String value) {
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
        items: venteIdentifiant.map((String value) {
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
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
        items: venteUnity.map<DropdownMenuItem<String>>((String value) {
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
        isLoading = true;
        if (_form.currentState!.validate()) {
          addVente();
          Navigator.of(context).pop();
        }
        isLoading = false;
       
      },
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  void addVente() async {
    var filterAchat = achatList.where((element) =>
        categorie.toString() == element.categorie &&
        sousCategorie.toString() == element.sousCategorie &&
        type.toString() == element.type &&
        identifiant.toString() == element.identifiant);

    var prixVenteAchat = filterAchat.map((e) => e.prixVente);

    final String priceVente = prixVenteAchat.first;

    final String qtyVente = quantity.toString();

    print('priceAchat $priceVente');
    print('qtyVente $qtyVente');

    var priceTotal = int.parse(priceVente) * int.parse(qtyVente);

    final vente = VenteModel(
      categorie: categorie.toString(),
      sousCategorie: sousCategorie.toString(),
      type: type.toString(),
      identifiant: identifiant.toString(),
      quantity: quantity.toString(),
      unity: identifiant.toString(),
      price: priceTotal.toString(),
      date: DateTime.now(),
    );

    await ProductDatabase.instance.insertVente(vente);
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${vente.sousCategorie} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
