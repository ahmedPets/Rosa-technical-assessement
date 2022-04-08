import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:technical_assessement/constants/strings.dart';
import 'package:technical_assessement/constants/colors.dart';
import 'package:technical_assessement/models/slot.dart';
import 'package:technical_assessement/services/network.dart';
import 'calendar.dart';
import 'drop_down.dart';
import 'radio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Calendar _calendar = Calendar();
  late final DropDownQuestion _dropDownQuestion = DropDownQuestion(calendar: _calendar);
  late final RadioButtonQuestion _radioButtonQuestion = RadioButtonQuestion(calendar: _calendar);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                kStringAvailability,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kColorMain),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_radioButtonQuestion, _dropDownQuestion],
            ),
            _calendar,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: ElevatedButton.icon(
                  label: const Text(kStringBook),
                  icon: const Icon(Icons.check),
                  onPressed: () => {
                    setState(() {
                      if (_calendar.selectedDate == null)
                        print('Please select a date');
                      else
                        print('click on: ${_dropDownQuestion.motive} - ${_radioButtonQuestion.isNewPatient} => ${_calendar.selectedDate}');
                    })
                  },
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 50,
                    )),
                    backgroundColor: MaterialStateProperty.all(kColorMain),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
