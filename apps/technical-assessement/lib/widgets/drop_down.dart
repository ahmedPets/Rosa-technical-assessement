import 'package:flutter/material.dart';
import 'package:technical_assessement/widgets/calendar.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';

class DropDownQuestion extends StatefulWidget {
  final Calendar calendar;
  String _dropDownValue = kStringListDropDown[0];

  DropDownQuestion({Key? key, required this.calendar}) : super(key: key);

  String get motive => _dropDownValue;

  @override
  _DropDownQuestionState createState() => _DropDownQuestionState();
}

class _DropDownQuestionState extends State<DropDownQuestion> {

  void dropDownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        widget._dropDownValue = selectedValue;
        widget.calendar.setMotive(selectedValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            kStringReason,
            style: TextStyle(
              fontSize: 20,
              color: kColorText
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15),
          child: SizedBox(
            width: 500,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: kStringListDropDown.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      color: kColorMain
                    ),
                  ),
                );
              }).toList(),
              value: widget._dropDownValue,
              onChanged: dropDownCallback,
            ),
          ),
        ),
      ],
    );
  }
}