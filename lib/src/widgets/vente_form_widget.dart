import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:flutter/material.dart';

class VenteFormWidget extends StatelessWidget {
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

  const VenteFormWidget({
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
    AchatModel? _selectvalue;
    List<AchatModel> categorieList = [];
    // ProductDatabase.instance.getAllAchats().then(
    //   (value) => print(value.length),
    // );

    return FutureBuilder<List<AchatModel>>(
        future: ProductDatabase.instance.getAllAchats(),
        initialData: [],
        builder:
            (BuildContext context, AsyncSnapshot<List<AchatModel>> snapshot) {
          categorieList = snapshot.data!;
          print(snapshot.data);
          return Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                DropdownButtonFormField<AchatModel>(
                  decoration: InputDecoration(
                    labelText: 'Categorie',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    contentPadding: EdgeInsets.only(left: 5.0),
                  ),
                  value: _selectvalue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  elevation: 16,
                  isDense: true,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (categorie) =>
                      onChangedCategorie(categorie.toString()),
                  items: categorieList
                      .map((achat) => DropdownMenuItem<AchatModel>(
                            child: Text(achat.categorie),
                            value: achat,
                          ))
                      .toList(),
                  // items: categorieList!.map<DropdownMenuItem<AchatModel>>((value) {
                  //   return DropdownMenuItem<AchatModel>(
                  //     value: value,
                  //     child: Text(value.categorie),
                  //   );
                  // }).toList(),
                )
              ],
            ),
          );
        });
  }

  Widget sousCategorieFIeld() {
    var _selectvalue;
    List<AchatModel> sousCategorieList = [];
    ProductDatabase.instance
        .getAllAchats()
        .then((value) => sousCategorieList = value);
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
            value: _selectvalue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (sousCategorie) =>
                onChangedSousCategorie(sousCategorie.toString()),
            items: sousCategorieList
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
    var _selectvalue;
    List<AchatModel> nameProductList = [];
    ProductDatabase.instance
        .getAllAchats()
        .then((value) => nameProductList = value);
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
            value: _selectvalue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (sousCategorie) =>
                onChangedSousCategorie(sousCategorie.toString()),
            items: nameProductList
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
        keyboardType: TextInputType.number,
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
    var _selectvalue;
    List<AchatModel> unityList = [];
    ProductDatabase.instance.getAllAchats().then((value) => unityList = value);
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          DropdownButtonFormField<AchatModel>(
            decoration: InputDecoration(
              labelText: 'Unité',
              labelStyle: TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.only(left: 5.0),
            ),
            value: _selectvalue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 20,
            elevation: 16,
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (unity) => onChangedUnity(unity.toString()),
            items: unityList
                .map((achat) => DropdownMenuItem(
                      child: Text(achat.unity),
                      value: achat,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget priceField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        // controller: priceController,
        keyboardType: TextInputType.number,
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



























// class VenteFormWidget extends StatelessWidget {
//   final String? categorie;
//   final String? sousCategorie;
//   final String? nameProduct;
//   final String? quantity;
//   final String? unity;
//   final String? price;

//   final ValueChanged<String> onChangedCategorie;
//   final ValueChanged<String> onChangedSousCategorie;
//   final ValueChanged<String> onChangedNameProduct;
//   final ValueChanged<String> onChangedQuantity;
//   final ValueChanged<String> onChangedUnity;
//   final ValueChanged<String> onChangedPrice;

//   const VenteFormWidget({
//     Key? key,
//     this.categorie = '',
//     this.sousCategorie = '',
//     this.nameProduct = '',
//     this.quantity = '',
//     this.unity = '',
//     this.price = '',
//     required this.onChangedCategorie,
//     required this.onChangedSousCategorie,
//     required this.onChangedNameProduct,
//     required this.onChangedQuantity,
//     required this.onChangedUnity,
//     required this.onChangedPrice,
//   }) : super(key: key);

//   // static Future<List<AchatModel>> loadData() async {
//   //   await 
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<AchatModel>>(
//       future:ProductDatabase.instance.getAllAchats(),
//       builder:
//           (BuildContext context, AsyncSnapshot<List<AchatModel>> snapshot) {
//         List<AchatModel>? achatList = snapshot.data;
//         return ListView.builder(
//             itemCount: achatList!.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               final achat = achatList[index];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 20.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         labelText: 'Categorie',
//                         labelStyle: TextStyle(),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                         contentPadding: EdgeInsets.only(left: 5.0),
//                       ),
//                       child: DropdownButtonFormField<String>(
//                         value: achat.categorie.trim(),
//                         icon: const Icon(Icons.arrow_drop_down),
//                         iconSize: 20,
//                         elevation: 16,
//                         isDense: true,
//                         isExpanded: true,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         onChanged: (categorie) =>
//                             onChangedCategorie(categorie.toString()),
//                         items: achatList
//                             .map((achat) => DropdownMenuItem<String>(
//                                   child: Text(achat.categorie),
//                                   value: achat.toString(),
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         labelText: 'Sous Categorie',
//                         labelStyle: TextStyle(),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                         contentPadding: EdgeInsets.only(left: 5.0),
//                       ),
//                       child: DropdownButtonFormField<String>(
//                         value: achat.sousCategorie.trim(),
//                         icon: const Icon(Icons.arrow_drop_down),
//                         iconSize: 20,
//                         elevation: 16,
//                         isDense: true,
//                         isExpanded: true,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         onChanged: (sousCategorie) =>
//                             onChangedSousCategorie(sousCategorie.toString()),
//                         items: achatList
//                             .map((achat) => DropdownMenuItem<String>(
//                                   child: Text(achat.sousCategorie),
//                                   value: achat.toString(),
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         labelText: 'Nom du produit ou indentifiant',
//                         labelStyle: TextStyle(),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                         contentPadding: EdgeInsets.only(left: 5.0),
//                       ),
//                       child: DropdownButtonFormField<String>(
//                         value: achat.nameProduct.trim(),
//                         icon: const Icon(Icons.arrow_drop_down),
//                         iconSize: 20,
//                         elevation: 16,
//                         isDense: true,
//                         isExpanded: true,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         onChanged: (nameProduct) =>
//                             onChangedNameProduct(nameProduct.toString()),
//                         items: achatList
//                             .map((achat) => DropdownMenuItem<String>(
//                                   child: Text(achat.nameProduct),
//                                   value: achat.toString(),
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: quantityField(),
//                         ),
//                         SizedBox(
//                           width: 5.0,
//                         ),
//                         Expanded(
//                           child: InputDecorator(
//                             decoration: InputDecoration(
//                               labelText: 'Unité de mesure',
//                               labelStyle: TextStyle(),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5.0)),
//                               contentPadding: EdgeInsets.only(left: 5.0),
//                             ),
//                             child: DropdownButtonFormField<String>(
//                               value: achat.unity.trim(),
//                               icon: const Icon(Icons.arrow_drop_down),
//                               iconSize: 20,
//                               elevation: 16,
//                               isDense: true,
//                               isExpanded: true,
//                               style: const TextStyle(color: Colors.deepPurple),
//                               onChanged: (unity) =>
//                                   onChangedUnity(unity.toString()),
//                               items: achatList
//                                   .map((achat) => DropdownMenuItem<String>(
//                                         child: Text(achat.unity),
//                                         value: achat.toString(),
//                                       ))
//                                   .toList(),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     priceField(),
//                   ],
//                 ),
//               );
//             });
//       },
//     );
//   }

//   Widget quantityField() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20.0),
//       child: TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: 'Quantités des produits Vendus',
//           labelStyle: TextStyle(),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//         validator: (quantity) => quantity != null && quantity.isEmpty
//             ? 'La quantité ne peut pas être vide'
//             : null,
//         onChanged: onChangedQuantity,
//       ),
//     );
//   }

//   Widget priceField() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20.0),
//       child: TextFormField(
//         // controller: priceController,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: 'Total d\'argents',
//           labelStyle: TextStyle(),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//         validator: (price) => price != null && price.isEmpty
//             ? 'Le prix ne peut pas être vide'
//             : null,
//         onChanged: onChangedPrice,
//       ),
//     );
//   }
// }
