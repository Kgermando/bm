
final String tableVente = 'achat_table';

class VenteFields {
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

class VenteModel {
  final int? id;
  final String categorie;
  final String sousCategorie;
  final String nameProduct;
  final String quantity;
  final String unity;
  final String price;
  final DateTime date;


  const VenteModel({
    this.id,
    required this.categorie,
    required this.sousCategorie,
    required this.nameProduct,
    required this.quantity,
    required this.unity,
    required this.price,
    required this.date,
  });



  VenteModel copy({
    int? id,
    String? categorie,
    String? sousCategorie,
    String? nameProduct,
    String? quantity,
    String? unity,
    String? price,
    DateTime? date
  }) =>
  VenteModel(
    id: id ?? this.id,
    categorie: categorie ?? this.categorie,
    sousCategorie: sousCategorie ?? this.sousCategorie,
    nameProduct: nameProduct ?? this.nameProduct,
    quantity: quantity ?? this.quantity,
    unity: unity ?? this.unity,
    price: price ?? this.price,
    date: date ?? this.date,
  );

  static VenteModel fromJson(Map<String, Object?> json) => VenteModel(
    id: json[VenteFields.id] as int?,
    categorie: json[VenteFields.categorie] as String,
    sousCategorie: json[VenteFields.sousCategorie] as String,
    nameProduct: json[VenteFields.nameProduct] as String,
    quantity: json[VenteFields.quantity] as String,
    unity: json[VenteFields.unity] as String,
    price: json[VenteFields.price] as String,
    date: DateTime.parse(json[VenteFields.date] as String),
  );

  Map<String, Object?> toJson() => {
    VenteFields.id: id,
    VenteFields.categorie: categorie,
    VenteFields.sousCategorie: sousCategorie,
    VenteFields.nameProduct: nameProduct,
    VenteFields.quantity: quantity,
    VenteFields.unity: unity,
    VenteFields.price: price,
    VenteFields.date: date.toIso8601String(),
  };
}
