import 'package:flutter/material.dart';
import 'package:onboarding_screen/screens.dart/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'screens.dart/home_screen.dart';

//Show Onboarding Screen and then go to Home Page.
//If onboarding screen was shown once dont't
//show it again (Shared Preferences to save the bool value).

void main() async {
  //to use SharedPrefs before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  final bool showHome;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: showHome ? HomeScreen() : const OnBoardingScreen(),
    );
  }
}
