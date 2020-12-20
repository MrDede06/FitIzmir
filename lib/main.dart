import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitizmir/screens/auth_screen.dart';
import 'package:fitizmir/screens/home_screen.dart';
import 'package:fitizmir/screens/hazir_diyetler_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Izmir',
      theme: ThemeData(
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
      },
    );
  }
}
