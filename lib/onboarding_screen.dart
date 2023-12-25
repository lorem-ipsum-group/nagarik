import 'package:flutter/material.dart';
import 'package:nagarik/intro_screens/intro_page2.dart';
import 'package:nagarik/intro_screens/intro_page3.dart';
import 'package:nagarik/intro_screens/select_language.dart';
import 'package:nagarik/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();

  //keep track of last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              SelectLanguage(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          //dot indicators
          Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text('Skip'),
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3),
                  onLastPage
                  ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context){
                        return HomePage();
                      },
                      ),
                      );
                    },
                    child: Text('Done'),
                  )
                  : GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text('Next'),
                  ),

                ],
              ))
        ],
      ),
    );
  }
}
