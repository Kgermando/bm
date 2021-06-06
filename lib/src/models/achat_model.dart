
final String tableAchats = 'achats';

class AchatFields {
  static final List<String> values = [
    id,
    categorie,
    sousCategorie,
    nameProduct,
    quantity,
    price, // Prix unitaire
    date
  ];

  static final String id = '_id';
  static final String categorie = 'categorie';
  static final String sousCategorie = 'sousCategorie';
  static final String nameProduct = 'nameProduct';
  static final String quantity = 'quantity';
  static final String price = 'price';
  static final String date = 'date';
}

class AchatModel {
  final int? id;
  final String categorie;
  final String sousCategorie;
  final String nameProduct;
  final int quantity;
  final int price;
  final DateTime date;

  const AchatModel({
    this.id,
    required this.categorie,
    required this.sousCategorie,
    required this.nameProduct,
    required this.quantity,
    required this.price,
    required this.date,
  });

  AchatModel copy({
    int? id,
    String? categorie,
    String? sousCategorie,
    String? nameProduct,
    int? quantity,
    int? price,
    DateTime? date
  }) =>
  AchatModel(
    id: id ?? this.id,
    categorie: categorie ?? this.categorie,
    sousCategorie: sousCategorie ?? this.sousCategorie,
    nameProduct: nameProduct ?? this.nameProduct,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
    date: date ?? this.date,
  );

  static AchatModel fromJson(Map<String, Object?> json) => AchatModel(
    id: json[AchatFields.id] as int?,
    categorie: json[AchatFields.categorie] as String,
    sousCategorie: json[AchatFields.sousCategorie] as String,
    nameProduct: json[AchatFields.nameProduct] as String,
    quantity: json[AchatFields.quantity] as int,
    price: json[AchatFields.price] as int,
    date: DateTime.parse(json[AchatFields.date] as String),
  );

  Map<String, Object?> toJson() => {
    AchatFields.id: id,
    AchatFields.categorie: categorie,
    AchatFields.sousCategorie: sousCategorie,
    AchatFields.nameProduct: nameProduct,
    AchatFields.quantity: quantity,
    AchatFields.price: price,
    AchatFields.date: date.toIso8601String(),
  };
}
