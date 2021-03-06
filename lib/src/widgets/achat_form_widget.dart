import 'package:flutter/material.dart';

class AchatFormWidget extends StatelessWidget {
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

  const AchatFormWidget({
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
    'Biscuit',
    'Sucre',
    'Sel',
    'Divers',
    'Autres'
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
    'Fiesta',
    'Cowbell',
    'Nido',
    'VitMilk',
    'Kerrygold',
    'Rouge',
    'Fromat',
    'Fraine de manioc',
    'Sucre',
    'Sel',
    'Divers',
    'Autres'
  ];

  final String unityValue = 'Unité';
  static var _unity = [
    'Unité',
    'Pièces',
    'Sacs',
    'Paquets',
    'Sachets',
    'Verres',
    'Boites',
    'Casiers',
    'Bouteilles',
    'Goblets',
    'Kgs',
    'Littres',
    'Rames',
    'FC',
    '\$',
    '€',
    'FCFA',
    'Divers',
  ];

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
              SizedBox(width: 5.0,),
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Categorie',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.only(left: 5.0),
            ),
            value: categorieValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (categorie) => onChangedCategorie(categorie.toString()),
            items: _categorie.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Sous Categorie',
              labelStyle: TextStyle(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.only(left: 5.0),
            ),
            value: sousCategorieValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (sousCategorie) => onChangedSousCategorie(sousCategorie.toString()),
            items:
                _sousCategorie.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
        validator: (nameProduct) =>
           nameProduct != null && nameProduct.isEmpty ? 'Le Nom du produit ne peut pas être vide' : null,
        onChanged: onChangedNameProduct,
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
        validator: (quantity) =>
           quantity != null && quantity.isEmpty ? 'La quantité ne peut pas être vide' : null,
        onChanged: onChangedQuantity,
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
        value: unityValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 20,
        elevation: 16,
        isDense: true,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (unity) => onChangedUnity(unity.toString()),
        items: _unity.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
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
        validator: (price) =>
          price != null && price.isEmpty ? 'Le prix ne peut pas être vide' : null,
        onChanged: onChangedPrice,
      ),
    );
  }

}
