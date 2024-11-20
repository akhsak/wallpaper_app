import 'package:flutter/material.dart';
import 'package:wallpaper_app/view/notification_screen.dart';
import 'package:wallpaper_app/view/search_page.dart';
import 'package:wallpaper_app/view/home_page.dart';
import 'package:wallpaper_app/view/profile_screen.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(), 
    SearchScreen(), 
    NotificationScreen(), 
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
