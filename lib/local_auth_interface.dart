import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    try {
      bool authenticationAvailable = await auth.isDeviceSupported();
      return authenticationAvailable;
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometricsList() async {
    try {
      return auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e.message);
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    try {
      return auth.authenticate(
          localizedReason: "Authenticate using biometrics");
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }
}
