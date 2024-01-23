import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(textDirection: TextDirection.ltr, "书架页面，开发中"),
      ),
    );
  }
}
