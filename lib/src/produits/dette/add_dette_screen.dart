import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/widgets/dette_form_widget.dart';
import 'package:flutter/material.dart';

class AddDetteScreen extends StatefulWidget {
  final DetteModel? dette;
  const AddDetteScreen({Key? key, this.dette}) : super(key: key);

  @override
  _AddDetteScreenState createState() => _AddDetteScreenState();
}

class _AddDetteScreenState extends State<AddDetteScreen> {
  final formKey = GlobalKey<FormState>();

  late String categorie;
  late String sousCategorie;
  late String nameProduct;
  late String quantity;
  late String unity;
  late String price;
  late String personne;

  @override
  void initState() {
    super.initState();

    categorie = widget.dette?.categorie ?? '';
    sousCategorie = widget.dette?.sousCategorie ?? '';
    nameProduct = widget.dette?.nameProduct ?? '';
    quantity = widget.dette?.quantity ?? '';
    unity = widget.dette?.unity ?? '';
    price = widget.dette?.price ?? '';
    personne = widget.dette?.personne ?? '';
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Ajoutez la dette'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new),
              label: Text(''),
            ),
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DetteFormWidget(
                    categorie: categorie,
                    sousCategorie: sousCategorie,
                    nameProduct: nameProduct,
                    quantity: quantity,
                    unity: unity,
                    price: price,
                    personne: personne,
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
                    onChangedPersonne: (personne) =>
                        setState(() => this.personne = personne),
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
      onPressed: addOrUpdateDette,
      child: Text(
        'Enregistrez',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  Widget deleteForm() {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Supprimer',
        textScaleFactor: 1.5,
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  void addOrUpdateDette() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.dette != null;

      if (isUpdating) {
        await updateDette();
      } else {
        await addDette();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateDette() async {
    final dette = widget.dette!.copy(
      categorie: categorie,
      sousCategorie: sousCategorie,
      nameProduct: nameProduct,
      quantity: quantity,
      unity: unity,
      price: price,
      date: DateTime.now(),
      personne: personne,
    );

    await ProductDatabase.instance.updataDette(dette);
    SnackBar(
      content: Text("${dette.nameProduct} Modifié!"),
      backgroundColor: Colors.green[700],
    );
  }

  Future addDette() async {
    final dette = DetteModel(
      categorie: categorie,
      sousCategorie: sousCategorie,
      nameProduct: nameProduct,
      quantity: quantity,
      unity: unity,
      price: price,
      date: DateTime.now(),
      personne: personne,
    );

    await ProductDatabase.instance.insertDette(dette);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${dette.nameProduct} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
