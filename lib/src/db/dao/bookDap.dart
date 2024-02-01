import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../../data/bookEntity.dart';
import '../databaseHelper.dart';

class BookDao {
  final dbHelper = DatabaseHelper.instance;

  // StreamController，在数据库变化时，通过调用 add(null) 发送通知。
  // 然后，你可以使用 onDatabaseChange 属性来订阅这个 Stream，从而在 UI 层获取数据库变化通知。
  final StreamController<void> _databaseChangeController =
      StreamController<void>.broadcast();

  Stream<void> get onDatabaseChange => _databaseChangeController.stream;

  Future<int> insert(BookEntity book) async {
    Database db = await dbHelper.database;
    _databaseChangeController.add(null);
    return await db.insert(tbBookName, book.toMap());
  }

  Future<List<BookEntity>> getAll() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbBookName);
    return List.generate(maps.length, (i) {
      return BookEntity.fromMap(maps[i]);
    });
  }
}
