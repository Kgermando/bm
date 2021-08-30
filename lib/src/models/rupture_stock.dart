final String tableRuptureSctock = 'table_ruptureStock';

class RuptureStockFields {
  static final List<String> values = [
    id,
    categorie,
    sousCategorie,
    type,
    identifiant,
    quantity,
    price, // Prix unitaire
    date,
    dateRupture
  ]; 

  static final String id = '_id';
  static final String categorie = 'categorie';
  static final String sousCategorie = 'sousCategorie';
  static final String type = 'type';
  static final String identifiant = 'identifiant';
  static final String quantity = 'quantity';
  static final String unity = 'unity';
  static final String price = 'price';
  static final String date = 'date';
  static final String dateRupture = 'dateRupture';
}

class RuptureStockModel {
  final int? id;
  final String categorie;
  final String sousCategorie;
  final String type;
  final String identifiant;
  final String quantity;
  final String unity;
  final String price;
  final DateTime date;
  final DateTime dateRupture;


  const RuptureStockModel({
    this.id,
    required this.categorie,
    required this.sousCategorie,
    required this.type,
    required this.identifiant,
    required this.quantity,
    required this.unity,
    required this.price,
    required this.date,
    required this.dateRupture,
  });

  RuptureStockModel copy(
      {int? id,
      String? categorie,
      String? sousCategorie,
      String? type,
      String? identifiant,
      String? quantity,
      String? unity,
      String? price,
      DateTime? date,
      DateTime? dateRupture}) =>
  RuptureStockModel(
    id: id ?? this.id,
    categorie: categorie ?? this.categorie,
    sousCategorie: sousCategorie ?? this.sousCategorie,
    type: type ?? this.type,
    identifiant: type ?? this.identifiant,
    quantity: quantity ?? this.quantity,
    unity: unity ?? this.unity,
    price: price ?? this.price,
    date: date ?? this.date,
    dateRupture: dateRupture ?? this.dateRupture,
  );

  static RuptureStockModel fromJson(Map<String, Object?> json) => RuptureStockModel(
        id: json[RuptureStockFields.id] as int?,
        categorie: json[RuptureStockFields.categorie] as String,
        sousCategorie: json[RuptureStockFields.sousCategorie] as String,
        type: json[RuptureStockFields.type] as String,
        identifiant: json[RuptureStockFields.identifiant] as String,
        quantity: json[RuptureStockFields.quantity] as String,
        unity: json[RuptureStockFields.unity] as String,
        price: json[RuptureStockFields.price] as String,
        date: DateTime.parse(json[RuptureStockFields.date] as String),
        dateRupture: DateTime.parse(json[RuptureStockFields.dateRupture] as String),
      );

  Map<String, Object?> toJson() => {
        RuptureStockFields.id: id,
        RuptureStockFields.categorie: categorie,
        RuptureStockFields.sousCategorie: sousCategorie,
        RuptureStockFields.type: type,
        RuptureStockFields.identifiant: identifiant,
        RuptureStockFields.quantity: quantity,
        RuptureStockFields.unity: unity,
        RuptureStockFields.price: price,
        RuptureStockFields.date: date.toIso8601String(),
        RuptureStockFields.dateRupture: dateRupture.toIso8601String(),
      };
}