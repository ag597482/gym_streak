import 'package:flutter/material.dart';

class SiteAbooutScreen extends StatefulWidget {


  @override
  _SiteAbooutScreenState createState() => _SiteAbooutScreenState();
}

class _SiteAbooutScreenState extends State<SiteAbooutScreen> {
  List<String> tappedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 74.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _stuff
                  .map(
                    (strings) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (tappedItems.contains(strings)) {
                            tappedItems.remove(strings);
                          } else {
                            tappedItems.add(strings);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            color: tappedItems.contains(strings)
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          strings,
                          style: TextStyle(
                              fontSize: 14,
                              color: tappedItems.contains(strings)
                                  ? Colors.white
                                  : Color(0xff929292)),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  List<String> _stuff = [
    'Portfolio',
    'Art',
    'Marketing',
    'Education',
    'Blog',
    'Travel',
    'Fashion',
    'Beauty',
    'Design',
    'Online Store',
    'Fitness',
    'Food'
  ];
}