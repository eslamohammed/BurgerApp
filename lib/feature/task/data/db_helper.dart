import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'burger_shop.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE burgers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        price REAL,
        image TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        burgerId INTEGER,
        quantity INTEGER,
        total REAL,
        date TEXT,
        FOREIGN KEY(burgerId) REFERENCES burgers(id)
      )
    ''');
  }

  static Future<int> insertBurger(Map<String, dynamic> data) async {
    final db = await DBHelper.db;
    return await db.insert('burgers', data);
  }

  static Future<int> updateBurger(int id, Map<String, dynamic> data) async {
    final db = await DBHelper.db;
    return await db.update('burgers', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteBurger(int id) async {
    final db = await DBHelper.db;
    return await db.delete('burgers', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getAllBurgers() async {
    final db = await DBHelper.db;
    return await db.query('burgers');
  }

  static Future<Map<String, dynamic>?> getBurgerById(int id) async {
    final db = await DBHelper.db;
    final result = await db.query('burgers', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> removeDuplicateBurgers() async {
    final db = await DBHelper.db;
    final burgers = await db.query('burgers', orderBy: 'id ASC');

    final seen = <String>{};

    for (var burger in burgers) {
      String key = "${burger['name']}_${burger['price']}";

      if (seen.contains(key)) {
        await db.delete('burgers', where: 'id = ?', whereArgs: [burger['id']]);
      } else {
        seen.add(key);
      }
    }

    print("✅ تمت إزالة العناصر المكررة");
  }

  Future<void> seedInitialBurger() async {
    final existing = await DBHelper.getAllBurgers();
    if (existing.isNotEmpty) return;

    await DBHelper.insertBurger({
      'name': 'BBQ Angus Burger',
      'description':
          'Premium Angus beef, BBQ sauce, crispy onions, cheddar, and lettuce',
      'price': 90.0,
      'image': 'bbq_angus.png',
    });
  }

  Future<void> printAllBurgers() async {
    final data = await DBHelper.getAllBurgers();
    for (var item in data) {
      print("🍔 ${item['id']}: ${item['name']} - ${item['price']} EGP");
    }
  }

  Future<void> clearAllBurgers() async {
    final db = await DBHelper.db;
    await db.delete('burgers');
  }

  Future<void> deleteExtraBurgers() async {
    final db = await DBHelper.db;
    final burgers = await db.query('burgers', orderBy: 'id ASC');

    if (burgers.length <= 2) return;

    final idsToDelete = burgers.skip(5).map((e) => e['id'] as int).toList();

    for (var id in idsToDelete) {
      await db.delete('burgers', where: 'id = ?', whereArgs: [id]);
    }
  }
}

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DBHelper {
//   static Database? _db;

//   static Future<Database> get db async {
//     if (_db != null) return _db!;
//     _db = await initDB();
//     return _db!;
//   }

//   static Future<Database> initDB() async {
//     final dbPath = await getDatabasesPath();
//     String path = join(dbPath, 'burger_shop.db');

//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   static Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE burgers (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         description TEXT,
//         price REAL,
//         image TEXT
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE categories (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE orders (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         burgerId INTEGER,
//         quantity INTEGER,
//         total REAL,
//         date TEXT,
//         FOREIGN KEY(burgerId) REFERENCES burgers(id)
//       )
//     ''');
//   }

//   Future<void> insertBurger(
//     String name,
//     String desc,
//     double price,
//     String image,
//   ) async {
//     final db = await DBHelper.db;

//     await db.insert('burgers', {
//       'name': name,
//       'description': desc,
//       'price': price,
//       'image': image,
//     });
//   }

//   Future<List<Map<String, dynamic>>> getAllBurgers() async {
//     final db = await DBHelper.db;
//     return await db.query('burgers');
//   }
// }
