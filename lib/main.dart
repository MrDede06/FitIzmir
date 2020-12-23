import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitizmir/screens/auth_screen.dart';
import 'package:fitizmir/screens/home_screen.dart';
import 'package:fitizmir/screens/hazir_diyetler_screen.dart';
import 'package:fitizmir/screens/hazir_diyet_detay_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Izmir',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.white,
        accentColor: Colors.black87,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomeScreen();
            }
            return AuthScreen();
          }),
      routes: {
        HazirDiyetlerScreen.routeName: (ctx) => HazirDiyetlerScreen(),
        HazirDiyetlerDetayScreen.routeName: (ctx) => HazirDiyetlerDetayScreen(),
      },
    );
  }
}
