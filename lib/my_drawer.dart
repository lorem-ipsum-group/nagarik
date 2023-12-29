import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';
import 'package:nagarik/chat_screen.dart';
import 'package:nagarik/main.dart';

Drawer myDrawer(BuildContext context) {
  return Drawer(
    elevation: 5,
    backgroundColor: white,
    width: 220,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: lightBlue,
          ),
          child: Center(
            child: Image.asset('assets/logo.png', width: 100, height: 100),
          ),
        ),
        ListTile(
          title: const Center(
              child: Text('Live Chat',
                  style: TextStyle(
                      color: lightGrey, fontWeight: FontWeight.w400))),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const ChatScreen()));
          },
        ),
        ListTile(
          title: const Center(
              child: Text(
            'Logout',
            style: TextStyle(color: lightGrey, fontWeight: FontWeight.w400),
          )),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AuthenticationPage()),
            );
          },
        ),
      ],
    ),
  );
}
