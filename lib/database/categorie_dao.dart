import 'package:sqflite/sqflite.dart';

import '../models/categorie.dart';
import 'database_helper.dart';

class CategorieDao {
  static const String table = 'categories';

  Future<int> insererCategorie(Categorie categorie) async {
    // 1) Ouvre ou réutilise la base SQLite unique déclarée dans DatabaseHelper.
    final Database db = await DatabaseHelper().database;

    // 2) Convertit l'objet Categorie en Map compatible SQLite, puis insère la ligne.
    //    Le résultat est l'ID auto-généré attribué par SQLite.
    final int id = await db.insert(table, categorie.toMap());

    // 3) Renvoie l'ID nouvellement créé pour pouvoir l'utiliser ensuite.
    return id;
  }
}
