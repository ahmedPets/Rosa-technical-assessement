import 'package:flutter/material.dart';
import 'package:technical_assessement/widgets/calendar.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';

class RadioButtonQuestion extends StatefulWidget {
  bool _radioValue = true;
  Calendar calendar;

  RadioButtonQuestion({Key? key, required this.calendar}) : super(key: key);

  bool get isNewPatient => _radioValue;

  @override
  _RadioButtonQuestionState createState() => _RadioButtonQuestionState();
}

class _RadioButtonQuestionState extends State<RadioButtonQuestion> {
  void _onRadioChanged(value) {
    setState(() {
      widget._radioValue = value as bool;
      widget.calendar.setIsNewPatient(widget._radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 15, left: 15),
          child: Text(
            kStringFirstAppointement,
            style: TextStyle(
              fontSize: 20,
              color: kColorText
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 200, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                  border: Border.all(
                    color: kColorText,
                    width: 0.5
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: true,
                      groupValue: widget._radioValue,
                      onChanged: _onRadioChanged,
                      activeColor: kColorRadio,
                    ),
                    const Text(
                      kStringYes,
                      style: TextStyle(
                        fontSize: 18,
                        color: kColorMain
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 200, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                  border: Border.all(
                    color: kColorText,
                    width: 0.5
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: false,
                      groupValue: widget._radioValue,
                      onChanged: _onRadioChanged,
                      activeColor: kColorRadio,
                    ),
                    const Text(
                      kStringNo,
                      style: TextStyle(
                        fontSize: 18,
                        color: kColorMain
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}