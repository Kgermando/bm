final String tableDettes = 'dette_tables';

class DetteFields {
  static final List<String> values = [
    id,
    categorie,
    sousCategorie,
    type,
    identifiant,
    quantity,
    price,
    date,
    personne,
    datePayement,
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
  static final String personne = 'personne';
  static final String datePayement = 'datePayement';
}

class DetteModel {
  final int? id;
  final String categorie;
  final String sousCategorie;
  final String type;
  final String identifiant;
  final String quantity;
  final String unity;
  final String price;
  final DateTime date;
  final String personne;
  final DateTime datePayement;

  const DetteModel({
    this.id,
    required this.categorie,
    required this.sousCategorie,
    required this.type,
    required this.identifiant,
    required this.quantity,
    required this.unity,
    required this.price,
    required this.date,
    required this.personne,
    required this.datePayement,
  });

  DetteModel copy(
      {
        int? id,
        String? categorie,
        String? sousCategorie,
        String? type,
        String? identifiant,
        String? quantity,
        String? unity,
        String? price,
        DateTime? date,
        String? personne,
        DateTime? datePayement,
      }
        ) =>
      DetteModel(
        id: id ?? this.id,
        categorie: categorie ?? this.categorie,
        sousCategorie: sousCategorie ?? this.sousCategorie,
        type: type ?? this.type,
        identifiant: type ?? this.identifiant,
        quantity: quantity ?? this.quantity,
        unity: unity ?? this.unity,
        price: price ?? this.price,
        date: date ?? this.date,
        personne: personne ?? this.personne,
        datePayement: datePayement ?? this.datePayement
      );

  static DetteModel fromJson(Map<String, Object?> json) => DetteModel(
        id: json[DetteFields.id] as int?,
        // id: json['id'] == null ? null : BigInt.parse(json['id'] as String),
        categorie: json[DetteFields.categorie] as String,
        sousCategorie: json[DetteFields.sousCategorie] as String,
        type: json[DetteFields.type] as String,
        identifiant: json[DetteFields.identifiant] as String,
        quantity: json[DetteFields.quantity] as String,
        unity: json[DetteFields.unity] as String,
        price: json[DetteFields.price] as String,
        date: DateTime.parse(json[DetteFields.date] as String),
        personne: json[DetteFields.personne] as String,
        datePayement: DateTime.parse(json[DetteFields.date] as String),
      );

  Map<String, Object?> toJson() => {
        DetteFields.id: id,
        DetteFields.categorie: categorie,
        DetteFields.sousCategorie: sousCategorie,
        DetteFields.type: type,
        DetteFields.identifiant: identifiant,
        DetteFields.quantity: quantity,
        DetteFields.unity: unity,
        DetteFields.price: price,
        DetteFields.date: date.toIso8601String(),
        DetteFields.personne: personne,
        DetteFields.datePayement: datePayement.toIso8601String(),
      };
}
