import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';
import 'package:nagarik/bottom_nav_bar.dart';

class Profile extends StatelessWidget {
  const Profile({required this.switchTab, super.key});

  final void Function(int index) switchTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pastel,
          title: const Text("Hi, John"),
          toolbarHeight: 50,
          leadingWidth: 100,
          leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: const Image(
                image: NetworkImage("https://plchldr.co/i/500x250")),
          ),
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.more_vert))
          ],
        ),
        body: const Center(
          child: Text("Profile"),
        ),
        bottomNavigationBar: MyBottomNavBar(
          currentTabIndex: 3,
          switchTab: switchTab,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          shape: CircleBorder(),
          backgroundColor: blue,
          child: Icon(Icons.qr_code, color: white),
        ));
  }
}
