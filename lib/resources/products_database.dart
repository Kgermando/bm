import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('emanagement.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    // final boolType = 'BOOLEAN NOT NULL';
    // final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableAchats (
        ${AchatFields.id} $idType,
        ${AchatFields.categorie} $textType,
        ${AchatFields.sousCategorie} $textType,
        ${AchatFields.nameProduct} $textType,
        ${AchatFields.quantity} $textType,
        ${AchatFields.unity} $textType,
        ${AchatFields.price} $textType,
        ${AchatFields.date} $textType
      )
      ''');
    
    await db.execute('''
      CREATE TABLE $tableVente (
        ${VenteFields.id} $idType,
        ${VenteFields.categorie} $textType,
        ${VenteFields.sousCategorie} $textType,
        ${VenteFields.nameProduct} $textType,
        ${VenteFields.quantity} $textType,
        ${VenteFields.unity} $textType,
        ${VenteFields.price} $textType,
        ${VenteFields.date} $textType
      )
      ''');
  }

  // Insert data in database
  Future<AchatModel> insertAchat(AchatModel achat) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableAchats, achat.toJson());
    return achat.copy(id: id);
  }

  // Get One Achat in database
  Future<AchatModel> getOneAchat(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAchats,
      columns: AchatFields.values,
      where: '${AchatFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AchatModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Get All Achat database
  Future<List<AchatModel>> getAllAchats() async {
    final db = await instance.database;

    final orderBy = '${AchatFields.date} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableAchats ORDER BY $orderBy');

    final result = await db.query(tableAchats, orderBy: orderBy);

    return result.map((json) => AchatModel.fromJson(json)).toList();
  }


  // Get All Achat database
  Future<List<AchatModel>> getAllAchatsVente() async {
    final db = await instance.database;

    final result = await db.query(tableAchats);

    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

  // Future<List<AchatModel>> getAllCategories() async {
  //   final db = await instance.database;
  //   var res = await db.query(tableAchats);
  //   List<AchatModel> list = res.isNotEmpty
  //       ? res
  //           .map((c) => AchatModel(
  //              categorie: c['categorie'].toString(), sousCategorie: c['sousCategorie'].toString(),
  //               nameProduct: c['nameProduct'].toString(), quantity: c['quantity'].toString(), unity: c['unity'].toString(), price: c['price'].toString(), date: DateTime.now()))
  //           .toList()
  //       : [];
  //   return list;
  // }

  

  // Update Data in database
  Future<int> updataAchat(AchatModel achat) async {
    final db = await instance.database;

    return db.update(
      tableAchats,
      achat.toJson(),
      where: '${AchatFields.id} = ?',
      whereArgs: [achat.id],
    );
  }

  // Delete Achat int database
  Future<int> deleteAchat(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAchats,
      where: '${AchatFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Close connexion with database
  Future closaAchat() async {
    final db = await instance.database;

    db.close();
  }



  // Insert data in database
  Future<VenteModel> insertVente(VenteModel vente) async {
    final db = await instance.database;

    final id = await db.insert(tableVente, vente.toJson());
    return vente.copy(id: id);
  }

  // Get One Achat in database
  Future<VenteModel> getOneVente(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableVente,
      columns: VenteFields.values,
      where: '${VenteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return VenteModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Get All Achat database
  Future<List<VenteModel>> getAllVente() async {
    final db = await instance.database;

    final orderBy = '${VenteFields.date} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableVente ORDER BY $orderBy');

    final result = await db.query(tableVente, orderBy: orderBy);

    return result.map((json) => VenteModel.fromJson(json)).toList();
  }

  // Update Data in database
  Future<int> updataVente(VenteModel achat) async {
    final db = await instance.database;

    return db.update(
      tableVente,
      achat.toJson(),
      where: '${VenteFields.id} = ?',
      whereArgs: [achat.id],
    );
  }

  // Delete Achat int database
  Future<int> deleteVente(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableVente,
      where: '${VenteFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Close connexion with database
  Future closeVente() async {
    final db = await instance.database;

    db.close();
  }
}
