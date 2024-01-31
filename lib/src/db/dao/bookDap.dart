import 'package:sqflite/sqflite.dart';
import '../../data/bookEntity.dart';
import '../databaseHelper.dart';

class BookDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(BookEntity book) async {
    Database db = await dbHelper.database;
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
