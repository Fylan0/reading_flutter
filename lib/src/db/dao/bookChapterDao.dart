import 'package:sqflite/sqflite.dart';

import '../../data/bookChapter.dart';
import '../databaseHelper.dart';

class BookChapterDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(BookChapter book) async {
    Database db = await dbHelper.database;
    return await db.insert(tbBookChapterName, book.toMap());
  }

  Future<void> insertAll(List<BookChapter> chapters) async {
    Database db = await dbHelper.database;
    Batch batch = db.batch();
    for (BookChapter bookChapter in chapters) {
      batch.insert(tbBookChapterName, bookChapter.toMap());
    }
    // 提交批处理操作
    List<dynamic> results = await batch.commit();
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
