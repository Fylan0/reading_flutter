import 'package:flutter/material.dart';
import 'package:reading_flutter/src/db/dao/bookChapterDao.dart';

import '../data/bookEntity.dart';
import '../db/dao/bookDap.dart';
import '../plugin/batteryMethod.dart';

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
  int? batteryLevel;

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
                testDb2();
              },
              child: Text('Second Button'),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  batteryLevel == null
                      ? const SizedBox.shrink()
                      : Text(
                          'Battery Level: $batteryLevel',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () async {
                      try {
                        final result = await getBatteryLevel();
                        setState(() {
                          batteryLevel = result;
                        });
                      } catch (error) {
                        if (!context.mounted) return;
                        print("get Battery error:$error");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text(
                              (error as dynamic).message as String,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Get Battery Level'),
                  ),
                ],
              ),
            )
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

Future<void> testDb2() async {
  var bookChapterDao = BookChapterDao();
  // 查询所有数据
  var bookChapter = await bookChapterDao.getAll();
  print("bookChapter table data:$bookChapter");
}
