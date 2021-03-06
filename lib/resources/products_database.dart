import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/models/dette_model.dart';
import 'package:e_management/src/models/rupture_stock.dart';
import 'package:e_management/src/models/vente_model.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('b_management.db');

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
        ${AchatFields.type} $textType,
        ${AchatFields.identifiant} $textType,
        ${AchatFields.quantity} $textType,
        ${AchatFields.unity} $textType,
        ${AchatFields.price} $textType,
        ${AchatFields.prixVente} $textType,
        ${AchatFields.date} $textType
      )
      ''');

    await db.execute('''
      CREATE TABLE $tableVente (
        ${VenteFields.id} $idType,
        ${VenteFields.categorie} $textType,
        ${VenteFields.sousCategorie} $textType,
        ${AchatFields.type} $textType,
        ${AchatFields.identifiant} $textType,
        ${VenteFields.quantity} $textType,
        ${VenteFields.unity} $textType,
        ${VenteFields.price} $textType,
        ${VenteFields.date} $textType
      )
      ''');

    await db.execute('''
      CREATE TABLE $tableDettes (
        ${DetteFields.id} $idType,
        ${DetteFields.categorie} $textType,
        ${DetteFields.sousCategorie} $textType,
        ${AchatFields.type} $textType,
        ${AchatFields.identifiant} $textType,
        ${DetteFields.quantity} $textType,
        ${DetteFields.unity} $textType,
        ${DetteFields.price} $textType,
        ${DetteFields.date} $textType,
        ${DetteFields.personne} $textType,
        ${DetteFields.datePayement} $textType
      )
      ''');

    await db.execute('''
      CREATE TABLE $tableRuptureSctock (
        ${RuptureStockFields.id} $idType,
        ${RuptureStockFields.categorie} $textType,
        ${RuptureStockFields.sousCategorie} $textType,
        ${RuptureStockFields.type} $textType,
        ${RuptureStockFields.identifiant} $textType,
        ${RuptureStockFields.quantity} $textType,
        ${RuptureStockFields.unity} $textType,
        ${RuptureStockFields.price} $textType,
        ${RuptureStockFields.date} $textType,
        ${RuptureStockFields.dateRupture} $textType
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

  // Get One data in database
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

  // Get All data database
  Future<List<AchatModel>> getAllAchats() async {
    final db = await instance.database;

    final orderBy = '${AchatFields.date} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableAchats ORDER BY $orderBy');

    final result = await db.query(tableAchats, orderBy: orderBy);

    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

  Future<List<AchatModel>> getAllAchatDay() async {
    final db = await instance.database;
    final orderBy = '${AchatFields.date} ASC';
    final result = await db.rawQuery(
        'SELECT * FROM $tableAchats WHERE date >= datetime("now", "-1 day") ORDER BY $orderBy');
    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

  Future<List<AchatModel>> getAllAchatWeek() async {
    final db = await instance.database;
    final orderBy = '${AchatFields.date} ASC';
    var now = new DateTime.now();
    var nowW = now.subtract(Duration(days: 7));
    final result = await db
        .rawQuery('SELECT * FROM $tableAchats WHERE "$nowW" ORDER BY $orderBy');
    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

  Future<List<AchatModel>> getAllAchatMouth() async {
    final db = await instance.database;
    final orderBy = '${AchatFields.date} ASC';
    var now = new DateTime.now();
    var nowM = new DateTime(now.year, now.month - 1, now.day);
    final result = await db
        .rawQuery('SELECT * FROM $tableAchats WHERE "$nowM" ORDER BY $orderBy');
    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

  Future<List<AchatModel>> getAllAchatYear() async {
    final db = await instance.database;
    final orderBy = '${AchatFields.date} ASC';
    var now = new DateTime.now();
    var nowY = new DateTime(now.year - 1, now.month, now.day);
    final result = await db
        .rawQuery('SELECT * FROM $tableAchats WHERE "$nowY" ORDER BY $orderBy');
    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

  // Get All data database
  Future<List<AchatModel>> getAllAchatsVente() async {
    final db = await instance.database;

    final result = await db.query(tableAchats);

    return result.map((json) => AchatModel.fromJson(json)).toList();
  }

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

  // Delete data int database
  Future<int> deleteAchat(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAchats,
      where: '${AchatFields.id} = ?',
      whereArgs: [id],
    );
  }

// VENTES

  // Insert data in database
  Future<VenteModel> insertVente(VenteModel vente) async {
    final db = await instance.database;

    final id = await db.insert(tableVente, vente.toJson());
    return vente.copy(id: id);
  }

  // Get One data in database
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

  // Get All data database
  Future<List<VenteModel>> getAllVente() async {
    final db = await instance.database;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yy');
    final String formatted = formatter.format(now);
    print(formatted);

    final orderBy = '${VenteFields.date} ASC';
    // final resultt = await db.rawQuery('SELECT * FROM $tableVente WHERE >= $formatted ORDER BY $orderBy');

    final result = await db.query(tableVente, orderBy: orderBy);

    return result.map((json) => VenteModel.fromJson(json)).toList();
  }

  // Get All data database
  Future<List<VenteModel>> getAllVenteByDay() async {
    final db = await instance.database;
    // final date = '${VenteFields.date}';
    final orderBy = '${VenteFields.date} ASC';

    final result = await db.rawQuery(
        'SELECT * FROM $tableVente WHERE date >= datetime("now", "-1 day") ORDER BY $orderBy');

    return result.map((json) => VenteModel.fromJson(json)).toList();
  }

  Future<List<VenteModel>> getAllVenteByWeek() async {
    final db = await instance.database;
    final orderBy = '${VenteFields.date} ASC';
    // final result = await db
    //     .rawQuery('SELECT * FROM $tableVente WHERE "$nowW" ORDER BY $orderBy');
    final result = await db.rawQuery(
        'SELECT * FROM $tableVente WHERE date >= datetime("now", "-7 day") ORDER BY $orderBy');

    return result.map((json) => VenteModel.fromJson(json)).toList();
  }

  Future<List<VenteModel>> getAllVenteByMouth() async {
    final db = await instance.database;
    final orderBy = '${VenteFields.date} ASC';

    // final result = await db
    //     .rawQuery('SELECT * FROM $tableVente WHERE "$nowM" ORDER BY $orderBy');
    final result = await db.rawQuery(
        'SELECT * FROM $tableVente WHERE date >= datetime("now", "-30 day") ORDER BY $orderBy');

    return result.map((json) => VenteModel.fromJson(json)).toList();
  }

  Future<List<VenteModel>> getAllVenteByYear() async {
    final db = await instance.database;
    // var now = new DateTime.now();
    // var nowY = new DateTime(now.year - 1, now.month, now.day);
    final orderBy = '${VenteFields.date} ASC';

    // final result = await db
    //     .rawQuery('SELECT * FROM $tableVente WHERE "$nowY" ORDER BY $orderBy');
    final result = await db.rawQuery(
        'SELECT * FROM $tableVente WHERE date >= datetime("now", "-360 day") ORDER BY $orderBy');
    return result.map((json) => VenteModel.fromJson(json)).toList();
  }

  // Update Data in database
  Future<int> updataVente(VenteModel dette) async {
    final db = await instance.database;

    return db.update(
      tableVente,
      dette.toJson(),
      where: '${VenteFields.id} = ?',
      whereArgs: [dette.id],
    );
  }

  // Delete data int database
  Future<int> deleteVente(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableVente,
      where: '${VenteFields.id} = ?',
      whereArgs: [id],
    );
  }

  // DETTES

  // Insert data in database
  Future<DetteModel> insertDette(DetteModel dette) async {
    final db = await instance.database;

    final id = await db.insert(tableDettes, dette.toJson());
    return dette.copy(id: id);
  }

  // Get One data in database
  Future<DetteModel> getOneDette(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableDettes,
      columns: DetteFields.values,
      where: '${DetteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DetteModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Get All data database
  Future<List<DetteModel>> getAllDette() async {
    final db = await instance.database;

    final orderBy = '${DetteFields.date} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableDettes ORDER BY $orderBy');

    final result = await db.query(tableDettes, orderBy: orderBy);

    return result.map((json) => DetteModel.fromJson(json)).toList();
  }

  // Update Data in database
  Future<int> updataDette(DetteModel dette) async {
    final db = await instance.database;

    return db.update(
      tableDettes,
      dette.toJson(),
      where: '${DetteFields.id} = ?',
      whereArgs: [dette.id],
    );
  }

  // Delete data int database
  Future<int> deleteDette(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableDettes,
      where: '${DetteFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Close connexion with database
  Future closeDB() async {
    final db = await instance.database;

    db.close();
  }

  // RUPTURE STOCK
  // Insert data in database
  Future<RuptureStockModel> insertRuptureStock(
      RuptureStockModel ruptureSctock) async {
    final db = await instance.database;
    final id = await db.insert(tableRuptureSctock, ruptureSctock.toJson());
    return ruptureSctock.copy(id: id);
  }

  // Get All data database
  Future<List<RuptureStockModel>> getAllRuptureStock() async {
    final db = await instance.database;
    final orderBy = '${RuptureStockFields.date} ASC';
    final result = await db.query(tableRuptureSctock, orderBy: orderBy);
    return result.map((json) => RuptureStockModel.fromJson(json)).toList();
  }

  // Get One data in database
  Future<RuptureStockModel> getOneRuptureStock(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRuptureSctock,
      columns: RuptureStockFields.values,
      where: '${RuptureStockFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RuptureStockModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
}
