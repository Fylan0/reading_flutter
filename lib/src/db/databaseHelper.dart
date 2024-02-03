import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//todo：静态成员变量定义在这里是否合理？flutter中有无指定方式定义全局静态常量？
///书籍表名
const tbBookName = "tb_book";
const tbBookChapterName = "tb_book_chapter";

///表字段
const tbColumnBookId = "book_id";
//书籍名称
const tbColumnBookName = "book_name";
//书籍内容（预留字段，暂时为空）
const tbColumnBookContent = "book_content";
//作者
const tbColumnBookAuthor = "book_author";
//书籍简介
const tbColumnBookShortIntro = "book_short_intro";
//书籍封面图片地址
const tbColumnBookCover = "book_cover";
//章节内容
const tbColumnChapterContent = "chapter_content";
//章节数（第几章）
const tbColumnChapterNumber = "chapter_number";
//章节名称
const tbColumnChapterName = "chapter_name";

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<void> closeDatabase() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'reading_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // 创建表的逻辑

        var sqlScript = [
          '''
          CREATE TABLE $tbBookName (
            $tbColumnBookId TEXT PRIMARY KEY,
            $tbColumnBookName TEXT,
            $tbColumnBookContent TEXT,
            $tbColumnBookAuthor TEXT,
            $tbColumnBookShortIntro TEXT,
            $tbColumnBookCover TEXT
          )
       ''',
          '''
          CREATE TABLE $tbBookChapterName (
            serial INTEGER PRIMARY KEY AUTOINCREMENT,
            $tbColumnBookId TEXT,
            $tbColumnChapterName TEXT,
            $tbColumnChapterContent TEXT,
            $tbColumnChapterNumber INTEGER
          )
       ''',
        ];
        sqlScript.forEach((sql) async => await db.execute(sql));
      },
    );
  }
}
