import 'package:flutter/material.dart';
import 'package:gym_streak/globals.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.center,
        child: Column(children: [
          const Image(
            image: AssetImage('assets/bmi.png'),
            height: 180,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "BMI : ${((gWeight * 10000) / (gHeight * gHeight)).toStringAsFixed(1)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () {},
              child: const Text(
                "Diet Chart",
                style: TextStyle(color: Colors.black),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 420,
            child: SfPdfViewer.asset(
              'assets/diet.pdf',
            ),
          ),
        ]),
      ),
    );
  }
}
