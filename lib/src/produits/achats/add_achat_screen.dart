import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/widgets/achat_form_widget.dart';
import 'package:flutter/material.dart';

class AddAchatScreen extends StatefulWidget {
  final AchatModel? achat;

  const AddAchatScreen({Key? key, this.achat}) : super(key: key);

  @override
  _AddAchatScreenState createState() => _AddAchatScreenState();
}

class _AddAchatScreenState extends State<AddAchatScreen> {
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

    categorie = widget.achat?.categorie ?? '';
    sousCategorie = widget.achat?.sousCategorie ?? '';
    nameProduct = widget.achat?.nameProduct ?? '';
    quantity = widget.achat?.quantity ?? '';
    unity = widget.achat?.unity ?? '';
    price = widget.achat?.price ?? '';
  }

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
        )
      ),
      // drawer: SideBarScreen(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AchatFormWidget(
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
      onPressed: addOrUpdateAchat,
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

  void addOrUpdateAchat() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.achat != null;

      if (isUpdating) {
        await updateAchat();
      } else {
        await addAchat();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateAchat() async {
    final achat = widget.achat!.copy(
      categorie: categorie,
      sousCategorie: sousCategorie,
      nameProduct: nameProduct,
      quantity: quantity,
      unity: unity,
      price: price,
      date: DateTime.now(),
    );

    await ProductDatabase.instance.updataAchat(achat);
    SnackBar(
      content: Text("${achat.nameProduct} Modifié!"),
      backgroundColor: Colors.green[700],
    );
  }

  Future addAchat() async {
    final achat = AchatModel(
      categorie: categorie,
      sousCategorie: sousCategorie,
      nameProduct: nameProduct,
      quantity: quantity,
      unity: unity,
      price: price,
      date: DateTime.now(),
    );

    await ProductDatabase.instance.insertAchat(achat);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${achat.nameProduct} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
