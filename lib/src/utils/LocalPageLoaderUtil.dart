import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../data/bookChapter.dart';

const int bufferSize = 512 * 1024;

RegExp? mChapterPattern;

//正则表达式章节匹配模式
// "(第)([0-9零一二两三四五六七八九十百千万壹贰叁肆伍陆柒捌玖拾佰仟]{1,10})([章节回集卷])(.*)"
const List<String> chapterPatterns = [
  r"^(.{0,8})(第)([0-9零一二两三四五六七八九十百千万亿億兆京]{1,10})([章节回集卷])?(.{0,30})$",
  r"^(\\s{0,4})([\\(\u3010\u300a]?(第)?)([0-9零一二两三四五六七八九十百千万亿億兆京]{1,10})([\.:\uff1a\u0020\f\t])(.{0,30})$",
  r"^(\\s{0,4})([\\(\uff08\u3010\u300a])(.{0,30})([\\)\uff09\u3011\u300b])(\\s{0,2})$",
  r"^(\\s{0,4})(正文)(.{0,20})$",
  r"^(.{0,4})(Chapter|chapter)(\\s{0,4})([0-9]{1,4})(.{0,30})$"
];

Future<List<BookChapter>> loadChapters(File bookFile, String bookId) async {
  List<BookChapter> chapters = [];

  try {
    RandomAccessFile bookStream = await bookFile.open(mode: FileMode.read);
    bool hasChapter = await checkChapterType(bookStream); // 你的检查章节的逻辑

    ByteData buffer = ByteData(bufferSize);
    int curOffset = 0;
    Utf8Codec utf8 = const Utf8Codec(allowMalformed: true);
    while (true) {
      Uint8List uint8List = buffer.buffer.asUint8List();
      int readLength =
          await bookStream.readInto(uint8List, 0, uint8List.length);
      if (readLength <= 0) {
        break;
      }

      if (hasChapter) {
        String blockContent =
            utf8.decode(buffer.buffer.asUint8List().sublist(0, readLength));

        int seekPos = 0;

        // 在你的代码中使用：
        RegExpMatch? matcher =
            findFirstMatchWithOffset(mChapterPattern!, blockContent, 0);

        while (matcher != null) {
          int chapterStart = matcher.start;

          int nextStart = 0;
          if (chapterStart > 0) {
            String content = blockContent.substring(seekPos, chapterStart);
            seekPos += content.length;

            if (chapters.isEmpty) {
              BookChapter prologue =
                  BookChapter(bookId: bookId, chapterNumber: 0);
              prologue.chapterName = "序章";
              prologue.chapterContent = content;
              chapters.add(prologue);
            } else {
              BookChapter lastChapter = chapters[chapters.length - 1];
              lastChapter.chapterContent = lastChapter.chapterContent + content;
            }

            BookChapter newChapter =
                BookChapter(bookId: bookId, chapterNumber: chapters.length);
            // newChapter.chapterName = matcher.group(chapterStart) ?? "";
            newChapter.chapterName = matcher.group(0) ?? "";
            chapters.add(newChapter);
          } else {
            String content = blockContent.substring(seekPos, nextStart);
            if (chapters.isEmpty) {
              BookChapter lastChapter = chapters[chapters.length - 1];
              lastChapter.chapterContent = lastChapter.chapterContent + content;
            } else {
              BookChapter newChapter =
                  BookChapter(bookId: bookId, chapterNumber: chapters.length);
              newChapter.chapterName = matcher.group(0) ?? "";
              newChapter.chapterContent = content;
              chapters.add(newChapter);
            }
          }
          // 查找下一个匹配
          nextStart = matcher.end;
          matcher = findFirstMatchWithOffset(
              mChapterPattern!, blockContent, nextStart);
        }
      } else {
        // 进行本地虚拟分章
        // ...
        curOffset += readLength;
      }
    }

    await bookStream.close();
  } catch (e, stackTrace) {
    print('Caught exception: $e');
    print('Stack trace:\n$stackTrace');
  }

  return chapters;
}

RegExpMatch? findFirstMatchWithOffset(RegExp pattern, String input, int start) {
  Iterable<RegExpMatch> matches = pattern.allMatches(input);
  for (RegExpMatch match in matches) {
    if (match.start >= start) {
      return match;
    }
  }
  return null;
}

Future<bool> checkChapterType(RandomAccessFile bookStream) async {
// 读取前128k的数据
  Uint8List buffer = Uint8List(bufferSize ~/ 4);
  int length = await bookStream.readInto(buffer);

// 进行章节匹配
  for (String str in chapterPatterns) {
    RegExp pattern = RegExp(str, multiLine: true);
    Utf8Codec utf8 = const Utf8Codec(allowMalformed: true);
    RegExpMatch? match =
        pattern.firstMatch(utf8.decode(buffer.sublist(0, length)));

// 如果匹配存在，表示当前章节使用这种匹配方式
    if (match != null) {
      mChapterPattern = pattern;
// 重置指针位置
      await bookStream.setPosition(0);
      return true;
    }
  }

// 重置指针位置
  await bookStream.setPosition(0);
  return false;
}
