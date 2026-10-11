import 'package:flutter/material.dart';
import 'package:hizashi/screens/browse/BrowseScreen.dart';
import 'package:hizashi/screens/manga/MangaHomeScreen.dart';
import 'package:hizashi/screens/more/MoreScreen.dart';
import 'package:hizashi/screens/novel/NovelHomeScreen.dart';
import 'package:hizashi/screens/updates/UpdatesScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final _pages = [
    MangaHomeScreen(),
    NovelHomeScreen(),
    UpdatesScreen(),
    BrowseScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value)=>{
          setState(() {
            _currentPageIndex = value;
          })
        }
        ,
        selectedIndex: _currentPageIndex,
        destinations: [
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          label: "Manga",
          selectedIcon: Icon(Icons.menu_book),
        ),

        // novel
        NavigationDestination(
          icon: Icon(Icons.auto_stories_outlined),
          label: "Novel",
          selectedIcon: Icon(Icons.auto_stories),
        ),

        // updates
        NavigationDestination(
          icon: Icon(Icons.update_outlined),
          label: "Updates",
          selectedIcon: Icon(Icons.update),
        ),

        // browse
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          label: "Browse",
          selectedIcon: Icon(Icons.explore),
        ),

        // more
        NavigationDestination(
          icon: Icon(Icons.more_horiz),
          label: "More",
          selectedIcon: Icon(Icons.more_horiz),
        ),
      ]),
    );
  }
}