import 'dart:developer';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    log("ffffffffffffffffffff");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/welcomeimage.png',
              height: 150.0, // Set the height as needed
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Welcome to the Covoiturage App!',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Have a better sharing experience.',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Create Account page
                Navigator.pushNamed(context, '/createAccount');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 158, 98)),
              child: const Text('Create an account',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Log In page
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 222, 244, 223)),
              child: const Text('Log In',
                  style: TextStyle(color: Color.fromARGB(255, 2, 158, 98))),
            ),
          ],
        ),
      ),
    );
  }
}
