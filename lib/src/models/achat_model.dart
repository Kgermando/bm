final String tableAchats = 'achat_tables';

class AchatFields {
  static final List<String> values = [
    id,
    categorie,
    sousCategorie,
    type,
    identifiant,
    quantity,
    price, // Prix unitaire
    date
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
}

class AchatModel {
  final int? id;
  final String categorie;
  final String sousCategorie;
  final String type;
  final String identifiant;
  final String quantity;
  final String unity;
  final String price;
  final DateTime date;

  // AchatModel(int id, String categorie, String sousCategorie, String type, String quantity, String price, DateTime date):
  //   this.id = id, this.categorie = categorie, this.sousCategorie = sousCategorie, this.type = type,
  //   this.quantity = quantity, this.price = price, this.date = date;

  const AchatModel({
    this.id,
    required this.categorie,
    required this.sousCategorie,
    required this.type,
    required this.identifiant,
    required this.quantity,
    required this.unity,
    required this.price,
    required this.date,
  });

  AchatModel copy(
          {int? id,
          String? categorie,
          String? sousCategorie,
          String? type,
          String? identifiant,
          String? quantity,
          String? unity,
          String? price,
          DateTime? date}) =>
      AchatModel(
        id: id ?? this.id,
        categorie: categorie ?? this.categorie,
        sousCategorie: sousCategorie ?? this.sousCategorie,
        type: type ?? this.type,
        identifiant: type ?? this.identifiant,
        quantity: quantity ?? this.quantity,
        unity: unity ?? this.unity,
        price: price ?? this.price,
        date: date ?? this.date,
      );

  static AchatModel fromJson(Map<String, Object?> json) => AchatModel(
        id: json[AchatFields.id] as int?,
        categorie: json[AchatFields.categorie] as String,
        sousCategorie: json[AchatFields.sousCategorie] as String,
        type: json[AchatFields.type] as String,
        identifiant: json[AchatFields.identifiant] as String,
        quantity: json[AchatFields.quantity] as String,
        unity: json[AchatFields.unity] as String,
        price: json[AchatFields.price] as String,
        date: DateTime.parse(json[AchatFields.date] as String),
      );

  Map<String, Object?> toJson() => {
        AchatFields.id: id,
        AchatFields.categorie: categorie,
        AchatFields.sousCategorie: sousCategorie,
        AchatFields.type: type,
        AchatFields.identifiant: identifiant,
        AchatFields.quantity: quantity,
        AchatFields.unity: unity,
        AchatFields.price: price,
        AchatFields.date: date.toIso8601String(),
      };
}
