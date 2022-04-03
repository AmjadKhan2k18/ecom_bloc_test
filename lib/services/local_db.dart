import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String productsTable = 'products';
  String id = 'id';
  String title = 'title';
  String description = 'description';
  String price = 'price';
  String currencyId = 'currency_id';
  String pictures = 'pictures';
  String onAdded = 'onAdded';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'products.db';

    // Open/create the database at a given path
    var productsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return productsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $productsTable($id STRING PRIMARY KEY, $title TEXT, '
        '$description TEXT,$price INTEGER, $currencyId TEXT, $onAdded INTEGER, $pictures STRING)');
  }

  // Fetch Operation: Get all Products objects from database
  Future<List<Map<String, dynamic>>> getProductsMapList() async {
    Database db = await database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority DESC');
    var result = await db.query(productsTable, orderBy: '$onAdded DESC');
    return result;
  }

  // Insert Operation: Insert a Product object to database
  Future<int> insertProduct(ProductDetail product) async {
    Database db = await database;
    var result = await db.insert(productsTable, product.toJson());
    return result;
  }

  // Update Operation: Update a Product object and save it to database
  Future<int> updateProduct(ProductDetail product) async {
    var db = await database;
    var result = await db.update(
      productsTable,
      product.toJson(),
      where: '$id = ?',
      whereArgs: [product.id],
    );
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteProduct(String _id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $productsTable WHERE $id = ?', [_id]);
    return result;
  }

  Future<List<ProductDetail>> getProductsList() async {
    var noteMapList = await getProductsMapList();

    List<ProductDetail> products = <ProductDetail>[];
    for (var product in noteMapList) {
      products.add(ProductDetail.fromDetailProductJson(product));
    }

    return products;
  }
}
