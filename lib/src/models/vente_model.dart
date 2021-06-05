class VenteModel {
  final int id;
  final String categorie;
  final String sousCategorie;
  final String nameProduct;
  final int quantity;
  final int price;
  final String date;

  VenteModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        categorie = parsedJson['categorie'],
        sousCategorie = parsedJson['sousCategorie'],
        nameProduct = parsedJson['nameProduct'],
        quantity = parsedJson['quantity'],
        price = parsedJson['price'],
        date = parsedJson['date'];

  VenteModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        categorie = parsedJson['categorie'],
        sousCategorie = parsedJson['sousCategorie'],
        nameProduct = parsedJson['nameProduct'],
        quantity = parsedJson['quantity'],
        price = parsedJson['price'],
        date = parsedJson['date'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "categorie": categorie,
      "sousCategorie": sousCategorie,
      "nameProduct": nameProduct,
      "quantity": quantity,
      "price": price,
      "date": date
    };
  }
}
