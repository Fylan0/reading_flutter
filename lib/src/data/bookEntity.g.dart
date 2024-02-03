// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookEntity _$BookEntityFromJson(Map<String, dynamic> json) => BookEntity(
      bookId: json['bookId'] as String?,
      bookName: json['bookName'] as String? ?? "",
      bookContent: json['bookContent'] as String? ?? "",
      bookAuthor: json['bookAuthor'] as String? ?? "",
      bookShortIntro: json['bookShortIntro'] as String? ?? "",
      bookCover: json['bookCover'] as String? ?? "",
    );

Map<String, dynamic> _$BookEntityToJson(BookEntity instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'bookName': instance.bookName,
      'bookContent': instance.bookContent,
      'bookAuthor': instance.bookAuthor,
      'bookShortIntro': instance.bookShortIntro,
      'bookCover': instance.bookCover,
    };
