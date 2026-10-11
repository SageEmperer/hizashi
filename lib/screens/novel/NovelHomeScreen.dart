import 'package:flutter/material.dart';


class NovelHomeScreen extends StatefulWidget {
  const NovelHomeScreen({super.key});

  @override
  State<NovelHomeScreen> createState() => _NovelHomeScreenState();
}

class _NovelHomeScreenState extends State<NovelHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novel"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Novel"),
        ),
      ),
    );
  }
}