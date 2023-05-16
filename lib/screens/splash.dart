import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_streak/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (ctx) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage("assets/dumbell.png"),
                width: 200,
              ),
              SizedBox(
                height: 50,
              ),
              SpinKitSquareCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ]),
      ),
    );
  }
}
