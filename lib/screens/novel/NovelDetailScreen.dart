import 'package:flutter/material.dart';

class NovelDetailScreen extends StatefulWidget {
  final String sourceId;
  final String novelId;

  const NovelDetailScreen({super.key, required this.sourceId, required this.novelId});

  @override
  State<NovelDetailScreen> createState() => _NovelDetailScreenState();
}

class _NovelDetailScreenState extends State<NovelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novel Detail"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Novel Detail"),
        ),
      ),
    );
  }
}