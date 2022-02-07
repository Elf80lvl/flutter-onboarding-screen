import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 2) {
                isLastPage = true;
              } else {
                isLastPage = false;
              }
            });
          },
          children: [
            buildOnBoardingScreen(
                'An onboarding screen that should be shown only once when the app starts'),
            buildOnBoardingScreen(
                'Shared Preferences is used to save the bool value "showHome". When the last page of the OnBoarding screen is shown the bool "showHome" will be set to false'),
            buildOnBoardingScreen(
                'When the last page of the OnBoarding screen is shown the buttons in the bottomSheet will change'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              child: const Text(
                'Get Started',
                style: const TextStyle(fontSize: 24),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    //borderRadius: BorderRadius.circular(16),
                    ),
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                //save the info that the onboarding screen was shown
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('SKIP'),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.blue,
                      ),
                      onDotClicked: (index) => _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: const Text('NEXT'),
                  ),
                ],
              ),
            ),
    );
  }

  Container buildOnBoardingScreen(String text) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      color: Colors.blue.shade300,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
