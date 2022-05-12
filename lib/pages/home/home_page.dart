
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/cart/cart_history.dart';
import 'package:untitled/pages/cart/cart_page.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List pages = [
  MainFoodPage(),
  Container(child: Center(child: Text("Next page")),),
  CartHistory(),
  Container(child: Center(child: Text("Next next next page")),),
];



class _HomePageState extends State<HomePage> {
  int _selectedIndex =0;
  void onTapNav(int index){
setState(() {
  _selectedIndex = index;
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.mainBlackColor,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
          label:"Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label:"History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label:"Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label:"Me"),

        ],
      ),
    );
  }
}
