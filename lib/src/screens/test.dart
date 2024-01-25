import 'package:flutter/material.dart';

import '../data/BookEntity.dart';
import '../db/dao/bookDap.dart';

/// 测试页面
const testRouter = "/test";

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                print('First Button Pressed');
                testDb();
              },
              child: Text('First Button'),
            ),
            const SizedBox(height: 16), // 间隔
            TextButton(
              onPressed: () {
                print('Second Button Pressed');
              },
              child: Text('Second Button'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> testDb() async {
  var bookDao = BookDao();
  var bookEntity = BookEntity(
    bookName: 'Book Name ',
    bookAuthor: 'Author ',
    bookCover:
        'https://img.iplaysoft.com/wp-content/uploads/2019/free-images/free_stock_photo_2x.jpg!0x0.webp',
    bookShortIntro: 'ShortIntro ',
  );
  await bookDao.insert(bookEntity);

  // 查询所有数据
  var book = await bookDao.getAll();
  print("book table data:$book");
}
