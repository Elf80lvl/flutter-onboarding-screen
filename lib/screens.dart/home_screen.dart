import 'package:flutter/material.dart';
import 'package:onboarding_screen/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The app'),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OnBoardingScreen()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Page',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 32),
              Text(
                'The Log Out button in the app bar will set the bool "showHome" to true and push to the onboarding screen again.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
