import 'package:flutter/material.dart';

/// 阅读页面

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ReadingState();
  }
}

class ReadingState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(textDirection: TextDirection.ltr,"阅读页面，开发中"),
      ),
    );
  }
}
