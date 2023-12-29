// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:nagarik/intro_screens/1_nid_page.dart';
import 'package:nagarik/intro_screens/2_gov_documents.dart';
import 'package:nagarik/main.dart';
import 'package:nagarik/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();

  // keep track of the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 1);
              });
            },
            children: const [
              NIDPage(),
              GovDocuments(),
            ],
          ),
          // dot indicators
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const AuthenticationPage();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red, // button fill color
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: white), // text color
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 2,
                  effect: const JumpingDotEffect(
                    activeDotColor: red,
                    dotColor: fadedRed
                  )

                ),
                onLastPage
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const AuthenticationPage();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red, // button fill color
                        ),
                        child: const Text(
                          'Done',
                          style: TextStyle(color: white), // text color
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red, // button fill color
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: white), // text color
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
