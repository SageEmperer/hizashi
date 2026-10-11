import 'package:flutter/material.dart';



class MangaHomeScreen extends StatefulWidget {
  const MangaHomeScreen({super.key});

  @override
  State<MangaHomeScreen> createState() => _MangaHomeScreenState();
}

class _MangaHomeScreenState extends State<MangaHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manga"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Manga"),
        ),
      ),
    );
  }
}