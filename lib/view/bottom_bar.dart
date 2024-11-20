import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/bottom_provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomProvider>(
      builder: (context, bottomProvider, child) {
        return Scaffold(
          body: bottomProvider.pages[bottomProvider.currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16), // Add padding for spacing
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30), // Rounded corners
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Shadow effect
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true, // Display labels if needed
                  showUnselectedLabels: false,
                  currentIndex: bottomProvider.currentIndex,
                  onTap: (index) {
                    // Update the currentIndex in BottomProvider
                    bottomProvider.onTabTapped(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: "Notifications",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
