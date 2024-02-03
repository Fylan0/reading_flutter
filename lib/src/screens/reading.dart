import 'package:flutter/material.dart';
import 'package:reading_flutter/src/data/bookChapter.dart';
import 'package:reading_flutter/src/db/dao/bookChapterDao.dart';

/// 阅读页面

const readingRouter = "/reading";

const paramsBookId = "bookId";

class ReadingScreen extends StatefulWidget {
  final String bookId;

  const ReadingScreen({super.key, required this.bookId});

  @override
  State<StatefulWidget> createState() {
    return ReadingState();
  }
}

class ReadingState extends State<ReadingScreen> {
  late final String bookId;

  var bookChapterDao = BookChapterDao();

  Future<List<BookChapter>> getBookChapter() async {
    return bookChapterDao.getBookChapter(bookId);
  }

  @override
  void initState() {
    super.initState();
    bookId = widget.bookId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getBookChapter(),
        builder: (context, AsyncSnapshot<List<BookChapter>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // 加载中的 UI
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<BookChapter> bookChapterList = snapshot.data!;
            return SafeArea(
                child: ListView.builder(
                    itemCount: bookChapterList.length,
                    itemBuilder: (context, index) {
                      return _buildChapterPage(
                          bookChapterList[index].chapterContent);
                    }));
          }
        },
      ),
    );
  }

  Widget _buildChapterPage(String chapterContent) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Text(
          chapterContent,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
