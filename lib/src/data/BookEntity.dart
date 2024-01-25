import 'package:uuid/uuid.dart';

import '../db/databaseHelper.dart';

///书籍实体类
class BookEntity {
  final String bookId;
  final String bookName;
  final String bookContent;
  final String bookAuthor;
  final String bookShortIntro;
  final String bookCover;

  BookEntity({
    String? bookId,
    this.bookName = "",
    this.bookContent = "",
    this.bookAuthor = "",
    this.bookShortIntro = "",
    this.bookCover = "",
  }) : bookId = bookId ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      tbColumnBookId: bookId,
      tbColumnBookName: bookName,
      tbColumnBookContent: bookContent,
      tbColumnBookAuthor: bookAuthor,
      tbColumnBookShortIntro: bookShortIntro,
      tbColumnBookCover: bookCover,
    };
  }

  factory BookEntity.fromMap(Map<String, dynamic> map) {
    return BookEntity(
      bookId: map[tbColumnBookId],
      bookName: map[tbColumnBookName],
      bookContent: map[tbColumnBookContent],
      bookAuthor: map[tbColumnBookAuthor],
      bookShortIntro: map[tbColumnBookShortIntro],
      bookCover: map[tbColumnBookCover],
    );
  }

  @override
  String toString() {
    return 'BookEntity{bookId: $bookId, bookName: $bookName,'
        ' bookContent: $bookContent, bookAuthor: $bookAuthor,'
        ' bookShortIntro: $bookShortIntro, bookCover: $bookCover}';
  }
}
