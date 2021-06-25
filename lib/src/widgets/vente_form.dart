import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VenteForm extends StatefulWidget {
  final String? categorie;
  final String? sousCategorie;
  final String? nameProduct;
  final String? quantity;
  final String? unity;
  final String? price;

  final ValueChanged<String> onChangedCategorie;
  final ValueChanged<String> onChangedSousCategorie;
  final ValueChanged<String> onChangedNameProduct;
  final ValueChanged<String> onChangedQuantity;
  final ValueChanged<String> onChangedUnity;
  final ValueChanged<String> onChangedPrice;

  const VenteForm({
    Key? key,
    this.categorie = '',
    this.sousCategorie = '',
    this.nameProduct = '',
    this.quantity = '',
    this.unity = '',
    this.price = '',
    required this.onChangedCategorie,
    required this.onChangedSousCategorie,
    required this.onChangedNameProduct,
    required this.onChangedQuantity,
    required this.onChangedUnity,
    required this.onChangedPrice,
  }) : super(key: key);

  @override
  _VenteFormState createState() => _VenteFormState(
      this.categorie,
      this.sousCategorie,
      this.nameProduct,
      this.quantity,
      this.unity,
      this.price,
      this.onChangedCategorie,
      this.onChangedSousCategorie,
      this.onChangedNameProduct,
      this.onChangedQuantity,
      this.onChangedUnity,
      this.onChangedPrice
    );
}

class _VenteFormState extends State<VenteForm> {
  final String? categorie;
  final String? sousCategorie;
  final String? nameProduct;
  final String? quantity;
  final String? unity;
  final String? price;

  final ValueChanged<String> onChangedCategorie;
  final ValueChanged<String> onChangedSousCategorie;
  final ValueChanged<String> onChangedNameProduct;
  final ValueChanged<String> onChangedQuantity;
  final ValueChanged<String> onChangedUnity;
  final ValueChanged<String> onChangedPrice;

  AchatModel? category;

  List<AchatModel> categorieList = [];

  _VenteFormState(
      this.categorie,
      this.sousCategorie,
      this.nameProduct,
      this.quantity,
      this.unity,
      this.price,
      this.onChangedCategorie,
      this.onChangedSousCategorie,
      this.onChangedNameProduct,
      this.onChangedQuantity,
      this.onChangedUnity,
      this.onChangedPrice);

  void initState() {
    super.initState();
    loadCategorie();
  }

  void loadCategorie() async {
    List<AchatModel>? categories =
        await ProductDatabase.instance.getAllAchatsVente();
    setState(() {
      categorieList = categories;
      category = categories.first;
      // print(categorieList);
      // print(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categorieField(),
          sousCategorieFIeld(),
          nameProductField(),
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
        ],
      ),
    );
  }

  Widget categorieField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          DropdownButtonFormField<AchatModel>(
            decoration: InputDecoration(
              labelText: 'Categorie',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.only(left: 5.0),
            ),
            value: category,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (categorie) => onChangedCategorie(categorie!.categorie.toString()),
            items: categorieList
                .map((achat) => DropdownMenuItem(
                      child: Text(achat.categorie),
                      value: achat,
                    ))
                .toList(),
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
          DropdownButtonFormField<AchatModel>(
            decoration: InputDecoration(
              labelText: 'Sous Categorie',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.only(left: 5.0),
            ),
            value: category,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (sousCategorie) =>
                onChangedSousCategorie(sousCategorie!.sousCategorie.toString()),
            items: categorieList
                .map((achat) => DropdownMenuItem(
                      child: Text(achat.sousCategorie),
                      value: achat,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget nameProductField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          DropdownButtonFormField<AchatModel>(
            decoration: InputDecoration(
              labelText: 'Nom du produit',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.only(left: 5.0),
            ),
            value: category,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (nameProduct) =>
                onChangedNameProduct(nameProduct!.nameProduct.toString()),
            items: categorieList
                .map((categorie) => DropdownMenuItem(
                      child: Text(categorie.nameProduct),
                      value: categorie,
                    ))
                .toList(),
          )
        ],
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
        onChanged: onChangedQuantity,
      ),
    );
  }

  Widget unityField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<AchatModel>(
        decoration: InputDecoration(
          labelText: 'Unité',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: category,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 20,
        elevation: 16,
        isDense: true,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (unity) => onChangedUnity(unity!.unity.toString()),
        items: categorieList
            .map((achat) => DropdownMenuItem(
                  child: Text(achat.unity),
                  value: achat,
                ))
            .toList(),
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
        onChanged: onChangedPrice,
      ),
    );
  }
}
