
final String tableAchats = 'achat_tables';

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
  static final String unity = 'unity';
  static final String price = 'price';
  static final String date = 'date';
}

class AchatModel {
  final int? id;
  final String categorie;
  final String sousCategorie;
  final String nameProduct;
  final String quantity;
  final String unity;
  final String price;
  final DateTime date;

  // AchatModel(int id, String categorie, String sousCategorie, String nameProduct, String quantity, String price, DateTime date): 
  //   this.id = id, this.categorie = categorie, this.sousCategorie = sousCategorie, this.nameProduct = nameProduct, 
  //   this.quantity = quantity, this.price = price, this.date = date;

  const AchatModel({
    this.id,
    required this.categorie,
    required this.sousCategorie,
    required this.nameProduct,
    required this.quantity,
    required this.unity,
    required this.price,
    required this.date,
  });


  AchatModel copy({
    int? id,
    String? categorie,
    String? sousCategorie,
    String? nameProduct,
    String? quantity,
    String? unity,
    String? price,
    DateTime? date
  }) =>
  AchatModel(
    id: id ?? this.id,
    categorie: categorie ?? this.categorie,
    sousCategorie: sousCategorie ?? this.sousCategorie,
    nameProduct: nameProduct ?? this.nameProduct,
    quantity: quantity ?? this.quantity,
    unity: unity ?? this.unity,
    price: price ?? this.price,
    date: date ?? this.date,
  );

  static AchatModel fromJson(Map<String, Object?> json) => AchatModel(
    id: json[AchatFields.id] as int?,
    // id: json['id'] == null ? null : BigInt.parse(json['id'] as String),
    categorie: json[AchatFields.categorie] as String,
    sousCategorie: json[AchatFields.sousCategorie] as String,
    nameProduct: json[AchatFields.nameProduct] as String,
    quantity: json[AchatFields.quantity] as String,
    unity: json[AchatFields.unity] as String,
    price: json[AchatFields.price] as String,
    date: DateTime.parse(json[AchatFields.date] as String),
  );

  Map<String, Object?> toJson() => {
    AchatFields.id: id,
    AchatFields.categorie: categorie,
    AchatFields.sousCategorie: sousCategorie,
    AchatFields.nameProduct: nameProduct,
    AchatFields.quantity: quantity,
    AchatFields.unity: unity,
    AchatFields.price: price,
    AchatFields.date: date.toIso8601String(),
  };
}
