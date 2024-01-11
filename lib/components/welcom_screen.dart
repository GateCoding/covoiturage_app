// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/welcomeimage.png',
              height: 150.0, // Set the height as needed
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Have a better sharing experience.',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Create Account page
                Navigator.pushNamed(context, '/createAccount');
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 2, 158, 98)),
              child: Text('Create an account',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Log In page
                Navigator.pushNamed(context, '/logIn');
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 222, 244, 223)),
              child: Text('Log In',
                  style: TextStyle(color: Color.fromARGB(255, 2, 158, 98))),
            ),
          ],
        ),
      ),
    );
  }
}
