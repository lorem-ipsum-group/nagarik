import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';

class GovDocuments extends StatelessWidget {
  const GovDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Secure Documents',
            style: TextStyle(
              color: red, // Assuming red is defined in my_colors.dart
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30,),
            const SizedBox(
              width:300,
              child: Text(
              'Link your citizenship, PAN card, Passport, Covid Vaccination, and academic documents.',
              style: TextStyle(
                color: darkGrey, // Assuming red is defined in my_colors.dart
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
                          ),
            ),
          const SizedBox(height: 50),
          Image.asset(
            'assets/onboarding-2.png', // Replace with your image path
            height: 250,
            width: 250,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
