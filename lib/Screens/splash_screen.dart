import 'package:flutter/material.dart';
import 'package:movies/UI/home.dart';

class Splash extends StatefulWidget {
  static const String routeName="Splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),() {
      Navigator.pushReplacementNamed(context, Home.routeName);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/splash.png"),fit: BoxFit.fill)),));
  }
}
