import 'package:covoiturage/components/colors.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key, required this.onNavigate});

  final Function(int) onNavigate;

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 60,
      elevation: 0,
      animationDuration: const Duration(seconds: 3),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: AppColors.whiteColor,
      selectedIndex:
          _currentIndex, // Use 'selectedIndex' instead of 'currentIndex'
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
        widget.onNavigate(index);
      },
      destinations: [
        NavigationDestination(
          icon: Image.asset("assets/images/ic_home.png", width: 24, height: 24),
          label: "Home",
        ),
        NavigationDestination(
          icon: Image.asset("assets/images/add.png", width: 24, height: 24),
          label: "Add",
        ),
        NavigationDestination(
            icon: Image.asset("assets/images/ic_profile.png",
                width: 24, height: 24),
            label: "Profile"),
      ],
    );
  }
}
