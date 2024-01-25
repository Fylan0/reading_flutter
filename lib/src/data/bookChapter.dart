import '../db/databaseHelper.dart';

///书籍章节实体类
class BookChapter {
  final String bookId;

  final String chapterName;

  final int chapterNumber;

  final String chapterContent;

  BookChapter(
      {required this.bookId,
      this.chapterName = "",
      required this.chapterNumber,
      this.chapterContent = ""});

  Map<String, dynamic> toMap() {
    return {
      tbColumnBookId: bookId,
      tbColumnChapterName: chapterName,
      tbColumnChapterNumber: chapterNumber,
      tbColumnChapterContent: chapterContent,
    };
  }

  factory BookChapter.fromMap(Map<String, dynamic> map) {
    return BookChapter(
      bookId: map[tbColumnBookId],
      chapterName: map[tbColumnChapterName],
      chapterNumber: map[tbColumnChapterNumber],
      chapterContent: map[tbColumnChapterContent],
    );
  }
}
