import 'package:flutter/material.dart';
import 'package:gym_streak/globals.dart';
import 'package:gym_streak/screens/exersises.dart';

import '../utils/shared_pref_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferenceService preferenceService = SharedPreferenceService();

  void updateStreak() {

      preferenceService.getVal("LastWorkoutTime").then((value) {
        int dtNow = DateTime.now().millisecondsSinceEpoch ~/ 86400000;
        int dtDiff = dtNow - value;
    setState(() {
        if (dtDiff > 1) {
          preferenceService.updateVal("Streak", 0);
          gStreak = 0;
        } else {
          preferenceService
              .getVal("Streak")
              .then((streakDBValue) => gStreak = streakDBValue);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    updateStreak();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: const Image(
                      image: AssetImage("assets/fire.png"),
                      width: 160,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 25),
                    child: const Text(
                      "Welcome",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 110),
                      child: Text(
                        gStreak.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 60,
                        ),
                      )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 180),
                    child: const Text(
                      "Day Streak",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            getGridView(context),
          ]),
        ),
      ),
    );
  }
}

getGridView(BuildContext context) {
  return CustomScrollView(
    primary: false,
    shrinkWrap: true,
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(10),
        sliver: SliverGrid.count(
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          children: <Widget>[
            getBodyPartContainer(
                const AssetImage("assets/back.png"), "Back", context),
            getBodyPartContainer(
                const AssetImage("assets/chest.png"), "Chest", context),
            getBodyPartContainer(
                const AssetImage("assets/shoulder.png"), "Shoulder", context),
            getBodyPartContainer(
                const AssetImage("assets/triceps.png"), "Triceps", context),
            getBodyPartContainer(
                const AssetImage("assets/biceps.png"), "Biceps", context),
            getBodyPartContainer(
                const AssetImage("assets/leg.png"), "Legs", context),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            getBodyPartContainer(
                const AssetImage("assets/abs.png"), "Abs", context),
          ],
        ),
      ),
    ],
  );
}

getBodyPartContainer(AssetImage image, var text, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Exersises(
            title: text,
            assetImage: image,
          ),
        ),
      );
      // Navigator.pushNamed(context, "list");
    },
    child: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.all(6),
      child: Image(
        image: image,
      ),
    ),
  );
}
