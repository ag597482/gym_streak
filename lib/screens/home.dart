import 'package:flutter/material.dart';
import 'package:gym_streak/screens/exersises.dart';

class Home extends StatefulWidget {
 const Home({super.key});

 @override
 State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color.fromARGB(255, 28, 28, 30),
     body: Column(children: [
       Container(
         alignment: Alignment.center,
         child: Stack(
           children: <Widget>[
             Container(
               margin: EdgeInsets.only(top: 20),
               alignment: Alignment.center,
               child: Image(
                 image: AssetImage("assets/fire.png"),
                 width: 160,
               ),
             ),
             Container(
               alignment: Alignment.center,
               margin: EdgeInsets.only(top: 15),
               child: Text(
                 "Hello Aman",
                 style: TextStyle(color: Colors.white, fontSize: 50),
               ),
             ),
             Container(
                 alignment: Alignment.center,
                 margin: EdgeInsets.only(top: 110),
                 child: Text(
                   '10',
                   style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.w900,
                     fontSize: 60,
                   ),
                 )),
             Container(
               alignment: Alignment.bottomCenter,
               margin: EdgeInsets.only(top: 180),
               child: Text(
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
               AssetImage("assets/back.png"), "Back", context),
           getBodyPartContainer(
               AssetImage("assets/chest.png"), "Chest", context),
           getBodyPartContainer(
               AssetImage("assets/shoulder.png"), "Shoulder", context),
           getBodyPartContainer(
               AssetImage("assets/triceps.png"), "Triceps", context),
           getBodyPartContainer(
               AssetImage("assets/biceps.png"), "Biceps", context),
           getBodyPartContainer(AssetImage("assets/leg.png"), "Legs", context),
           SizedBox(
             height: 10,
             width: 10,
           ),
           getBodyPartContainer(AssetImage("assets/abs.png"), "Abs", context),
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
           builder: (context) => Exersises(title: text, assetImage: image,),
         ),
       );
     // Navigator.pushNamed(context, "list");
   },
   child: Container(
     alignment: Alignment.center,
     decoration: BoxDecoration(
         color: Colors.red,
         borderRadius: BorderRadius.all(Radius.circular(8))),
     padding: const EdgeInsets.all(6),
     child: Image(image: image,
     ),
   ),
 );
}
