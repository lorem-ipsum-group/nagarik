import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nagarik/main.dart';
import 'package:nagarik/my_colors.dart';

enum RegistrationMethod { nid, phoneNumber }

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nidController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;

  RegistrationMethod selectedMethod = RegistrationMethod.nid;

  Future<void> checkExists(String nid) async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(nid).get();

    if (user.data() != null) {
      LocalStorage storage = LocalStorage("user_id");
      await storage.ready;
      storage.setItem("nid", nid);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AuthenticationPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('NID already exists. Please choose another one.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: DropdownButton<RegistrationMethod>(
                value: selectedMethod,
                onChanged: (method) {
                  setState(() {
                      selectedMethod = method!;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: RegistrationMethod.nid,
                    child: Text('Register with NID'),
                  ),
                  DropdownMenuItem(
                    value: RegistrationMethod.phoneNumber,
                    child: Text('Register with Phone Number'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: red, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextField(
                  controller: selectedMethod == RegistrationMethod.nid
                      ? nidController
                      : phoneNumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: selectedMethod == RegistrationMethod.nid
                        ? 'National ID (NID)'
                        : 'Phone Number',
                       
                  ),
                )),
            SizedBox(height: 50),
            Align(
              child: ElevatedButton(
              onPressed: () {
                String value = selectedMethod == RegistrationMethod.nid
                    ? nidController.text
                    : phoneNumberController.text;
                checkExists(value);
              },
              style:
                 ElevatedButton.styleFrom(
                  backgroundColor: red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  fixedSize: const Size.fromWidth(300),
                  shadowColor: Colors.black),
              child: isLoading
                  ? CircularProgressIndicator() // Show a loading indicator while querying
                  : Text('Register', style: TextStyle(color: white, fontSize: 24),),
            ),
            )
          ],
        ),
      ),
    );
  }
}
