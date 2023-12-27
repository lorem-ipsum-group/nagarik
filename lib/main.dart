import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  DocumentTileItem(
      title: "Citizenship",
      id: "xxxxxxxxxx",
      unlink: null,
      subtitle: "Ministry of Home Affairs")
];

var notifications = [
  NotificationTileItem(
      title: "Alert",
      dateTime: DateTime.now(),
      message:
          "This is an alert! Hello there general Kenobi. Trying to make this multiline")
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "nagarik app",
        theme: ThemeData(
            textTheme:
                GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        home: const AuthenticationPage());
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentTabIndex = 0;

  void switchTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    tabs = <Widget>[
      Home(switchTab: switchTab),
      Documents(switchTab: switchTab, issuedDocuments: issuedDocuments),
      Notifications(switchTab: switchTab, notifications: notifications),
      Profile(
        switchTab: switchTab,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "nagarik app",
        theme: ThemeData(
            textTheme:
                GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        home: tabs[_currentTabIndex]);
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
        backgroundColor: white,
        body: Center(
          child: Column(children: [
            Container(
              height: 150,
              width: 450,
              decoration: const BoxDecoration(
                  color: red,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: const Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'Login',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: white, fontSize: 48),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text('You can login directly with fingerprint.',
                style: TextStyle(
                  color: Color.fromARGB(255, 67, 66, 66),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 60),
            const Icon(Icons.fingerprint_outlined, size: 200, color: red),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () async {
                bool isBiometricAvailable = await LocalAuth.canAuthenticate();

                if (isBiometricAvailable) {
                  bool authorized = await LocalAuth.authenticate();
                  if (authorized) {
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const Root()));
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
                                            builder: (_) => const Root()));
                                  },
                                  child: const Center(child: Text("Continue")))
                            ],
                          ));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  fixedSize: const Size.fromWidth(300),
                  shadowColor: Colors.black),
              child: const Center(
                child: Text(
                  "Authenticate",
                  style: TextStyle(color: white, fontSize: 24),
                ),
              ),
            )
          ]),
        ));
  }
}
