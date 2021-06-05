import 'package:e_management/src/models/vente_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class ProductDbProvider {
  late Database db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'products.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute(""" CREATE TABLE vente_table
        (
          id INTEGER PRIMARY KEY?
          categorie TEXT,
          sousCategorie TEXT,
          nameProduct TEXT,
          quantity INTEGER,
          price INTEGER,
          date TEXT
        ) 
        """);
    });
  }

  Future<VenteModel?> fecthVente(int id) async {
    final maps = await db.query(
      "vente_table",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return VenteModel.fromDb(maps.first);
    }
    return null;
  }



  Future<int> addVente(VenteModel vente) {
    return db.insert("vente_table", vente.toMap());
  }
}
