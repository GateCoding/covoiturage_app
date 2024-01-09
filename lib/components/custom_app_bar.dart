import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFfafafa),
      ),
      backgroundColor: const Color(0xFFfafafa),
      toolbarHeight: 0,
      elevation: 0,
    );
  }
}
