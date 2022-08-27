import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelpr {
  static late Database db;

  static Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'productsDb');
    print('Create DB');
    db = await openDatabase(path, version: 1, onCreate: (db, verion) {
      db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY, itemId INTEGER , name TEXT, image TEXT , price INTEGER, amount INTEGER)');
      db.execute(
          'CREATE TABLE services(id INTEGER PRIMARY KEY, itemId INTEGER , name TEXT, image TEXT , price INTEGER)');

      print('Create tabale');
    });

    return db;
  }

//insert products
  static Future<int> insertProductsDb(int id, int itemId, String name,
      String image, int price, int amount) async {
    return await db.rawInsert(
        'INSERT INTO products(id,itemId,name,image,price,amount)VALUES("$itemId","$itemId","$name", "$image","$price","$amount")');
  }

//insert service
  static Future<int> insertServiceDb(
    int id,
    int itemId,
    String name,
    String image,
    int price,
  ) async {
    return await db.rawInsert(
        'INSERT INTO services(id,itemId,name,image,price)VALUES("$itemId","$itemId","$name", "$image","$price")');
  }

//update
  static Future<int> updateAmmount(int id, int amount) async {
    return await db.rawUpdate(
        'UPDATE products SET amount = ? WHERE id = ?', ['$amount', '$id']);
  }

//get products
  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    return await db.rawQuery('SELECT * FROM products');
  }

//get services
  static Future<List<Map<String, dynamic>>> getAllServices() async {
    return await db.rawQuery('SELECT * FROM services');
  }

  // Count products
  static Future<List<Map<String, dynamic>>> getCountPriceProducts() async {
    return await db.rawQuery("SELECT SUM(price*amount) FROM products");
  }

// Count services
  static Future<List<Map<String, dynamic>>> getCountPriceServices() async {
    return await db.rawQuery("SELECT SUM(price) FROM services");
  }

  //delete products
  static Future<int> deleteItemProducts(int index) async {
    return await db.rawDelete('DELETE FROM products WHERE id = ?', ['$index']);
  }

  static Future<int> deleteAllProducts() async {
    return await db.delete('products');
  }

  //delete Service
  static Future<int> deleteItemService(int index) async {
    return await db.rawDelete('DELETE FROM services WHERE id = ?', ['$index']);
  }

  static Future<int> deleteAllService() async {
    return await db.delete('services');
  }
}
