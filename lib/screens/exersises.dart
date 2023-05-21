import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_streak/models/exersise.dart';
import 'package:intl/intl.dart';

import '../utils/database_helper.dart';

class Exersises extends StatefulWidget {
  String title;
  AssetImage assetImage;
  Exersises({required this.title, required this.assetImage});

  @override
  _ExersisesState createState() =>
      _ExersisesState(title: title, assetImage: assetImage);
}

class _ExersisesState extends State<Exersises> {
  DatabaseHelper helper = DatabaseHelper();
  int count = 0;
  List<Exersise>? exersiseList;
  List<String> tappedItems = [];
  String title;
  AssetImage assetImage;

  _ExersisesState({required this.title, required this.assetImage});
  @override
  Widget build(BuildContext context) {
    print("build called");

    if (exersiseList == null) {
      print("list is say null");
      exersiseList = <Exersise>[];
      updateListView();
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        // leading: Image(image: AssetImage("assets/circleLeft.png")),
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        // elevation: 0,
        title: Text(title),
        centerTitle: true,
        shadowColor: const Color.fromARGB(255, 28, 28, 30),
        toolbarHeight: 60,
        actions: [
          IconButton(
              onPressed: () {
                openDialog(title, context);
              },
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.white,
              ))
        ],
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      body: getExersiseList(),
    );
  }

  ListView getExersiseList() {
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      color: Colors.black,
    );
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                leading: CircleAvatar(
                  child: Image(image: assetImage),
                ),
                title: Text(
                  exersiseList![position].title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Sets : " +
                          exersiseList![position].count.toString(),
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    Text(
                      "Last Workout : " +
                          exersiseList![position].lastWorkoutDate,
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )
                  ],
                ),
                // Text(exersiseList![position].lastWorkoutDate),
                trailing: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.add_box,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        openSetDialog(exersiseList![position]);
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Add Set",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                children: [getStatsBox(exersiseList![position])],
              ));
        });
  }

  openSetDialog(exersise) {
    TextEditingController set1TextController = TextEditingController();
    TextEditingController set2TextController = TextEditingController();
    TextEditingController set3TextController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ADD SET"),
            content: Container(
              height: 144,
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    controller: set1TextController,
                    decoration: InputDecoration(hintText: 'Enter Set 1 Data'),
                  ),
                  TextField(
                    autofocus: true,
                    controller: set2TextController,
                    decoration: InputDecoration(hintText: 'Enter Set 2 Data'),
                  ),
                  TextField(
                    autofocus: true,
                    controller: set3TextController,
                    decoration: InputDecoration(hintText: 'Enter Set 3 Data'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    submitSet(exersise, set1TextController.text,
                        set2TextController.text, set3TextController.text);
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  void submitSet(exersise, s1, s2, s3) {
    Navigator.of(context).pop();
    exersise = processExersiseData(exersise, s1, s2, s3);
    _save(exersise);
  }

  getStatsBox(Exersise exersise) {
    return Container(
        child: DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Set',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Avg Wt.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Max Wt.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Set 1')),
            DataCell(Text(exersise.set1Avg.toString())),
            DataCell(Text(exersise.set1High.toString())),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Set 2')),
            DataCell(Text(exersise.set2Avg.toString())),
            DataCell(Text(exersise.set2High.toString())),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Set 3')),
            DataCell(Text(exersise.set3Avg.toString())),
            DataCell(Text(exersise.set3High.toString())),
          ],
        ),
      ],
    ));
  }

  getStatsElement(Exersise exersise) {
    return Container(
      width: 160,
      child: Row(
        children: [
          Column(children: [Text("Set 1"), Text("100 kg"), Text("50 kg")]),
          Column(
            children: [Text("Set 2"), Text("100 kg"), Text("50 kg")],
          ),
          Column(
            children: [Text("Set 3"), Text("100 kg"), Text("50 kg")],
          ),
        ],
      ),
    );
  }

  void updateListView() {
    helper.getExersiseList(title).then((value) {
      setState(() {
        exersiseList = value;
        count = value.length;
      });

      print("length of exersises list is :");

      print(value.length);
    });
    // print("update list caled");
    // final Future<Database> dbFuture = helper.initializeDatabase();
    // dbFuture.then((database) {
    //   Future<List<Exersise>> exersiseListFuture = helper.getExersiseList();
    //   exersiseListFuture.then((exersiseList) {
    //     setState(() {
    //       exersiseList = exersiseList;
    //       count = exersiseList.length;
    //     });
    //   });
    // });
  }

  void _save(exersise) async {
    print("we are here ");

    int result;
    if (exersise.id != null) {
      // Case 1: Update operation
      print("update is called");
      result = await helper.updateExersise(exersise);
    } else {
      // Case 2: Insert Operation
      print("save is called");
      result = await helper.insertExersise(exersise);
    }

    if (result != 0) {
      // // Success
      // Navigator.pop(context, true);

      _showAlertDialog('Status', 'Exersise Saved Successfully');
      updateListView();
    } else {
      // Failure
      // Navigator.pop(context, true);
      _showAlertDialog('Status', 'Problem Saving Exersise');
    }
  }

  processExersiseData(Exersise exersise, s1, s2, s3) {
    int oldCount = exersise.count;
    exersise.count = oldCount + 1;
    int totalOldWt = (oldCount * exersise.set1Avg).toInt();
    exersise.set1Avg = (totalOldWt + int.parse(s1)) ~/ (oldCount + 1);
    exersise.set2Avg = (totalOldWt + int.parse(s2)) ~/ (oldCount + 1);
    exersise.set3Avg = (totalOldWt + int.parse(s3)) ~/ (oldCount + 1);
    exersise.set1High = max(exersise.set1High, int.parse(s1));
    exersise.set2High = max(exersise.set2High, int.parse(s2));
    exersise.set3High = max(exersise.set3High, int.parse(s3));
    print(exersise.set1High);
    print(exersise.set2High);
    print(exersise.set3High);
    return exersise;
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  openDialog(title, context) {
    TextEditingController dialogTextController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ADD"),
            content: TextField(
              autofocus: true,
              controller: dialogTextController,
              decoration:
                  InputDecoration(hintText: 'Enter New ' + title + ' Exersise'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    submit(dialogTextController.text, title);
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  void submit(text, title) {
    Navigator.of(context).pop();
    Exersise exersise = Exersise(text,
        DateFormat.yMMMd().format(DateTime.now()), 0, title, 0, 0, 0, 0, 0, 0);
    _save(exersise);
  }
}
