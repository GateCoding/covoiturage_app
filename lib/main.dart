import 'package:covoiturage/components/theme.dart';
import 'package:covoiturage/pages/add_offer.dart';
import 'package:covoiturage/pages/auth_page.dart';
import 'package:covoiturage/pages/detail_page.dart';
import 'package:covoiturage/pages/home_page.dart';
import 'package:covoiturage/pages/ticket_page.dart';
import 'package:covoiturage/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      home: const AuthPage(), // Use AuthPage as the initial page
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case NamedRoutes.homeScreen:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case NamedRoutes.detailScreen:
            return MaterialPageRoute(
              builder: (_) => const DetailPage(),
              settings: settings,
            );
          case NamedRoutes.ticketScreen:
            return MaterialPageRoute(
              builder: (context) => const TicketPage(),
              settings: settings,
            );
          case NamedRoutes.addScreen:
            return MaterialPageRoute(
              builder: (context) => const AddOfferPage(),
              settings: settings,
            );
          default:
            return MaterialPageRoute(builder: (context) => const AuthPage());
        }
      },
    );
  }
}
