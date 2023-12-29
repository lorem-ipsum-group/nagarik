import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';
import 'package:nagarik/bottom_nav_bar.dart';
import 'package:nagarik/my_drawer.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: red.withOpacity(0.1),
        ),
        child: Icon(icon, color: red),
      ),
      title: Text(title,
          style: TextStyle(
              color: darkGrey, fontSize: 16, fontWeight: FontWeight.w200)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: blue.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 18.0, color: blue))
          : null,
    );
  }
}

class Profile extends StatelessWidget {
  Profile({required this.switchTab, super.key});

  final void Function(int index) switchTab;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: pastel,
          title: const Text("Profile"),
          toolbarHeight: 50,
          actions: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.more_vert))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Stack(
                    children: [
                      SizedBox(
                          width: 90,
                          height: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(
                                image: AssetImage('assets/placeholder.png')),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: red),
                            child: const Icon(
                              Icons.edit,
                              color: white,
                              size: 20,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('John Doe',
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.w700)),
                  const Text('johndoe@gmail.com',
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const Text('9841222222',
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              shape: const StadiumBorder())
                          .copyWith(
                        backgroundColor: MaterialStateProperty.all(red),
                      ),
                      child: const Text("Edit Profile",
                          style: TextStyle(color: white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 7),
                  ProfileMenuWidget(
                      title: "My Details", icon: Icons.details, onPress: () {}),
                  ProfileMenuWidget(
                      title: "Set Login Info",
                      icon: Icons.lock,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Change Language",
                      icon: Icons.settings,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "My Activity",
                      icon: Icons.local_activity,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Support", icon: Icons.support, onPress: () {}),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    "App Version 1.0.0",
                    style: TextStyle(
                        fontSize: 18, color: red, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Revamped by Lorem Ipsum",
                    style: TextStyle(
                      fontSize: 12,
                      color: lightGrey,
                    ),
                  ),
                ]))),

        endDrawer: myDrawer(context),
        
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
