import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    required this.currentTabIndex,
    required this.switchTab,
    super.key
  });

  final int currentTabIndex;
  final void Function(int index) switchTab;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 50,
        height: 80,
        notchMargin: 6.0,
        shape: const CircularNotchedRectangle(),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        shadowColor: Colors.black,
        surfaceTintColor: pastel,
        color: pastel,
        child: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              textTheme:
                  GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: currentTabIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: red,
            unselectedItemColor: red,
            backgroundColor: Colors.transparent,
            iconSize: 20,
            selectedIconTheme: const IconThemeData(size: 30),
            onTap: (int index) {
              switchTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner), label: "Documents"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications,
                  ),
                  label: "Notifications"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ));
  }
}
