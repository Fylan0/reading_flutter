import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../db/databaseHelper.dart';

part 'bookEntity.g.dart';

///书籍实体类
@JsonSerializable()
class BookEntity {
  final String bookId;
  String bookName;
  String bookContent;
  String bookAuthor;
  String bookShortIntro;
  String bookCover;

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

  factory BookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BookEntityToJson(this);

  @override
  String toString() {
    return 'BookEntity{bookId: $bookId, bookName: $bookName,'
        ' bookContent: $bookContent, bookAuthor: $bookAuthor,'
        ' bookShortIntro: $bookShortIntro, bookCover: $bookCover}';
  }
}
