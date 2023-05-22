import 'package:flutter/material.dart';
import 'package:gym_streak/globals.dart';

import '../utils/shared_pref_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextStyle textStyle = const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600);
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  SharedPreferenceService preferenceService = SharedPreferenceService();

  void updateProfile() {
    setState(() {
      preferenceService.getVal("Age").then((value) => gAge = value);
      preferenceService.getVal("Height").then((value) => gHeight = value);
      preferenceService.getVal("Weight").then((value) => gWeight = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    updateProfile();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      maxRadius: 50,
                      backgroundImage: AssetImage("assets/dp.jpeg"),
                    ),
                    Text(
                      "Aman",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                SizedBox(
                  width: 1,
                  height: 120,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Pro Member",
                      style: TextStyle(
                          color: Color.fromARGB(255, 228, 6, 6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
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
            getTextView("Age", gAge.toString(), "y/o", textStyle, context,
                preferenceService, updateProfile),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            getTextView("Height", gHeight.toString(), "cm", textStyle, context,
                preferenceService, updateProfile),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            getTextView("Weight", gWeight.toString(), "kg", textStyle, context,
                preferenceService, updateProfile),
          ],
        ),
      )),
    );
  }
}

getTextView(
    title, value, unit, textStyle, context, preferenceService, updateProfile) {
  return Container(
    margin: const EdgeInsets.only(left: 30, top: 6, right: 30),
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
              openDialog(title, context, preferenceService, updateProfile);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ))
      ],
    ),
  );
}

openDialog(title, context, preferenceService, updateProfile) {
  TextEditingController dialogTextController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: dialogTextController,
            decoration: InputDecoration(hintText: 'Enter ' + title),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  submit(context, dialogTextController.text, preferenceService,
                      title, updateProfile);
                },
                child: const Text("Save"))
          ],
        );
      });
}

void submit(context, String text, preferenceService, title, updateProfile) {
  Navigator.of(context).pop();
  if (text.isEmpty) {
    _showSnackBar(context, 'Invalid Data entered');
    return;
  }
  preferenceService.updateVal(title, int.parse(text));
  updateProfile();
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
