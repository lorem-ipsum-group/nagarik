import 'package:flutter/material.dart';
import 'package:nagarik/local_auth_interface.dart';
import 'package:nagarik/home.dart';
import 'package:nagarik/documents.dart';
import 'package:nagarik/notifications.dart';
import 'package:nagarik/profile.dart';
import 'package:nagarik/my_colors.dart';

void main() {
  runApp(const MyApp());
}

var issuedDocuments = [
  DocumentTileItem(title: "Citizenship", id: "xxxxxxxxxx", unlink: null)
];

var notifications = [
  NotificationTileItem(title: "Alert", dateTime: DateTime.now(), message: "This is an alert! Hello there general Kenobi. Trying to make this multiline")
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "nagarik app",
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Widget> tabs = <Widget>[
    const Home(),
    Documents(issuedDocuments: issuedDocuments,),
    Notifications(notifications: notifications),
    const Profile()
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

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
        body: (widget.tabs[_currentTabIndex]),
        bottomNavigationBar: BottomAppBar(
          elevation: 50,
          height: 80,
          notchMargin: 6.0,
          shape: const CircularNotchedRectangle(),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          shadowColor: Colors.black,
          surfaceTintColor: pastel,
          color: pastel,
          child: Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: _currentTabIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: red,
              unselectedItemColor: red,
              backgroundColor: Colors.transparent,
              iconSize: 20,
              selectedIconTheme: const IconThemeData(size: 30),
              onTap: (int index) {
                setState(() {
                  _currentTabIndex = index;
                });
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
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          shape: CircleBorder(),
          child: Icon(Icons.qr_code),
        ));
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightBlue,
          title: const Text("Authenticate"),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint_outlined),
              const SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () async {
                    bool isBiometricAvailable =
                        await LocalAuth.canAuthenticate();

                    if (isBiometricAvailable) {
                      bool authorized = await LocalAuth.authenticate();
                      if (authorized) {
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => HomePage()));
                      }
                    } else {
                      if (!context.mounted) return;
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: const Text("Biometrics Unavailable"),
                                content: const Text(
                                    "Biometric authentication is not available"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HomePage()));
                                      },
                                      child:
                                          const Center(child: Text("Continue")))
                                ],
                              ));
                    }
                  },
                  child: const Center(
                    child: Text("Authenticate"),
                  ))
            ]));
  }
}
