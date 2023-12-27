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
        home: AuthenticationPage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final tabs = const [
    home,
    documents,
    notifications,
    profile,
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
        body: widget.tabs[_currentTabIndex](),
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
            data: ThemeData(
                splashColor: Colors.transparent,
                textTheme:
                    GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
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
          backgroundColor: blue,
          child: Icon(Icons.qr_code, color: white),
        ));
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HomePage()));
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
                                            builder: (_) => const HomePage()));
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
