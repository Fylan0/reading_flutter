import 'package:sqflite/sqflite.dart';
import '../../data/BookChapter.dart';
import '../databaseHelper.dart';

class BookChapterDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(BookChapter book) async {
    Database db = await dbHelper.database;
    return await db.insert(tbBookChapterName, book.toMap());
  }

  Future<List<BookChapter>> getAll() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbBookChapterName);
    return List.generate(maps.length, (i) {
      return BookChapter.fromMap(maps[i]);
    });
  }

  // 其他数据库操作方法...
}
