import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';
import 'package:intl/intl.dart';
import 'package:nagarik/bottom_nav_bar.dart';

class NotificationTileItem {
  const NotificationTileItem(
      {required this.title, required this.dateTime, required this.message});

  final String title;
  final DateTime dateTime;
  final String message;
}

class Notifications extends StatelessWidget {
  const Notifications(
      {required this.switchTab, required this.notifications, super.key});

  final List<NotificationTileItem> notifications;
  final void Function(int index) switchTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pastel,
          title: const Text("Notifications"),
          toolbarHeight: 50,
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.more_vert))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return notificationTile(notifications[index]);
                  }),
            )),
        bottomNavigationBar: MyBottomNavBar(
          currentTabIndex: 2,
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

Container notificationTile(NotificationTileItem item) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(color: blue),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.notification_important,
              fill: 1.0,
              color: blue,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 18, color: blue),
                  ),
                  Text(DateFormat("yyyy-MM-dd").format(item.dateTime))
                ])
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(item.message)
      ],
    ),
  );
}
