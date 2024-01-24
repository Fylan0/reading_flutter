// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

import '../data/BookEntity.dart';

/// 书店页面

const bookstoreRouter = "/bookstore";

class BookstoreScreen extends StatefulWidget {
  Future<List<BookEntity>> fetchBookList() async {
    // 在这里实现异步逻辑，例如从网络请求数据
    // ...
    // 模拟异步操作，返回一个书籍列表
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      10,
      (index) => BookEntity(
        bookName: 'Book Name $index',
        bookAuthor: 'Author $index',
        bookCover:
            'https://img.iplaysoft.com/wp-content/uploads/2019/free-images/free_stock_photo_2x.jpg!0x0.webp',
        bookShortIntro: 'ShortIntro $index',
      ),
    );
  }

  const BookstoreScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _BookstoreState();
  }
}

class _BookstoreState extends State<BookstoreScreen> {
  late Future<List<BookEntity>> _bookListFuture;

  @override
  void initState() {
    super.initState();
    // 在 initState 中触发异步加载
    _bookListFuture = widget.fetchBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("书店")),
        body: FutureBuilder(
            future: _bookListFuture,
            builder: (context, AsyncSnapshot<List<BookEntity>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // 加载中的 UI
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<BookEntity> bookList = snapshot.data!;
                //!!!！！！！GridView  真难用！！！！
                return GridView.builder(
                  // padding: const EdgeInsets.only(left: 10, right: 10),
                  itemCount: bookList.length, // 你的列表项数量
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 一行显示的数量
                    crossAxisSpacing: 8.0, // 横轴方向上的间距
                    mainAxisSpacing: 8.0, // 纵轴方向上的间距
                    // childAspectRatio: 0.8, // 设置纵横比例，根据实际需求调整
                    mainAxisExtent: 230,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GridItem(index: index, bookEntity: bookList[index]);
                  },
                );
              }
            }));
  }
}

class GridItem extends StatelessWidget {
  final int index;
  final BookEntity bookEntity;

  const GridItem({super.key, required this.index, required this.bookEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // 卡片圆角
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              child: ClipRRect(
                  // borderRadius: const BorderRadius.all(Radius.circular(2)),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.network(
                    bookEntity.bookCover,
                    height: 160,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // 加载失败时显示兜底图
                      return Image.asset('assets/placeholder_image.png',
                          height: 160, fit: BoxFit.cover);
                    },
                  ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bookEntity.bookName,
              maxLines: 2,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
