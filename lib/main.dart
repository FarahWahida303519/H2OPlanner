import 'package:flutter/material.dart';
import 'drinkcal.dart';//to use file drinkcal

void main() {
  runApp(const MainApp());// start the app
}

class MainApp extends StatelessWidget {//
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplashScreen());//set first screen is splashsreen page
  }
}

class SplashScreen extends StatefulWidget {//the screen needs to change after 6 seconds.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {//run once only
    // call when splash sreen is created
    super.initState();
    Future.delayed(Duration(seconds: 6), () {// sett a timer for wait 6 sec before go to next page
     
      Navigator.pushReplacement(//this code will replace the current page(cant go back to splash screen)
        context,
        MaterialPageRoute(builder: (context) =>  drinkCal()),//will go to next page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//basic layout structure like bg,body
    //set bg color
      backgroundColor:  const Color.fromARGB(255, 241, 246, 255),
      body: Center(
        //arranges widget in vertical
        child: Column(
          //set as center widget vertical
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //display image
            Image.asset('assets/logo.png', scale: 2),
            
            //shows spinning loader
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}







