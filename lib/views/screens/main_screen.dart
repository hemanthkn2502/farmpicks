import 'package:farmpicks/views/screens/account_screen.dart';
import 'package:farmpicks/views/screens/cart_screen.dart';
import 'package:farmpicks/views/screens/category_screen.dart';
import 'package:farmpicks/views/screens/favorite_screen.dart';
import 'package:farmpicks/views/screens/home_screen.dart';
import 'package:farmpicks/views/screens/upload_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
    UploadScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        selectedItemColor: Colors.pink,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/store-1.png',
                width: 20,
              ),
              label: 'HOME'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/explore.svg'),
              label: 'CATEGORIES'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cart.svg'),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/favorite.svg'),
            label: 'FAVORITE',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg'),
            label: 'ACCOUNT',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle_fill,
            color: Colors.black,
              size: 30,
            ),
            label: 'UPLOAD',

          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
