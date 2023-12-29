import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nagarik/firebase_options.dart';
import 'package:nagarik/local_auth_interface.dart';
import 'package:nagarik/home.dart';
import 'package:nagarik/documents.dart';
import 'package:nagarik/my_buttons.dart';
import 'package:nagarik/notifications.dart';
import 'package:nagarik/onboarding_screen.dart';
import 'package:nagarik/profile.dart';
import 'package:nagarik/my_colors.dart';
import 'package:flutter/services.dart';
import 'package:nagarik/my_document.dart';
import 'package:nagarik/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(MyApp());
}

var notifications = [
  NotificationTileItem(
      title: "Alert",
      dateTime: DateTime.now(),
      message:
          "This is an alert! Hello there general Kenobi. Trying to make this multiline")
];

var uid = "123";


List<DocumentTileItem> issuedDocuments = [];
List<IssuedDocumentItem> documentsTileList = [];
bool fetchedDocuments = false;

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Future<String> getNID() async {
    LocalStorage storage = LocalStorage("user_id");
    await storage.ready;

    return await storage.getItem("nid");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNID(),
      builder: (context, snapshot) {
        return MaterialApp(
          title: "nagarik app",
          theme: ThemeData(
            textTheme:
            GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
          debugShowCheckedModeBanner: false,
          home: snapshot.data != null ? const AuthenticationPage() : const OnboardingScreen());
        }
    );
    
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentTabIndex = 0;
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  void switchTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  final db = FirebaseFirestore.instance;

  late List<Widget> tabs;

  Future<void> unlinkDocument(String documentId, String keyToRemove) async {
    await db.collection('users').doc(documentId).update({
      'documents.$keyToRemove': FieldValue.delete(),
    });
  }

  Future<List<Widget>> initializeData() async {
    if (!fetchedDocuments) {
      issuedDocuments.clear();
      documentsTileList.clear();

      DocumentSnapshot user = await db.collection('users').doc("123").get();
      final documents = user.get("documents") as Map<String, dynamic>;

      documents.forEach((key, value) {
        issuedDocuments.add(
          DocumentTileItem(
              title:
                  key.isEmpty ? key : key[0].toUpperCase() + key.substring(1),
              id: value,
              unlink: () {
                unlinkDocument("123", key);
              },
              subtitle: "Ministry of Home Affairs",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Document(type: DocumentType.Citizenship)));
              }),
        );

        documentsTileList.add(IssuedDocumentItem(
            title: key.isEmpty ? key : key[0].toUpperCase() + key.substring(1),
            id: value,
            subtitle: "Ministry of Home Affairs",
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              SnackBar snackBar =
                  SnackBar(content: Text("Copied $key ID to clipboard"));
              snackbarKey.currentState?.showSnackBar(snackBar);
            }));
      });
    }

    return [
      Home(switchTab: switchTab, documents: documentsTileList),
      Documents(switchTab: switchTab, issuedDocuments: issuedDocuments),
      Notifications(switchTab: switchTab, notifications: notifications),
      Profile(switchTab: switchTab),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: initializeData(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator());
        // } else if (snapshot.hasError) {
        //   return Center(
        //       child: Text('Error initializing data ${snapshot.error}'));
        // } else {
          tabs = snapshot.data!;
          return MaterialApp(
            title: "nagarik app",
            scaffoldMessengerKey: snackbarKey,
            theme: ThemeData(
              textTheme:
                  GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
            ),
            debugShowCheckedModeBanner: false,
            home: tabs.isNotEmpty ? tabs[_currentTabIndex] : const SizedBox(),
          );
        }
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  final bool showSkipButton;

  const AuthenticationPage({Key? key, this.showSkipButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Center(
          child: Column(children: [
            const SizedBox(height: 100),
            const Text('FingerPrint',
                style: TextStyle(
                  color: red,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 40),
            const Text('You can login directly with fingerprint.',
                style: TextStyle(
                  color: darkGrey,
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
            ),
            SizedBox(height: 20),
            if (showSkipButton) ...[
              SizedBox(height: 20),
              Center(
                child: Text(
                  'OR',
                  style: TextStyle(color: darkGrey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const Root()));
                },
                child: const Center(
                  child: Text(
                    "Skip",
                    style: TextStyle(color: white, fontSize: 24),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    fixedSize: const Size.fromWidth(300),
                    shadowColor: Colors.black),
              )
            ],
          ]),
        ));
  }
}
