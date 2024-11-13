import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'cart_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items (
        id TEXT PRIMARY KEY,
        name TEXT,
        price INTEGER,
        quantity INTEGER,
        size TEXT,
        iceLevel TEXT,
        syrup TEXT,
        imagePath TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE user (
        uid TEXT PRIMARY KEY
      )
    ''');
  }

  Future<bool> isUserLoggedIn() async {
    String? uid = await getUserUid();
    return uid != null;
  }

  Future<void> storeUserUid(String uid) async {
    final db = await instance.database;
    await db.insert('user', {'uid': uid},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> logoutUser() async {
    final db = await instance.database;
    await db.delete('user');
  }

  Future<String?> getUserUid() async {
    final db = await instance.database;
    final result = await db.query('user', limit: 1);
    return result.isNotEmpty ? result.first['uid'] as String : null;
  }

  Future<void> insert(CartItem item) async {
    final db = await instance.database;
    await db.insert('cart_items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String id) async {
    final db = await instance.database;
    await db.delete('cart_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateQuantity(CartItem item) async {
    final db = await instance.database;
    await db.update('cart_items', item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart_items');
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    return await db.query('cart_items');
  }
}

extension CartItemExtension on CartItem {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'size': size,
      'iceLevel': iceLevel,
      'syrup': syrup,
      'imagePath': imagePath,
      'description': description,
    };
  }
}
