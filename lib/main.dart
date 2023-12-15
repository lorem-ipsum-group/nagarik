import 'package:flutter/material.dart';
import 'package:nagarik/local_auth_interface.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "nagarik app",
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('ne'), // Nepali
        ],
        //if button is clicked locale should be chosen like this
        locale: Locale('ne'),
        debugShowCheckedModeBanner: false,
        home: AuthenticationPage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(AppLocalizations.of(context).nagarik),
      ),
      body: Center(child: Text(AppLocalizations.of(context).helloWorld)),
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(AppLocalizations.of(context).authenticate),
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
                            builder: (_) => const HomePage()));
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
                                                    const HomePage()));
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
