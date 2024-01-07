import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covoiturage/pages/addpage.dart';
import 'package:covoiturage/pages/demandpage.dart';
import 'package:covoiturage/pages/home.dart';
import 'package:covoiturage/pages/mailbox.dart';
import 'package:covoiturage/pages/profilepage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  late PageController _pageController; 

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int _currentIndex = 0;

  // List of titles corresponding to each page
  final List<String> pageTitles = ['Home', 'Mailbox', 'Add', 'Demand', 'Profile'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0); 
  }

  @override
  void dispose() {
    _pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(pageTitles[_currentIndex]), 
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
        ],
      ),
      body: PageView(
        controller: _pageController, 
        children: [
          Home(),
          MailboxPage(),
          AddOfferPage(),
          // DemandPage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut); 
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mailbox',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded),
            label: 'Add',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            backgroundColor: Colors.blue,
            label: 'Demand',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Colors.blue,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
