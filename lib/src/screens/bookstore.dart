// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

/// 书店页面

const bookstoreRouter = "/bookstore";

class BookstoreScreen extends StatefulWidget {
  const BookstoreScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookstoreState();
  }
}

class _BookstoreState extends State<BookstoreScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(textDirection: TextDirection.ltr, "书店页面，开发中……"),
      ),
    );
  }
}
