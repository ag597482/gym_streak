import 'package:flutter/material.dart';

import '../utils/shared_pref_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int age = 0;
  int? dbAge;
  int weight = 0;
  int? dbweight;
  int height = 0;
  int? dbHeight;
  TextStyle textStyle =
      const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600);
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  SharedPreferenceService preferenceService = SharedPreferenceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        maxRadius: 50,
                        child: Text(
                          "A",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 70),
                        )),
                    Text(
                      "Aman",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
                SizedBox(
                  width: 1,
                  height: 120,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pro Member",
                      style: TextStyle(
                          color: Color.fromARGB(255, 228, 6, 6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      "last workout",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "2 days ago",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              indent: 5,
              endIndent: 5,
              color: Colors.grey,
            ),
            getTextView("Age", "26", "y/o", textStyle, context),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            getTextView("Height", "176", "cm", textStyle, context),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            getTextView("Weight", "64", "kg", textStyle, context),
          ],
        ),
      )),
    );
  }
}

getTextView(title, value, unit, textStyle, context) {
  return Container(
    margin: EdgeInsets.only(left: 30, top: 6, right: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title + " : " + value + " " + unit,
          style: textStyle,
          textAlign: TextAlign.left,
        ),
        IconButton(
            alignment: Alignment.topRight,
            onPressed: () {
              openDialog(title, context);
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ))
      ],
    ),
  );
}

openDialog(title, context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter ' + title),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  submit(context);
                },
                child: Text("Save"))
          ],
        );
      });
}

void submit(context) {
  Navigator.of(context).pop();
}
