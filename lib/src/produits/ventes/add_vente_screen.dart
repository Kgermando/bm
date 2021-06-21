import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:e_management/src/widgets/vente_form.dart';
import 'package:flutter/material.dart';

class AddVenteScreen extends StatefulWidget {
  final VenteModel? vente;
  const AddVenteScreen({Key? key, this.vente}) : super(key: key);

  @override
  _AddVenteScreenState createState() => _AddVenteScreenState();
}

class _AddVenteScreenState extends State<AddVenteScreen> {
  final formKey = GlobalKey<FormState>();

  late String categorie;
  late String sousCategorie;
  late String nameProduct;
  late String quantity;
  late String unity;
  late String price;

  @override
  void initState() {
    super.initState();

    categorie = widget.vente?.categorie ?? '';
    sousCategorie = widget.vente?.sousCategorie ?? '';
    nameProduct = widget.vente?.nameProduct ?? '';
    quantity = widget.vente?.quantity ?? '';
    unity = widget.vente?.unity ?? '';
    price = widget.vente?.price ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Ajoutez vos ventes'),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.power_settings_new),
            label: Text(''),
          ),
        ],
      )),
      body: SingleChildScrollView(  
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VenteForm(
                    categorie: categorie,
                    sousCategorie: sousCategorie,
                    nameProduct: nameProduct,
                    quantity: quantity,
                    unity: unity,
                    price: price,
                    onChangedCategorie: (categorie) =>
                        setState(() => this.categorie = categorie),
                    onChangedSousCategorie: (sousCategorie) =>
                        setState(() => this.sousCategorie = sousCategorie),
                    onChangedNameProduct: (nameProduct) =>
                        setState(() => this.nameProduct = nameProduct),
                    onChangedQuantity: (quantity) =>
                        setState(() => this.quantity = quantity),
                    onChangedUnity: (unity) =>
                        setState(() => this.unity = unity),
                    onChangedPrice: (price) =>
                        setState(() => this.price = price),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: saveForm(),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget saveForm() {
    return ElevatedButton(
      onPressed: addOrUpdateVente,
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );

  }

  void addOrUpdateVente() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.vente != null;

      if (isUpdating) {
        await updateVente();
      } else {
        await addVente();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateVente() async {
    final vente = widget.vente!.copy(
      categorie: categorie,
      sousCategorie: sousCategorie,
      nameProduct: nameProduct,
      quantity: quantity,
      unity: unity,
      price: price,
      date: DateTime.now(),
    );

    await ProductDatabase.instance.updataVente(vente);
    SnackBar(
      content: Text("${vente.nameProduct} Modifié!"),
      backgroundColor: Colors.green[700],
    );
  }

  Future addVente() async {
    final vente = VenteModel(
      categorie: categorie,
      sousCategorie: sousCategorie,
      nameProduct: nameProduct,
      quantity: quantity,
      unity: unity,
      price: price,
      date: DateTime.now(),
    );

    await ProductDatabase.instance.insertVente(vente);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${vente.nameProduct} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
