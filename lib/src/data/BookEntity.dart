import 'package:uuid/uuid.dart';

class BookEntity {
//    @TableId("book_id")
  final String bookId;

//    @TableField("book_name")
  final String bookName;

//    @TableField("book_content")
  final String bookContent;

//    @TableField("book_author")
  final String bookAuthor;

//    @TableField("book_shortIntro")
  final String bookShortIntro;

//    @TableField("book_cover")
  final String bookCover;

  BookEntity({
    String? bookId,
    this.bookName = "",
    this.bookContent = "",
    this.bookAuthor = "",
    this.bookShortIntro = "",
    this.bookCover = "",
  }) : bookId = bookId ?? const Uuid().v4();
}
