import 'package:flutter/material.dart';
import 'package:hizashi/screens/browse/browseTabs/mangaSourceTab.dart';
import 'package:hizashi/screens/browse/browseTabs/novelSourceTab.dart';


class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Browse"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(tabs: [
                 Tab(
                  child: Text("Manga Source"),
                 ),
                 Tab(
                  child: Text("Novel Source"),
                 ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    MangaSourceTab(),
                    NovelSourceTab(),
                  ],
                ),
              )
            ]
          )
        ),
      ),
    );
  }
}