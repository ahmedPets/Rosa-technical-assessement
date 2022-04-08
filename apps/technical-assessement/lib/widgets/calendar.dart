import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:technical_assessement/constants/apis.dart';
import 'package:technical_assessement/constants/strings.dart';
import 'package:technical_assessement/data/meeting.dart';
import 'package:technical_assessement/models/slot.dart';
import 'package:technical_assessement/services/network.dart';

class Calendar extends StatefulWidget {
  final _CalendarState _calendarState = _CalendarState();
  DateTime? _selectedDate = null;

  Calendar({Key? key}) : super(key: key);

  void setMotive(String motive) {
    _calendarState.setState(() {
      _calendarState.motive = motive;
      _calendarState.meetings.clear();
      _calendarState._loadWeekAvailability();
    });
  }

  void setIsNewPatient(bool isNewPatient) {
    _calendarState.isNewPatient = isNewPatient;
  }

  DateTime? get selectedDate => _selectedDate;

  @override
  _CalendarState createState() => _calendarState;
}

class _CalendarState extends State<Calendar> {
  final ApiRequests requests = ApiRequests();
  final Map<String, Session> meetings = {};
  final Map<int, TimeRegion> _unavailableDates = {};
  late List<DateTime> _lastVisibleDates;
  String motive = kStringListDropDown[0];
  bool isNewPatient = false;

  void addAppointement(id, startTime, duration) {
    Color color;
    switch (motive) {
      case 'Cultural Fit':
        color = const Color(0xFFFF8644);
        break;
      case 'Introduction Call':
        color = const Color(0xFF0F86F4);
        break;
      default:
        color = const Color(0xFF0F8644);
        break;
    }
    if (!meetings.containsKey(id)) {
      final DateTime endTime = startTime.add(Duration(minutes: duration));
      meetings[id] = Session(id, motive, startTime, endTime, color);
    }
  }

  void _loadWeekAvailability() async {
    DateTime startTime = _lastVisibleDates[0];
    DateTime endTime = _lastVisibleDates[_lastVisibleDates.length - 1].add(const Duration(days: 1));

    var loadedSlots = await requests.getAvailableSlots(startTime, endTime, isNewPatient, kMotiveIds[motive]);
    Map<int, List<Slot>> availableDates = {};

    setState(() {
      for (var slot in loadedSlots) {
        if (slot.state == 'booked') {
          addAppointement(slot.id, slot.startAt, slot.duration);
        }

        int day = slot.startAt.weekday;
        if (!availableDates.containsKey(day)) {
          availableDates[day] = [];
        }
        availableDates[day]?.add(slot);
      }

      parseSlots(availableDates);
    });
  }

  void parseSlots(Map<int, List<Slot>> availableDates) {
    for (var day in _lastVisibleDates) {
      int allDayMinutes = 540;
      day = day.add(const Duration(hours: 8));
      if (availableDates.containsKey(day.weekday)) {
        var slots = availableDates[day.weekday];
        for (var slot in slots!) {
          if (slot.startAt.isAfter(day)) {
            int duration = slot.startAt.difference(day).inMinutes;
            allDayMinutes -= duration;
            addToUnvailableDates(day, duration);
          }
          allDayMinutes -= slot.duration;
          day = slot.startAt.add(Duration(minutes: slot.duration));
        }
      }
      if (allDayMinutes > 0) {
        addToUnvailableDates(day, allDayMinutes);
      }
    }
  }

  void addToUnvailableDates(DateTime startTime, duration) {
    int key = startTime.millisecondsSinceEpoch;
    if (_unavailableDates.containsKey(key)) {
      return;
    }

    _unavailableDates[key] = TimeRegion (
      startTime: startTime,
      endTime: startTime.add(Duration(minutes: duration)),
      enablePointerInteraction: false,        
      color: Colors.grey.withOpacity(0.2),
      text: 'Unavailable',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        dataSource: AppointmentDataSource(meetings.values.toList()),
        onTap: (CalendarTapDetails details) {
          setState(() {
            widget._selectedDate = details.date;
          });
        },
        onViewChanged: (ViewChangedDetails details) {
          _lastVisibleDates = details.visibleDates;
          _loadWeekAvailability();
        },
        specialRegions: _unavailableDates.values.toList(),
      ),
    );
  }
}