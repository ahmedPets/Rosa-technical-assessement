import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'constants/strings.dart';
import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rosa Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Technical Assessment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _singleValue = kStringYes;
  String _dropDownValue = kStringListDropDown[1];

  void dropDownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
      });
    }
  }

  void _onRadioChanged(value) {
    setState(() {
      _singleValue = value as String;
    });
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 1));
    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }

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
                  color: kColorMain
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
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
                                  value: kStringYes,
                                  groupValue: _singleValue,
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
                                  value: kStringNo,
                                  groupValue: _singleValue,
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
                ),
                Column(
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
                          value: _dropDownValue,
                          onChanged: dropDownCallback,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 650,
              child: SfCalendar(
                showNavigationArrow: true,
                showCurrentTimeIndicator: true,
                backgroundColor: CupertinoColors.systemGrey6,
                view: CalendarView.workWeek,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  dateFormat: 'MMM d',
                  dayFormat: 'EEE',
                  timeFormat: 'HH:mm',
                  startHour: 8,
                  endHour: 17,
                  timeInterval: Duration(minutes: 30),
                ),
                dataSource: MeetingDataSource(_getDataSource()),
                // monthViewSettings: const MonthViewSettings(
                //   appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: ElevatedButton.icon(
                  label: const Text(kStringBook),
                  icon: const Icon(Icons.check),
                  onPressed: () => {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 50,
                      )
                    ),
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

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}