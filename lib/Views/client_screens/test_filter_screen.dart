import 'package:flutter/material.dart';

class TestFilterScreen extends StatefulWidget {
  const TestFilterScreen({Key? key}) : super(key: key);

  @override
  State<TestFilterScreen> createState() => _TestFilterScreenState();
}

class _TestFilterScreenState extends State<TestFilterScreen> {
  List multipleSelected = [];
  List genderList = [
    {
      "id": "male",
      "value": false,
      "title": "Male",
    },
    {
      "id": 1,
      "value": false,
      "title": "Female",
    },
    {
      "id": 2,
      "value": false,
      "title": "Unspecified",
    },
  ];
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "Sunday",
    },
    {
      "id": 1,
      "value": false,
      "title": "Monday",
    },
    {
      "id": 2,
      "value": false,
      "title": "Tuesday",
    },
    {
      "id": 3,
      "value": false,
      "title": "Wednesday",
    },
    {
      "id": 4,
      "value": false,
      "title": "Thursday",
    },
    {
      "id": 5,
      "value": false,
      "title": "Friday",
    },
    {
      "id": 6,
      "value": false,
      "title": "Saturday",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
        child: Column(
          children: [
            Column(
              children: List.generate(
                genderList.length,
                    (index) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    genderList[index]["title"],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  value: genderList[index]["value"],
                  onChanged: (value) {
                    setState(() {
                      genderList[index]["value"] = value;
                      if (multipleSelected.contains(genderList[index])) {
                        multipleSelected.remove(genderList[index]);
                      } else {
                        multipleSelected.add(genderList[index]);
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 64.0),
            Text(
              multipleSelected.isEmpty ? "" : multipleSelected.toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
