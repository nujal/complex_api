import 'package:api_practice/posts_screen.dart';
import 'package:api_practice/photos_screen.dart';
import 'package:api_practice/products_screen.dart';
import 'package:api_practice/sign_up.dart';
import 'package:api_practice/users_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController _pageController = new PageController();

  final List<Widget> _pages = [
    SignUpSCreen(),
    PostsScreen(),
    PhotoScreen(),
    UsersScreen(),
    ProductsScreen(),
  ];
  final items = <Widget>[
    Icon(Icons.person),
    Icon(Icons.post_add_outlined),
    Icon(Icons.photo_album_rounded),
    Icon(Icons.people),
    Icon(Icons.shopping_basket_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        animationCurve: Curves.easeOut,
        animationDuration: const Duration(milliseconds: 300),
        height: 55,
        items: items,
        color: Colors.grey,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.blueGrey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(_currentIndex);
        },
      ),
    );
  }
}
