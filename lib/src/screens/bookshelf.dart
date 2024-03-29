import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:reading_flutter/src/db/dao/bookChapterDao.dart';
import 'package:reading_flutter/src/screens/reading.dart';
import 'package:reading_flutter/src/utils/LocalPageLoaderUtil.dart';

import '../../generated/l10n.dart';
import '../data/bookChapter.dart';
import '../data/bookEntity.dart';
import '../db/dao/bookDap.dart';
import 'bookstore.dart';

/// 书架页面

const bookshelfRouter = "/bookshelf";

class BookshelfScreen extends StatefulWidget {
  const BookshelfScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookshelfState();
  }
}

class _BookshelfState extends State<BookshelfScreen> {
  BookDao bookDao = BookDao();

  String? _filePath;

  Future<List<BookEntity>> fetchBookList() async {
    // 在这里实现异步逻辑，例如从网络请求数据
    // ...
    // 模拟异步操作，返回一个书籍列表
    // await Future.delayed(const Duration(seconds: 2));

    Future<List<BookEntity>> future = bookDao.getAll();

    return future;
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      setState(() {
        //选择文件完成
        _filePath = result.files.single.path;
        print('已选文件：$_filePath');
        _handleFilePick();
      });
    }
  }

  void _handleFilePick() async {
    BookEntity book = BookEntity();
    book.bookName = basename(_filePath!);
    book.bookAuthor = "author";
    book.bookShortIntro = "intro";

    var bookDao = BookDao();
    bookDao.insert(book);

    File file = File(_filePath!);
    List<BookChapter> bookChapters =
        (await loadChapters(file, book.bookId)).cast<BookChapter>();
    print('章节数：：${bookChapters.length}');
    var bookChapterDao = BookChapterDao();
    bookChapterDao.insertAll(bookChapters);

    Fluttertoast.showToast(msg: "添加成功");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.current.bookshelf), actions: [
          // 添加右侧的图标按钮
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // 添加本地书籍
              _pickFile();
            },
          ),
        ]),
        body: StreamBuilder<void>(
            stream: bookDao.onDatabaseChange,
            builder: (context, snapshot) {
              return FutureBuilder(
                  future: fetchBookList(),
                  builder: (context, AsyncSnapshot<List<BookEntity>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      ); // 加载中的 UI
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<BookEntity> bookList = snapshot.data!;
                      //设置点击事件
                      click(book) {
                        if (book is BookEntity) {
                          GoRouter.of(context)
                              .go('$readingRouter/${book.bookId}');
                          print('Grid item clicked ${book.toString()}');
                        }
                      }

                      //!!!！！！！GridView  真难用！！！！
                      return GridView.builder(
                        // padding: const EdgeInsets.only(left: 10, right: 10),
                        itemCount: bookList.length, // 你的列表项数量
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 一行显示的数量
                          crossAxisSpacing: 8.0, // 横轴方向上的间距
                          mainAxisSpacing: 8.0, // 纵轴方向上的间距
                          // childAspectRatio: 0.8, // 设置纵横比例，根据实际需求调整
                          mainAxisExtent: 230,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GridItem(
                              index: index,
                              bookEntity: bookList[index],
                              callback: click);
                        },
                      );
                    }
                  });
            }));
  }
}
