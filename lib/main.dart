import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),


      home:AnimatedSplashScreen(
        splash: Image.asset('assets/images/CERTLogo.png'),
        nextScreen: Login(),
        splashTransition: SplashTransition.scaleTransition,
        duration: 1000,


      ),

      debugShowCheckedModeBanner: false,
    );
  }
}
