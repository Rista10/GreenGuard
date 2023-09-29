import 'package:flutter/material.dart';
import 'package:green_guard/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  navigateToHome()async{
    await Future.delayed(Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Logo.png")
            )
          ),
        ),
      ),
    );
  }
}